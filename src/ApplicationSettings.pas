unit ApplicationSettings;

interface

uses
  Classes, SysUtils, Forms;

type
  TPatronusSettings = class(TPersistent)
  private
    FDefaultStore: string;
    FAutoLockAfter: Integer;
    procedure SetDefaultStore(const Value: string);
    procedure SetAutoLockAfter(const Value: Integer);
    function GetApplicationExePath: WideString;
    procedure SetApplicationExePath(const Value: WideString);
  published
  public
    constructor Create; virtual;
  published
    property DefaultStore: string read FDefaultStore write SetDefaultStore;
    property AutoLockAfter: Integer read FAutoLockAfter write SetAutoLockAfter;
    // This makes sure the path to the executable is automatically written to the registry
    property ApplicationExePath: WideString read GetApplicationExePath write SetApplicationExePath;    
  end;

implementation

{ TPatronusSettings }

constructor TPatronusSettings.Create;
begin
  DefaultStore := '';
  FAutoLockAfter := 10;
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

end.
