unit PWStoreModel;

interface

uses
  Classes;

type
  // A single username/password combination
  TPWItem = class
  private
    FNotes: WideString;
    FTitle: WideString;
    FPassword: WideString;
    FURL: WideString;
    FUsername: WideString;
    procedure SetNotes(const Value: WideString);
    procedure SetPassword(const Value: WideString);
    procedure SetTitle(const Value: WideString);
    procedure SetURL(const Value: WideString);
    procedure SetUsername(const Value: WideString);
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    property Title: WideString read FTitle write SetTitle;
    property Username: WideString read FUsername write SetUsername;
    property Password: WideString read FPassword write SetPassword;
    property URL: WideString read FURL write SetURL;
    property Notes: WideString read FNotes write SetNotes;
  end;

  // Stores a list of password items
  TPWItemStore = class
  private
    function GetItems(Index: Integer): TPWItem;
    procedure SetItems(Index: Integer; const Value: TPWItem);
    function GetCount: Integer;
  private
    FItems: TList;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  public
    procedure Clear;
    function Add: TPWItem;
  public
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TPWItem read GetItems write SetItems;
  end;

implementation

{ TPWItem }

constructor TPWItem.Create;
begin
end;

destructor TPWItem.Destroy;
begin
  inherited;
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
  Result := TPWItem.Create;
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

procedure TPWItemStore.SetItems(Index: Integer; const Value: TPWItem);
begin
  FItems[Index] := Value;
end;

end.
