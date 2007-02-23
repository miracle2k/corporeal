unit ConfigFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExStdCtrls, JvGroupBox, TntStdCtrls, pngimage, ExtCtrls,
  gnugettext;

type
  TConfigForm = class(TForm)
    JvGroupBox1: TJvGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Image1: TImage;
    TntLabel1: TTntLabel;
    procedure FormCreate(Sender: TObject);
  end;

var
  ConfigForm: TConfigForm;

implementation

uses
  VistaCompat;

{$R *.dfm}

procedure TConfigForm.FormCreate(Sender: TObject);
begin
  // Localize
  TranslateComponent(Self);

  // use font setting of os (mainly intended for new vista font)
  SetDesktopIconFonts(Self.Font);    
end;

end.
