unit ConfigFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExStdCtrls, JvGroupBox, TntStdCtrls, pngimage, ExtCtrls;

type
  TConfigForm = class(TForm)
    JvGroupBox1: TJvGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Image1: TImage;
    TntLabel1: TTntLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConfigForm: TConfigForm;

implementation

{$R *.dfm}

end.
