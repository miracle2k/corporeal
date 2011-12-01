{-----------------------------------------------------------------------------
The contents of this file are subject to the GNU General Public License
Version 2.0 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.gnu.org/copyleft/gpl.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Initial Developer of the Original Code is Michael Elsdörfer.
All Rights Reserved.

$Id$

You may retrieve the latest version of this file at the Corporeal
Website, located at http://www.elsdoerfer.info/corporeal

Known Issues:
-----------------------------------------------------------------------------}

unit PasswordGeneratorFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Mask, JvExMask, JvSpin,
  ExtCtrls, JvComponentBase, JvBalloonHint, gnugettext;

type
  TPasswordGeneratorForm = class(TForm)
    CharSpacesList: TCheckListBox;
    PasswordLengthEdit: TJvSpinEdit;
    TntLabel1: TLabel;
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
  Utilities, VistaCompat;

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

  // use font setting of os (mainly intended for new vista font)
  SetDesktopIconFonts(Self.Font);  

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
