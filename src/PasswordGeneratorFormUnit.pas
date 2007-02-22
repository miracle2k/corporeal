unit PasswordGeneratorFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, TntCheckLst, Mask, JvExMask, JvSpin, TntStdCtrls,
  ExtCtrls, JvComponentBase, JvBalloonHint, gnugettext;

type
  TPasswordGeneratorForm = class(TForm)
    CharSpacesList: TTntCheckListBox;
    PasswordLengthEdit: TJvSpinEdit;
    TntLabel1: TTntLabel;
    Bevel1: TBevel;
    Button2: TButton;
    Button1: TButton;
    JvBalloonHint: TJvBalloonHint;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function GetDrawSet: string;
    function GetRequestedLength: Integer;
  public
    property DrawSet: string read GetDrawSet;
    property RequestedLength: Integer read GetRequestedLength;
  end;

var
  PasswordGeneratorForm: TPasswordGeneratorForm;

implementation

uses
  Utilities;

{$R *.dfm}

{ TPasswordGeneratorForm }

procedure TPasswordGeneratorForm.Button1Click(Sender: TObject);
var
  I, SelectedCount: Integer;
begin
  SelectedCount := 0;
  for I := 0 to CharSpacesList.Count - 1 do
    if CharSpacesList.Checked[I] then
      Inc(SelectedCount);
       
  if SelectedCount > 0 then
    ModalResult := mrOk
  else
    JvBalloonHint.ActivateHint(CharSpacesList,
      'You''ll need to select at least one charset.', ikError, 'Error');
end;

procedure TPasswordGeneratorForm.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  // Localize
  TranslateComponent(Self);

  // per default, check the first three items
  for I := 0 to 2 do
    CharSpacesList.Checked[I] := True;
end;

function TPasswordGeneratorForm.GetDrawSet: string;
const
  // As in CharSpacesList.strings
  CharSpaces: array[0..7] of string = (
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
    'abcdefghijklmuopqrstufwxyz',
    '0123456789',
    '_',
    '-',
    ' ',
    '!§$%&/"''#*+~',
    '()[]{}'
  );
var
  I: Integer;
begin
  for I := 0 to CharSpacesList.Count - 1 do
    if CharSpacesList.Checked[I] then
      Result := Result + CharSpaces[I];
end;

function TPasswordGeneratorForm.GetRequestedLength: Integer;
begin
  Result := PasswordLengthEdit.AsInteger;
end;

end.
