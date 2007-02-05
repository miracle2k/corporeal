unit PWStoreModel;

interface

uses
  Classes,

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
    function GetID: Cardinal;
    procedure SetNotes(const Value: WideString);
    procedure SetPassword(const Value: WideString);
    procedure SetTitle(const Value: WideString);
    procedure SetURL(const Value: WideString);
    procedure SetUsername(const Value: WideString);
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
  protected
    function NextID: Cardinal;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    procedure Clear;
    function Add: TPWItem;
    procedure SaveToFile(AFilename, APassword: string);
  public
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPWItem read GetItems write SetItems;
  end;

implementation

{ TPWItem }

constructor TPWItem.Create(ItemID: Cardinal);
begin
  FID := ItemID;
end;

destructor TPWItem.Destroy;
begin
  inherited;
end;

function TPWItem.GetID: Cardinal;
begin
  Result := FID;
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

constructor TPWItemStore.Create;
begin
   FItems := TList.Create;
   FLastAutoID := 0;
end;

destructor TPWItemStore.Destroy;
begin
  try
    Clear;
  finally
    FItems.Free;
  end;
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

function TPWItemStore.NextID: Cardinal;
begin
  Inc(FLastAutoID);
  Result := FLastAutoID;
end;

procedure TPWItemStore.SaveToFile(AFilename, APassword: string);
var
  MemoryStream: TMemoryStream;
  FileStream: TFileStream;
  AESCipher: TDCP_rijndael;
begin
  // put together everything in memory first
  MemoryStream := TMemoryStream.Create;
  try
    // write header

    // write all the items

    // write binlog

    // now encrypt everything and output to file stream
    AESCipher := TDCP_rijndael.Create(nil);
    FileStream := TFileStream.Create(AFilename, fmCreate);
    try
      MemoryStream.Position := 0;
      AESCipher.InitStr(APassword, TDCP_sha512);
      AESCipher.EncryptStream(MemoryStream, FileStream, MemoryStream.Size)
    finally
      AESCipher.Free;
      FileStream.Free;
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
