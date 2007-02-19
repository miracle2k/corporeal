unit ApplicationSettings;

interface

uses
  Classes;

type
  TPatronusSettings = class(TPersistent)
  private
    FDefaultStore: string;
    procedure SetDefaultStore(const Value: string);
  published
  public
    constructor Create; virtual;
  published
    property DefaultStore: string read FDefaultStore write SetDefaultStore;
  end;

implementation

{ TPatronusSettings }

constructor TPatronusSettings.Create;
begin
  DefaultStore := '';
end;

procedure TPatronusSettings.SetDefaultStore(const Value: string);
begin
  FDefaultStore := Value;
end;

end.
