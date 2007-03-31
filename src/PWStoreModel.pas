{-----------------------------------------------------------------------------
The contents of this file are subject to the GNU General Public License
Version 2.0 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.gnu.org/copyleft/gpl.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Initial Developer of the Original Code is Michael Elsdörfer.
All Rights Reserved.

$Id$

You may retrieve the latest version of this file at the Patronus
Website, located at http://www.elsdoerfer.info/patronus

Known Issues:
-----------------------------------------------------------------------------}

unit PWStoreModel;

interface

uses
  SysUtils, Classes,

  DCPrijndael, DCPsha512;

type
  // A single username/password combination
  TPWItem = class
  private
    FID: Cardinal;
    FNotes: WideString;
    FTitle: WideString;
    FPassword: WideString;
    FURL: WideString;
    FUsername: WideString;
    FCreationTime: TDateTime;
    function GetID: Cardinal;
    procedure SetNotes(const Value: WideString);
    procedure SetPassword(const Value: WideString);
    procedure SetTitle(const Value: WideString);
    procedure SetURL(const Value: WideString);
    procedure SetUsername(const Value: WideString);
    procedure SetCreationTime(const Value: TDateTime);
  public
    constructor Create(ItemID: Cardinal); virtual;
    destructor Destroy; override;
  public
    property ID: Cardinal read GetID;
    property Title: WideString read FTitle write SetTitle;
    property Username: WideString read FUsername write SetUsername;
    property Password: WideString read FPassword write SetPassword;
    property URL: WideString read FURL write SetURL;
    property Notes: WideString read FNotes write SetNotes;
    property CreationTime: TDateTime read FCreationTime write SetCreationTime;
  end;

  // In order to synchronize between multiple computers, we log each and
  // every operation.
  TPWStoreOperationType = (soAdd, soUpdate, soDelete);
  TPWStoreOperation = record
    Index: Integer;  // must be unique, each index = one revision
    Item: TPWItem;
    &Type: TPWStoreOperationType;
  end;
  PPWStoreOperation = ^TPWStoreOperation;
  TPWStoreOperationLog = class
  private
    FOperationLog: TList;
  protected
    procedure Clear;
    procedure Add(Operation: TPWStoreOperationType; Item: TPWItem);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

  // Stores a list of password items
  TPWItemStore = class
  private
    function GetItems(Index: Integer): TPWItem;
    procedure SetItems(Index: Integer; const Value: TPWItem);
    function GetCount: Integer;
  private
    FItems: TList;
    FLastAutoID: Cardinal;
    FStoreFileStream: TFileStream;
  protected
    function NextID: Cardinal;
    procedure CloseOpenFilestream;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    procedure Clear;
    procedure Close;
    function Add: TPWItem;
    function Remove(Item: TPWItem): Integer;
    procedure SaveToFile(AFilename, APassword: string);
    procedure LoadFromFile(AFilename, APassword: string);
  public
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPWItem read GetItems write SetItems;
  end;

implementation

const
  PWDB_HEADER = 'PWDB';
var
  PWDB_VERSION: Integer = 1;

{ TPWItem }

constructor TPWItem.Create(ItemID: Cardinal);
begin
  FID := ItemID;
  FCreationTime := 0;
end;

destructor TPWItem.Destroy;
begin
  inherited;
end;

function TPWItem.GetID: Cardinal;
begin
  Result := FID;
end;

procedure TPWItem.SetCreationTime(const Value: TDateTime);
begin
  FCreationTime := Value;
end;

procedure TPWItem.SetNotes(const Value: WideString);
begin
  FNotes := Value;
end;

procedure TPWItem.SetPassword(const Value: WideString);
begin
  FPassword := Value;
end;

procedure TPWItem.SetTitle(const Value: WideString);
begin
  FTitle := Value;
end;

procedure TPWItem.SetURL(const Value: WideString);
begin
  FURL := Value;
end;

procedure TPWItem.SetUsername(const Value: WideString);
begin
  FUsername := Value;
end;

{ TPWItemStore }

function TPWItemStore.Add: TPWItem;
begin
  Result := TPWItem.Create(NextID);
  Result.CreationTime := Now;
  FItems.Add(Result);
end;

procedure TPWItemStore.Clear;
var
  I: Integer;
begin
  try
    for I := 0 to Count - 1 do
      Items[I].Free;
  finally
    FItems.Clear;
  end;
end;

procedure TPWItemStore.Close;
begin
  try
    Clear;
  finally
    CloseOpenFilestream;
  end;
end;

procedure TPWItemStore.CloseOpenFilestream;
begin
  if FStoreFileStream <> nil then
  begin
    FreeAndNil(FStoreFileStream);
    FStoreFileStream := nil;
  end;
end;

constructor TPWItemStore.Create;
begin
  FItems := TList.Create;
  FLastAutoID := 0;
  FStoreFileStream := nil;   
end;

destructor TPWItemStore.Destroy;
begin
  try
    Clear;
  finally
    FItems.Free;
  end;
  CloseOpenFilestream;
  inherited;
end;

function TPWItemStore.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TPWItemStore.GetItems(Index: Integer): TPWItem;
begin
  Result := FItems[Index];
end;

procedure TPWItemStore.LoadFromFile(AFilename, APassword: string);
var
  MemoryStream: TMemoryStream;
  AESCipher: TDCP_rijndael;
  I, NumItems: Integer;

  function ReadString(const Length: Integer = 0): string;
  var
    Lng: Integer;
  begin
    // no length specified, read from stream
    if Length = 0 then
      MemoryStream.ReadBuffer(Lng, SizeOf(Lng))
    else
      Lng := Length;
    // read string
    SetLength(Result, Lng);
    MemoryStream.ReadBuffer(Result[1], Lng);
  end;

  function ReadInteger: Integer;
  begin
    MemoryStream.ReadBuffer(Result, SizeOf(Result));
  end;
  function ReadFloat: Double;
  begin
    MemoryStream.ReadBuffer(Result, SizeOf(Result));
  end;

begin
  // clear all the current items
  Clear;
  
  // open the file and decrypt to memory stream
  CloseOpenFilestream;
  try
    FStoreFileStream := TFileStream.Create(AFilename, fmOpenReadWrite or fmShareExclusive);
    MemoryStream := TMemoryStream.Create;
    AESCipher := TDCP_rijndael.Create(nil);
    try
      AESCipher.InitStr(APassword, TDCP_sha512);
      AESCipher.DecryptStream(FStoreFileStream, MemoryStream, FStoreFileStream.Size);

      MemoryStream.Position := 0;

      // read header
      if ReadString(Length(PWDB_HEADER)) <> PWDB_HEADER then
        raise Exception.Create('Invalid header (might be wrong key)');
      if ReadInteger <> PWDB_VERSION then
        raise Exception.Create('Invalid file version');

      // read all the items
      NumItems := ReadInteger;
      for I := 0 to NumItems - 1 do
        with Add do
        begin
          Title := ReadString;
          Username := ReadString;
          Password := ReadString;
          URL := ReadString;
          Notes := ReadString;
          CreationTime := ReadFloat;
        end;

      // read binlog
    finally
      MemoryStream.Free;
      AESCipher.Free;
      // do not close FStoreFileStream, keep the file open
    end;
  except
    on E: Exception do
    begin
      // if there was an error, make sure we close the file
      CloseOpenFilestream;
      // re-raise the exception
      raise;
    end;
  end;
end;

function TPWItemStore.NextID: Cardinal;
begin
  Inc(FLastAutoID);
  Result := FLastAutoID;
end;

function TPWItemStore.Remove(Item: TPWItem): Integer;
begin
  Result := FItems.Remove(Item);
  if Result >= 0 then Item.Free;
end;

procedure TPWItemStore.SaveToFile(AFilename, APassword: string);
var
  MemoryStream: TMemoryStream;
  AESCipher: TDCP_rijndael;
  I: Integer;

  procedure WriteString(AStr: string);
  var
    Lng: Integer;
  begin
    Lng := Length(Astr);
    MemoryStream.WriteBuffer(Lng, SizeOf(Lng));
    MemoryStream.WriteBuffer(AStr[1], Length(AStr));
  end;

  procedure WriteInteger(AInt: Integer);
  begin
    MemoryStream.WriteBuffer(AInt, SizeOf(AInt));
  end;
  procedure WriteFloat(AFloat: Double);
  begin
    MemoryStream.WriteBuffer(AFloat, SizeOf(AFloat));
  end;

begin
  // put together everything in memory first
  MemoryStream := TMemoryStream.Create;
  try
    // write header
    MemoryStream.WriteBuffer(PWDB_HEADER[1], Length(PWDB_HEADER));
    MemoryStream.WriteBuffer(PWDB_VERSION, SizeOf(PWDB_VERSION));

    // write all the items
    WriteInteger(Count);
    for I := 0 to Count - 1 do
    begin
      WriteString(Items[I].Title);
      WriteString(Items[I].Username);
      WriteString(Items[I].Password);
      WriteString(Items[I].URL);
      WriteString(Items[I].Notes);
      WriteFloat(Double(Items[I].CreationTime));
    end;

    // write binlog

    // now encrypt everything and output to file stream
    AESCipher := TDCP_rijndael.Create(nil);
    // use existing file stream, or create a new one
    if FStoreFileStream = nil then
      FStoreFileStream := TFileStream.Create(AFilename, fmCreate or fmShareExclusive)
    else begin
      FStoreFileStream.Size := 0;
      FStoreFileStream.Position := 0;
    end;
    
    try
      MemoryStream.Position := 0;
      AESCipher.InitStr(APassword, TDCP_sha512);
      AESCipher.EncryptStream(MemoryStream, FStoreFileStream, MemoryStream.Size)
    finally
      AESCipher.Free;
      // keep filestream open
    end;
  finally
    MemoryStream.Free;
  end;
end;

procedure TPWItemStore.SetItems(Index: Integer; const Value: TPWItem);
begin
  FItems[Index] := Value;
end;

{ TPWStoreOperationLog }

procedure TPWStoreOperationLog.Add(Operation: TPWStoreOperationType;
  Item: TPWItem);
var
  NewOp: PPWStoreOperation;
begin
  New(NewOp);
  NewOp.Index := 0;
  NewOp.Item := Item;
  NewOp.&Type := Operation;
  FOperationLog.Add(NewOp);
end;

procedure TPWStoreOperationLog.Clear;
var
  I: Integer;
begin
  for I := 0 to FOperationLog.Count - 1 do
    Dispose(FOperationLog[I]);
  FOperationLog.Clear;
end;

constructor TPWStoreOperationLog.Create;
begin
  FOperationLog := TList.Create;
end;

destructor TPWStoreOperationLog.Destroy;
begin
  Clear;
  FOperationLog.Free;
  inherited;
end;

end.
