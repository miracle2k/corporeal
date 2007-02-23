unit ApplicationSettings;

interface

uses
  Classes;

type
  TPatronusSettings = class(TPersistent)
  private
    FDefaultStore: string;
    FAutoLockAfter: Integer;
    procedure SetDefaultStore(const Value: string);
    procedure SetAutoLockAfter(const Value: Integer);
  published
  public
    constructor Create; virtual;
  published
    property DefaultStore: string read FDefaultStore write SetDefaultStore;
    property AutoLockAfter: Integer read FAutoLockAfter write SetAutoLockAfter;
  end;

implementation

{ TPatronusSettings }

constructor TPatronusSettings.Create;
begin
  DefaultStore := '';
  FAutoLockAfter := 10;
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
