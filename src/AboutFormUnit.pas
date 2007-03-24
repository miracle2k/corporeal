unit AboutFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pngimage, JvExControls, ShellApi, Credits,
  gnugettext;

type
  TAboutForm = class(TForm)
    OKButton: TButton;
    AppNameLabel: TLabel;
    VersionLabel: TLabel;
    WebsiteLink: TLabel;
    Image1: TImage;
    ScrollingCredits: TScrollingCredits;
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
  CreditsText =
'&b&uPatronus Password Store'#13#10+
'2006 by Michael Elsdörfer <elsdoerfer.info>'#13#10+
''#13#10+
''#13#10+
''#13#10+
'&bFor inspiration'#13#10+
''#13#10+
'KeePass Password Safe'#13#10+
''#13#10+
''#13#10+
'&bBuilt in Delphi'#13#10+
''#13#10+
''#13#10+
'&bComponents && Libraries'#13#10+
''#13#10+
'Toolbar 2000, TBX && SpTBX'#13#10+
'VirtualTreeView'#13#10+
'Indy'#13#10+
'DCPCiphers'#13#10+
'Tntware Unicode Controls'#13#10+
'PngDelphi'#13#10+
'ScrollingCredits'#13#10+
'JVCL && JCL'#13#10+
'Open XML'#13#10+
''#13#10+
''#13#10+
'&bApplication & Toolbar Icons'#13#10+
''#13#10+
'iconaholic.com'#13#10+
''#13#10+
''#13#10+
''#13#10+
''#13#10+
''#13#10+
''#13#10+
'"&iI saved Latin. What did you ever do?"';

{$R *.dfm}

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  // Localize
  TP_GlobalIgnoreClass(TScrollingCredits);  
  TranslateComponent(Self);

  // use font setting of os (mainly intended for new vista font)
  SetDesktopIconFonts(Self.Font);
  ScrollingCredits.CreditsFont.Assign(Self.Font); 

  // init gui
  AppNameLabel.Caption := AppShortName;
  VersionLabel.Caption := MakeVersionString(vsfFull);
  WebsiteLink.Caption := 'elsdoerfer.info/patronus';
  ScrollingCredits.Credits.Text := CreditsText;
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
