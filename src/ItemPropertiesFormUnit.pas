unit ItemPropertiesFormUnit;

interface

uses
  FormValidation, PWStoreModel,

  gnugettext,

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntStdCtrls, ExtCtrls, pngimage, Buttons, TntButtons,
  PngSpeedButton, JvExControls, JvGradientProgressBarEx, JvComponentBase,
  JvBalloonHint, JvProgressBar, JvExStdCtrls, JvEdit;

type
  TItemPropertiesForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    TitleEdit: TTntEdit;
    UsernameEdit: TTntEdit;
    PasswordEdit: TJvEdit;
    Label6: TLabel;
    PasswordRepeatEdit: TJvEdit;
    Label3: TLabel;
    NotesMemo: TTntMemo;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    Panel1: TPanel;
    Image1: TImage;
    FormHeaderLabel: TLabel;
    Bevel2: TBevel;
    Label7: TLabel;
    URLEdit: TTntEdit;
    TogglePasswordCharButton: TPngSpeedButton;
    TntSpeedButton2: TPngSpeedButton;
    Label8: TLabel;
    BalloonHint: TJvBalloonHint;
    QualityLabel: TLabel;
    procedure TntSpeedButton2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PasswordEditChange(Sender: TObject);
    procedure TogglePasswordCharButtonClick(Sender: TObject);
  private
    QualityIndicatorBar: TJvGradientProgressBarEx;
    FormValidator: TFormValidator;
    FEditMode: Boolean;
    procedure SetEditMode(const Value: Boolean);
    function ValidatePasswordMatchCallback(Value: string): Boolean;
  private
    procedure UpdateQualityIndicator;
  public
    procedure ApplyFromItem(AItem: TPWItem);
    procedure ApplyToItem(AItem: TPWItem);
  public
    property EditMode: Boolean read FEditMode write SetEditMode;
  end;

implementation

uses
  Core, Utilities, VistaCompat, PasswordGeneratorFormUnit;

{$R *.dfm}

procedure TItemPropertiesForm.ApplyFromItem(AItem: TPWItem);
begin
  TitleEdit.Text := AItem.Title;
  UsernameEdit.Text := AItem.Username;
  PasswordEdit.Text := AItem.Password;
  PasswordRepeatEdit.Text := AItem.Password;
  URLEdit.Text := AItem.URL;
  NotesMemo.Text := AItem.Notes;
end;

procedure TItemPropertiesForm.ApplyToItem(AItem: TPWItem);
begin
  AItem.Title := TitleEdit.Text;
  AItem.Username := UsernameEdit.Text;
  AItem.Password := PasswordEdit.Text;
  AItem.Password := PasswordRepeatEdit.Text;
  AItem.URL := URLEdit.Text;
  AItem.Notes := NotesMemo.Text;
end;

procedure TItemPropertiesForm.Button1Click(Sender: TObject);
begin
  if FormValidator.ValidateAll then
    ModalResult := mrOk
  else
    with FormValidator.FirstFailedRule do
      BalloonHint.ActivateHint(Control, Message+'.', ikError, _('Error'));
end;

procedure TItemPropertiesForm.FormCreate(Sender: TObject);
begin
  // Localize
  TranslateComponent(Self);

  // use font setting of os (mainly intended for new vista font)
  SetDesktopIconFonts(Self.Font);

  // create quality indicater control
  QualityIndicatorBar := TJvGradientProgressBarEx.Create(Self);
  QualityIndicatorBar.BarColorFrom := $000080FF;  // orange
  QualityIndicatorBar.BarColorTo := clLime;
  QualityIndicatorBar.SetBounds(90, 168, 196, 19);
  QualityIndicatorBar.Parent := Self;

  // initialize everything
  TogglePasswordCharButton.Hint := _(TogglePasswordCharHint);  
  TogglePasswordCharButtonClick(nil);
  UpdateQualityIndicator;
  EditMode := False;

  // initialize the form validator
  FormValidator := TFormValidator.Create;
  FormValidator.AddRule(TitleEdit, dvrNotEmptyTrim, _('Please specify a title for this entry'));
  FormValidator.AddRule(PasswordEdit, ValidatePasswordMatchCallback, _('The passwords do not match'));
  FormValidator.AddRule(PasswordRepeatEdit, ValidatePasswordMatchCallback, _('The passwords do not match'));  
end;

procedure TItemPropertiesForm.FormDestroy(Sender: TObject);
begin
  FormValidator.Free;
end;

procedure TItemPropertiesForm.PasswordEditChange(Sender: TObject);
begin
  UpdateQualityIndicator;
end;

procedure TItemPropertiesForm.SetEditMode(const Value: Boolean);
begin
  FEditMode := Value;
  if not EditMode then
  begin
    FormHeaderLabel.Caption := _('Add New Item');
  end else
  begin
    FormHeaderLabel.Caption := _('Edit Item Properties');  
  end;
end;

procedure TItemPropertiesForm.TntSpeedButton2Click(Sender: TObject);
var
  NewPassword: string;
begin
  with TPasswordGeneratorForm.Create(Self) do
  begin
    if ShowModal = mrOk then
    begin
      NewPassword := GenerateRandomPassword(Drawset, RequestedLength);
      PasswordEdit.Text := NewPassword;
      PasswordRepeatEdit.Text := NewPassword;
    end;
    Free;
  end;
end;

procedure TItemPropertiesForm.TogglePasswordCharButtonClick(Sender: TObject);
begin
  PasswordEdit.ThemedPassword := TogglePasswordCharButton.Down;
  PasswordRepeatEdit.ThemedPassword := TogglePasswordCharButton.Down;
  PasswordEdit.ProtectPassword := TogglePasswordCharButton.Down;
  PasswordRepeatEdit.ProtectPassword := TogglePasswordCharButton.Down;  
end;

procedure TItemPropertiesForm.UpdateQualityIndicator;
const
  QualityMaxBits = 132;
var
  EstimatedBits: Integer;
begin
  EstimatedBits := EstimatePasswordBits(PasswordEdit.Text);
  with QualityIndicatorBar do begin
    Max := QualityMaxBits;
    Position := EstimatedBits+1;
  end;
  QualityLabel.Caption := Format(_('%s bits'), [IntToStr(EstimatedBits)]);  
end;

function TItemPropertiesForm.ValidatePasswordMatchCallback(
  Value: string): Boolean;
begin
  Result := PasswordEdit.Text = PasswordRepeatEdit.Text;
end;

end.
