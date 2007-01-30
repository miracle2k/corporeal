unit ItemPropertiesFormUnit;

interface

uses
  FormValidation,
  
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TntStdCtrls, ExtCtrls, pngimage, Buttons, TntButtons,
  PngSpeedButton, JvExControls, JvGradient, JvProgressBar, JvComponentBase,
  JvBalloonHint;

type
  TItemPropertiesForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    TitleEdit: TTntEdit;
    UsernameEdit: TTntEdit;
    PasswordEdit: TTntEdit;
    Label6: TLabel;
    PasswordRepeatEdit: TTntEdit;
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
    QualityIndicatorBar: TJvGradientProgressBar;
    Label8: TLabel;
    BalloonHint: TJvBalloonHint;
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PasswordEditChange(Sender: TObject);
    procedure TogglePasswordCharButtonClick(Sender: TObject);
  private
    FormValidator: TFormValidator;
    FEditMode: Boolean;
    procedure SetEditMode(const Value: Boolean);
    function ValidatePasswordMatchCallback(Value: string): Boolean;
  private
    procedure UpdateQualityIndicator;
  public
    property EditMode: Boolean read FEditMode write SetEditMode;
  end;

implementation

{$R *.dfm}

procedure TItemPropertiesForm.Button1Click(Sender: TObject);
begin
  if FormValidator.ValidateAll then
    ModalResult := mrOk
  else
    with FormValidator.FirstFailedRule do
      BalloonHint.ActivateHint(Control, Message+'.', 'Error');
end;

procedure TItemPropertiesForm.FormCreate(Sender: TObject);
begin
  UpdateQualityIndicator;
  EditMode := False;

  // initialize the form validator
  FormValidator := TFormValidator.Create;
  FormValidator.AddRule(TitleEdit, dvrNotEmptyTrim, 'Please specify a title for this entry');
  FormValidator.AddRule(PasswordEdit, ValidatePasswordMatchCallback, 'The passwords do not match');
  FormValidator.AddRule(PasswordRepeatEdit, ValidatePasswordMatchCallback, 'The passwords do not match');  
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
    FormHeaderLabel.Caption := 'Add New Item';
  end else
  begin
    FormHeaderLabel.Caption := 'Edit Item Properties';  
  end;
end;

procedure TItemPropertiesForm.TogglePasswordCharButtonClick(Sender: TObject);
begin
  if TogglePasswordCharButton.Down then begin
    PasswordEdit.PasswordChar := '*';
    PasswordRepeatEdit.PasswordChar := '*';
  end else begin
    PasswordEdit.PasswordChar := #0;
    PasswordRepeatEdit.PasswordChar := #0;
  end  
end;

procedure TItemPropertiesForm.UpdateQualityIndicator;
const
  QualityMaxBits = 132;
begin
  with QualityIndicatorBar do begin
    Max := QualityMaxBits;
    //Position := Pow(26,Length(PasswordEdit.Text));
  end;
end;

function TItemPropertiesForm.ValidatePasswordMatchCallback(
  Value: string): Boolean;
begin
  Result := PasswordEdit.Text = PasswordRepeatEdit.Text;
end;

end.
