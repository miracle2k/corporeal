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

unit AboutFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, JvExControls, ShellApi, Credits,
  gnugettext;

type
  TAboutForm = class(TForm)
    ScrollingCredits: TScrollingCredits;
    BottomPanel: TPanel;
    OKButton: TButton;
    Panel1: TPanel;
    WebsiteLink: TLabel;
    VersionLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure WebsiteLinkClick(Sender: TObject);
    procedure WebsiteLinkMouseLeave(Sender: TObject);
    procedure WebsiteLinkMouseEnter(Sender: TObject);
  end;

var
  AboutForm: TAboutForm;

implementation

uses
  Core, VistaCompat, VersionInfo;

const
  CreditsString =
'&b&uCorporeal Password Store'#13#10+
'Version %VERSION%'#13#10+
''#13#10+
'2007-2011 by Michael Elsd'#246'rfer'#13#10+
'<michael@elsdoerfer.com>'#13#10+
''#13#10+
''#13#10+
''#13#10+
'&bBuilt in Delphi'#13#10+
''#13#10+
''#13#10+
''#13#10+
'&b&uComponents && Libraries'#13#10+
''#13#10+
'&iIn no particular order'#13#10+
''#13#10+
'&bToolbar2000'#13#10+
'By Jordan Russell'#13#10+
'&ijrsoftware.org'#13#10+
''#13#10+
'&bSpTBX'#13#10+
'By Robert Lee'#13#10+
'Licensed under MPL'#13#10+
'&iclub.telepolis.com/silverpointdev'#13#10+
''#13#10+
'&bVirtualTreeView'#13#10+
'By Mike Lischke and contributors'#13#10+
'Licensed under MPL'#13#10+
'&idelphi-gems.com'#13#10+
''#13#10+
'&bDCPCiphers'#13#10+
'By David Barton'#13#10+
'&icityinthesky.co.uk'#13#10+
''#13#10+
'&bJCL/JVCL'#13#10+
'Licensed under MPL'#13#10+
'&idelphi-jedi.org'#13#10+
''#13#10+
'&bPngComponents'#13#10+
'By Martijn Saly'#13#10+
'&ithany.org'#13#10+
''#13#10+
'&bOpenXML'#13#10+
'By Dieter Köhler'#13#10+
'Licensed under MPL'#13#10+
'&iphilo.de'#13#10+
''#13#10+
'&bEurekaLog'#13#10+
'By Fabio Dell''Aria'#13#10+
'&ieurekalog.com'#13#10+
''#13#10+
'&bTMS TaskDialog'#13#10+
'By TMS Software'#13#10+
'&itmssoftware.com'#13#10+
''#13#10+
''#13#10+
''#13#10+
''#13#10+
'&b&uInspired by'#13#10+
''#13#10+
'KeePass Password Store'#13#10+
''#13#10+
''#13#10+
''#13#10+
''#13#10+
'&b&uApplication Toolbar Icons'#13#10+
''#13#10+
'iconaholic.com'#13#10+
''#13#10+
''#13#10+
''#13#10+
'&b&uShoutouts'#13#10+
''#13#10+
'&iOther great software used'#13#10+
'&iduring this production'#13#10+
''#13#10+
'FinalBuilder'#13#10+
'InnoSetup'#13#10+
'SmartInspect'#13#10+
''#13#10+
''#13#10+
''#13#10+
''#13#10+
''#13#10+
''#13#10+
''#13#10+
''#13#10+
'&iI saved Latin. What did you ever do?';

{$R *.dfm}

procedure TAboutForm.FormCreate(Sender: TObject);
var
  C: string;
begin
  // localize
  TP_GlobalIgnoreClass(TScrollingCredits);  
  TranslateComponent(Self);

  // use font setting of os (mainly intended for new vista font)
  SetDesktopIconFonts(Self.Font);
  ScrollingCredits.CreditsFont.Assign(Self.Font); 

  // init gui
  Self.Caption := Format(_('About %s'), [AppShortName]);
  VersionLabel.Caption := Format(_('Version %s'), [MakeVersionString(vsfFull)]);
  WebsiteLink.Caption := 'elsdoerfer.com/corporeal';

  // Prepare credits string (replace version number etc)
  C := CreditsString;
  C := StringReplace(C, '%VERSION%', AppVersion, [rfIgnoreCase, rfReplaceAll]);
  ScrollingCredits.Credits.Text := C;
  ScrollingCredits.Animate := True;
end;

procedure TAboutForm.WebsiteLinkClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, '', AppWebsiteUrl, '', '', SW_SHOWNORMAL);
end;

procedure TAboutForm.WebsiteLinkMouseEnter(Sender: TObject);
begin
  with WebsiteLink.Font do Style := Style + [fsUnderline];
end;

procedure TAboutForm.WebsiteLinkMouseLeave(Sender: TObject);
begin
  with WebsiteLink.Font do Style := Style - [fsUnderline];
end;

end.


