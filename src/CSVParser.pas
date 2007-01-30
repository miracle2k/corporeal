unit CSVParser;

// Very simple CSV parser unit, for now is specifically written to read
// CSV exports from Kee Password Safe, although it might be able to handle
// other's as well.
//
// Can handle rows that extend over multiple lines via an open quote (")

interface

uses
  Classes, SysUtils;

type
  TCSVItem = class
  private
    FLine: string;
    FFields: TStringList;
    function GetFields(Index: Integer): string;
    procedure SetFields(Index: Integer; const Value: string);
    function GetFieldCount: Integer;
  public
    constructor Create(ALineStr: string); virtual;
    destructor Destroy; override;
  public
    property Line: string read FLine;
    property FieldCount: Integer read GetFieldCount;
    property Fields[Index: Integer]: string read GetFields write SetFields;
  end;
  
  TCSVParser = class
  private
    FRequireFields: Integer;
    function GetItemCount: Integer;
    function GetItems(Index: Integer): TCSVItem;
    procedure SetItems(Index: Integer; const Value: TCSVItem);
    procedure SetRequireFields(const Value: Integer);
  private
    FItems: TList;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    procedure LoadAndParseFile(AFilename: string);
    procedure Clear;
  public
    property RequireFields: Integer read FRequireFields write SetRequireFields;
    property Items[Index: Integer]: TCSVItem read GetItems write SetItems;
    property ItemCount: Integer read GetItemCount;
  end;

implementation

{ TCSVParser }

procedure TCSVParser.Clear;
var
  I: Integer;
begin
  try
    for I := 0 to FItems.Count - 1 do
      TCSVItem(FItems[I]).Free;
  finally
    FItems.Clear;
  end;
end;

constructor TCSVParser.Create;
begin
  FItems := TList.Create;
  RequireFields := 0;  // don't require a fixed number of fields
end;

destructor TCSVParser.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

function TCSVParser.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

function TCSVParser.GetItems(Index: Integer): TCSVItem;
begin
  Result := FItems[Index];
end;

procedure TCSVParser.LoadAndParseFile(AFilename: string);
var
  CSVFile: Textfile;
  Buffer, CurLine: WideString;
  LineCounter: Integer;
  NewItem: TCSVItem;
  I: Integer;
  InQuotes: Boolean;
begin
  AssignFile(CSVFile, AFilename);
  Reset(CSVFile);
  Clear;
  try
     // initialize state machine
     InQuotes := False;
     // loop until we reach the end of the file
     LineCounter := 0;
     while not Eof(CSVFile) do
     begin
       // read one line
       ReadLn(CSVFile, Buffer);
       CurLine := CurLine + Buffer;
       Inc(LineCounter);
       // parse through that line to see if it is extended to the
       // next line via quotes.
       for I := 1 to Length(Buffer) do
          if Buffer[I] = '"' then InQuotes := not InQuotes;
       if InQuotes then
         // we're eof and still have a quote open, add a linebreak to current line
         CurLine := CurLine + #13#10
       else
       begin
         // we completed one line, add it as an item and reset
         try
           NewItem := TCSVItem.Create(CurLine);
           // check the number of fields, if requested
           if (RequireFields <> 0) then
             if NewItem.FieldCount <> RequireFields then
               raise Exception.Create('Unexpected number of fields.');
               
           FItems.Add(NewItem);
           InQuotes := False;
           CurLine := '';
         except
           on E: Exception do
             raise Exception.Create('Line #'+IntToStr(LineCounter)+': '+E.Message);
         end;
       end;
     end;
  finally
    Close(CSVFile);
  end;
end;

procedure TCSVParser.SetItems(Index: Integer; const Value: TCSVItem);
begin
  FItems[Index] := Value;
end;

procedure TCSVParser.SetRequireFields(const Value: Integer);
begin
  FRequireFields := Value;
end;

{ TCSVItem }

constructor TCSVItem.Create(ALineStr: string);
begin
  FFields := TStringList.Create;
  FFields.CommaText := ALineStr;
end;

destructor TCSVItem.Destroy;
begin
  FFields.Free;
  inherited;
end;

function TCSVItem.GetFieldCount: Integer;
begin
  Result := FFields.Count;
end;

function TCSVItem.GetFields(Index: Integer): string;
begin
  Result := FFields[Index];
end;

procedure TCSVItem.SetFields(Index: Integer; const Value: string);
begin
  FFields[Index] := Value;
end;

end.
