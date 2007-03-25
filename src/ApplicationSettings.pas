unit ApplicationSettings;

interface

uses
  Classes, SysUtils, Forms;

type
  TPatronusSettings = class(TPersistent)
  private
    FDefaultStore: string;
    FAutoLockAfter: Integer;
    FLimitToOneInstance: Boolean;
    procedure SetDefaultStore(const Value: string);
    procedure SetAutoLockAfter(const Value: Integer);
    function GetApplicationExePath: WideString;
    procedure SetApplicationExePath(const Value: WideString);
    procedure SetLimitToOneInstance(const Value: Boolean);
  published
  public
    constructor Create; virtual;
  published
    property DefaultStore: string read FDefaultStore write SetDefaultStore;
    property AutoLockAfter: Integer read FAutoLockAfter write SetAutoLockAfter;
    // This makes sure the path to the executable is automatically written to the registry
    property ApplicationExePath: WideString read GetApplicationExePath write SetApplicationExePath;
    property LimitToOneInstance: Boolean read FLimitToOneInstance write SetLimitToOneInstance;
  end;

function Settings: TPatronusSettings;

implementation

var
  InternalSettingsObj: TPatronusSettings = nil;

function Settings: TPatronusSettings;
begin
  if InternalSettingsObj = nil then
    InternalSettingsObj := TPatronusSettings.Create;
  Result := InternalSettingsObj;
end;

{ TPatronusSettings }

constructor TPatronusSettings.Create;
begin
  FDefaultStore := '';
  FAutoLockAfter := 10;
  FLimitToOneInstance := True;
end;

function TPatronusSettings.GetApplicationExePath: WideString;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

procedure TPatronusSettings.SetApplicationExePath(const Value: WideString);
begin
  // do not accept any values for this
end;

procedure TPatronusSettings.SetAutoLockAfter(const Value: Integer);
begin
  FAutoLockAfter := Value;
end;

procedure TPatronusSettings.SetDefaultStore(const Value: string);
begin
  FDefaultStore := Value;
end;

procedure TPatronusSettings.SetLimitToOneInstance(const Value: Boolean);
begin
  FLimitToOneInstance := Value;
end;

initialization

finalization
  if InternalSettingsObj <> nil then
    InternalSettingsObj.Free;

end.
