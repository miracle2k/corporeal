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
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WebsiteLinkClick(Sender: TObject);
    procedure WebsiteLinkMouseLeave(Sender: TObject);
    procedure WebsiteLinkMouseEnter(Sender: TObject);
  end;

var
  AboutForm: TAboutForm;

implementation

uses
  Core;

{$R *.dfm}

procedure TAboutForm.FormClick(Sender: TObject);
begin
//JvScrollText1.Active := ;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  // Localize
  TranslateComponent(Self);

  AppNameLabel.Caption := AppShortName;
  VersionLabel.Caption := VersionStr;
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
