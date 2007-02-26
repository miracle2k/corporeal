unit OpenStoreFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, JvExControls, JvLabel,
  JvGradientProgressBarEx, JvExStdCtrls, JvCheckBox, gnugettext, Buttons,
  PngSpeedButton, JvEdit;

type
  TOpenStoreMode = (osmLoad, osmCreate, osmChangeKey);

  TOpenStoreForm = class(TForm)
    Bevel2: TBevel;
    Panel1: TPanel;
    FormHeaderLabel: TLabel;
    Bevel1: TBevel;
    LoadButton: TButton;
    SelectedStoreLabel: TLabel;
    StoreFilenameLabel: TJvLabel;
    KeyLabel: TLabel;
    CreateNewButton: TButton;
    ChangeButton: TButton;
    KeyEdit: TJvEdit;
    SelectStoreDialog: TOpenDialog;
    CreateStoreDialog: TSaveDialog;
    QualityLabel: TLabel;
    Image1: TImage;
    MakeDefaultCheckBox: TJvCheckBox;
    TogglePasswordCharButton: TPngSpeedButton;
    CancelButton: TButton;
    procedure ChangeButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateNewButtonClick(Sender: TObject);
    procedure KeyEditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
    procedure TogglePasswordCharButtonClick(Sender: TObject);
  private
    QualityIndicatorBar: TJvGradientProgressBarEx;
    NewStoreKey: string; 
  private
    FCurrentDefaultFile: string;
    FSelectedStoreFile: string;
    FMode: TOpenStoreMode;
    FConfirmationMode: Boolean;
    FDefaultMode: TOpenStoreMode;
    procedure SetKey(const Value: string);
    procedure SetCurrentDefaultFile(const Value: string);
    function GetMakeDefault: Boolean;
    procedure SetMakeDefault(const Value: Boolean);
    procedure SetSelectedStoreFile(const Value: string);
    function GetKey: string;
    procedure SetMode(const Value: TOpenStoreMode);
    procedure SetConfirmationMode(const Value: Boolean);
    procedure SetDefaultMode(const Value: TOpenStoreMode);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  protected
    procedure UpdateInterface;
    procedure UpdateQualityIndicator;
  protected
    // Some modes, like osmCreate and osmChange, require a key to be confirmed
    property ConfirmationMode: Boolean read FConfirmationMode write SetConfirmationMode;
  public
    constructor Create(AOwner: TComponent; ADefaultMode: TOpenStoreMode); reintroduce;
  public
    procedure Reset;
  public
    property SelectedStoreFile: string read FSelectedStoreFile write SetSelectedStoreFile;
    property CurrentDefaultFile: string read FCurrentDefaultFile write SetCurrentDefaultFile;
    property Key: string read GetKey write SetKey;
    property Mode: TOpenStoreMode read FMode write SetMode;
    property DefaultMode: TOpenStoreMode read FDefaultMode write SetDefaultMode;
    property MakeDefault: Boolean read GetMakeDefault write SetMakeDefault;
  end;

var
  OpenStoreForm: TOpenStoreForm;

implementation

uses
  TaskDialog,
  Core, Utilities, VistaCompat;

{$R *.dfm}

constructor TOpenStoreForm.Create(AOwner: TComponent; ADefaultMode: TOpenStoreMode);
begin
  DefaultMode := ADefaultMode;
  FMode := DefaultMode;

  // calls FormCreate
  inherited Create(AOwner);
end;

procedure TOpenStoreForm.CreateNewButtonClick(Sender: TObject);
begin
  if CreateStoreDialog.Execute then
  begin
    SelectedStoreFile := CreateStoreDialog.Filename;
    Mode := osmCreate;
    KeyEdit.SetFocus;
  end;
end;

procedure TOpenStoreForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  // Show taskbar button, except when in "change key" mode
  if Mode <> osmChangeKey then
    Params.ExStyle := Params.ExStyle and not WS_EX_TOOLWINDOW or WS_EX_APPWINDOW;
end;

procedure TOpenStoreForm.ChangeButtonClick(Sender: TObject);
begin
  if SelectStoreDialog.Execute then
  begin
    SelectedStoreFile := SelectStoreDialog.Filename;
    Mode := osmLoad;
    KeyEdit.SetFocus;    
  end;
end;

procedure TOpenStoreForm.FormCreate(Sender: TObject);
begin
  // localize
  TranslateComponent(Self);

  // use font setting of os (mainly intended for new vista font)
  SetDesktopIconFonts(Self.Font);  

  // create quality indicater control
  QualityIndicatorBar := TJvGradientProgressBarEx.Create(Self);
  QualityIndicatorBar.BarColorFrom := $000080FF;  // orange
  QualityIndicatorBar.BarColorTo := clLime;
  QualityIndicatorBar.SetBounds(126, 116, 257, 19);
  QualityIndicatorBar.Parent := Self;

  // init dialogs
  SelectStoreDialog.Filter := _(PatronusFilter)+'|*.patronus|'+_(AllFilesFilter)+'|*.*';
  SelectStoreDialog.DefaultExt := 'patronus';
  CreateStoreDialog.Filter := SelectStoreDialog.Filter;
  CreateStoreDialog.DefaultExt := SelectStoreDialog.DefaultExt;

  // init some other stuff
  TogglePasswordCharButton.Hint := _(TogglePasswordCharHint);
  CancelButton.Left := LoadButton.Left - CancelButton.Width - 5;

  // default values
  Reset;
end;

procedure TOpenStoreForm.FormShow(Sender: TObject);
begin
  // Auto set focus to key input for convienience
  if KeyEdit.Visible then
    KeyEdit.SetFocus;
end;

function TOpenStoreForm.GetKey: string;
begin
  Result := KeyEdit.Text;
end;

function TOpenStoreForm.GetMakeDefault: Boolean;
begin
  Result := MakeDefaultCheckBox.Checked;
end;

procedure TOpenStoreForm.KeyEditChange(Sender: TObject);
begin
  UpdateQualityIndicator;
end;

procedure TOpenStoreForm.LoadButtonClick(Sender: TObject);
begin
  // for some modes, we do need to confirm the entered key
  if ((Mode = osmCreate) or (Mode = osmChangeKey)) and (not ConfirmationMode) then
  begin
    NewStoreKey := Key;
    ConfirmationMode := True;
  end
  // otherwise, check if keys match, and if yes, return OK
  else if ((Mode = osmCreate) or (Mode = osmChangeKey)) then
  begin
    if NewStoreKey = Key then
      ModalResult := mrOk
    else
    begin
      with TTaskDialog.Create(Self) do begin
        DialogPosition := dpScreenCenter;
        Title := _('Error');
        Instruction := _('Keys do not match.');
        if Mode = osmCreate then        
          Content := _('You entered two different keys for the new store. Please '+
            'try again, or click ''Create New'' to restart the procedure and choose '+
            'a new key.')
        else
          Content := _('You entered two different keys. Please try again. Click cancel '+
            'if you decide not to change the master key of this store.');
        Icon := tiError;
        Execute;
      end;
      Key := '';
      KeyEdit.SetFocus;
    end;
  end
  // if  mode = load, then go ahead and try with current key 
  else if Mode = osmLoad then
  begin
    ModalResult := mrOk;
  end;
end;

procedure TOpenStoreForm.Reset;
begin
  // Default values
  SelectedStoreFile := '';
  CurrentDefaultFile := '';
  Mode := DefaultMode;
  Key := '';
  NewStoreKey := '';
  ConfirmationMode := False;
end;

procedure TOpenStoreForm.SetConfirmationMode(const Value: Boolean);
begin
  FConfirmationMode := Value;
  // clear current key
  Key := '';
  // update the interface and focus the key edit automatically
  UpdateInterface;
  if KeyEdit.CanFocus then KeyEdit.SetFocus;
end;

procedure TOpenStoreForm.SetCurrentDefaultFile(const Value: string);
begin
  if FileExists(Value) then
  begin
    FCurrentDefaultFile := Value;
    // if no store is selected yet, auto use the default
    if SelectedStoreFile = '' then
      SelectedStoreFile := Value;
  end;
end;

procedure TOpenStoreForm.SetDefaultMode(const Value: TOpenStoreMode);
begin
  FDefaultMode := Value;
end;

procedure TOpenStoreForm.SetKey(const Value: string);
begin
  // bug in JvEdit? if ProtectedPasswords=True, this doesn't function.
  // try to work around it for now, but we need this fixed later
  // TODO: our own ProtectPasswords/Secure Edit implementation?
  KeyEdit.ProtectPassword := False;
  KeyEdit.Text := Value;
  KeyEdit.ProtectPassword := True;  
end;

procedure TOpenStoreForm.SetMakeDefault(const Value: Boolean);
begin
  MakeDefaultCheckBox.Checked := Value;
end;

procedure TOpenStoreForm.SetMode(const Value: TOpenStoreMode);
begin
  FMode := Value;
  
  // Reset entered key value
  Key := '';
  NewStoreKey := '';
  // Reset Password Char setting
  TogglePasswordCharButton.Down := True;
  TogglePasswordCharButtonClick(nil);

  UpdateInterface;
end;

procedure TOpenStoreForm.SetSelectedStoreFile(const Value: string);
begin
  FSelectedStoreFile := Value;
  UpdateInterface;
  MakeDefaultCheckBox.Checked := Value = CurrentDefaultFile;
end;

procedure TOpenStoreForm.TogglePasswordCharButtonClick(Sender: TObject);
begin
  KeyEdit.ThemedPassword := TogglePasswordCharButton.Down;
end;

procedure TOpenStoreForm.UpdateInterface;
begin
  // Depending on current mode, change visibility/enabled state of some controls
  ChangeButton.Visible := Mode <> osmChangeKey;
  CreateNewButton.Visible := Mode <> osmChangeKey;
  MakeDefaultCheckBox.Visible := Mode <> osmChangeKey;
  CancelButton.Visible := Mode = osmChangeKey;
  TogglePasswordCharButton.Visible := (Mode = osmChangeKey) or (Mode = osmCreate);
  QualityIndicatorBar.Visible := (Mode = osmChangeKey) or (Mode = osmCreate);
  QualityLabel.Visible := (Mode = osmChangeKey) or (Mode = osmCreate);
  UpdateQualityIndicator;

  // Depending on wether a store is selected, show/hide/disable/enable stuff 
  if SelectedStoreFile <> '' then
  begin
    StoreFilenameLabel.Caption := SelectedStoreFile;
    StoreFilenameLabel.Hint := SelectedStoreFile;
    KeyLabel.Visible := True;
    KeyEdit.Visible := True;
    LoadButton.Enabled := True;
    MakeDefaultCheckBox.Enabled := True;
  end
  else begin
    StoreFilenameLabel.Caption := _('(none)');
    QualityLabel.Visible := False;
    KeyLabel.Visible := False;
    KeyEdit.Visible := False;
    LoadButton.Enabled := False;
    MakeDefaultCheckBox.Enabled := False;
  end;

  // Set caption
  if Mode = osmChangeKey then
    Caption := _('Change Master Key')
  else
    Caption := _('Choose / Create Password Store');

  // Depending on current mode, change captions
  if (Mode = osmCreate) then
  begin
    LoadButton.Caption := _('Create');
    FormHeaderLabel.Caption := _('Create New Password Store');
    SelectedStoreLabel.Caption := _('Store To Create:');
    if not ConfirmationMode then
      KeyLabel.Caption := _('Choose Key:')
    else
      KeyLabel.Caption := _('Confirm Key:');
  end
  else if Mode = osmChangeKey then
  begin
    FormHeaderLabel.Caption := Caption;
    LoadButton.Caption := _('Change');
    SelectedStoreLabel.Caption := _('Current Store:');
    KeyLabel.Caption := _('New Key:');
  end else
  // osmLoad
  begin
    KeyLabel.Caption := _('Enter Key:');
    LoadButton.Caption := _('Load');
    SelectedStoreLabel.Caption := _('Selected Store:');
    FormHeaderLabel.Caption := _('Open Password Store');
  end;
end;

procedure TOpenStoreForm.UpdateQualityIndicator;
const
  QualityMaxBits = 132;
var
  EstimatedBits: Integer;
begin
  EstimatedBits := EstimatePasswordBits(KeyEdit.Text);
  with QualityIndicatorBar do begin
    Max := QualityMaxBits;
    Position := EstimatedBits+1;
  end;
  QualityLabel.Caption := Format(_('%s bits'), [IntToStr(EstimatedBits)]);
end;

end.
