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
