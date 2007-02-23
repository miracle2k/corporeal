unit OpenStoreFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, JvExControls, JvLabel,
  JvGradientProgressBarEx, JvExStdCtrls, JvCheckBox, gnugettext;

type
  TOpenStoreMode = (osmLoad, osmCreate);

  TOpenStoreForm = class(TForm)
    Bevel2: TBevel;
    Panel1: TPanel;
    FormHeaderLabel: TLabel;
    Bevel1: TBevel;
    LoadButton: TButton;
    Label1: TLabel;
    StoreFilenameLabel: TJvLabel;
    KeyLabel: TLabel;
    Button2: TButton;
    Button3: TButton;
    KeyEdit: TEdit;
    SelectStoreDialog: TOpenDialog;
    CreateStoreDialog: TSaveDialog;
    QualityLabel: TLabel;
    Image1: TImage;
    MakeDefaultCheckBox: TJvCheckBox;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure KeyEditChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FSelectedStoreFile: string;
    FMode: TOpenStoreMode;
    procedure SetSelectedStoreFile(const Value: string);
    function GetKey: string;
    procedure SetMode(const Value: TOpenStoreMode);
  private
    QualityIndicatorBar: TJvGradientProgressBarEx;
    FCurrentDefaultFile: string;
    procedure SetKey(const Value: string);
    procedure SetCurrentDefaultFile(const Value: string);
    function GetMakeDefault: Boolean;
    procedure SetMakeDefault(const Value: Boolean);
  protected
    procedure UpdateInterface;
    procedure UpdateQualityIndicator;
  public
    procedure Reset;
  public
    property SelectedStoreFile: string read FSelectedStoreFile write SetSelectedStoreFile;
    property CurrentDefaultFile: string read FCurrentDefaultFile write SetCurrentDefaultFile;
    property Key: string read GetKey write SetKey;
    property Mode: TOpenStoreMode read FMode write SetMode;
    property MakeDefault: Boolean read GetMakeDefault write SetMakeDefault;
  end;

var
  OpenStoreForm: TOpenStoreForm;

implementation

uses
  Utilities, VistaCompat;

{$R *.dfm}

procedure TOpenStoreForm.Button2Click(Sender: TObject);
begin
  if CreateStoreDialog.Execute then
  begin
    SelectedStoreFile := CreateStoreDialog.Filename;
    Mode := osmCreate;
    KeyEdit.SetFocus;
  end;
end;

procedure TOpenStoreForm.Button3Click(Sender: TObject);
begin
  if SelectStoreDialog.Execute then
  begin
    SelectedStoreFile := SelectStoreDialog.Filename;
    Mode := osmLoad;
    KeyEdit.SetFocus;    
  end;
end;

procedure TOpenStoreForm.FormCreate(Sender: TObject);
resourcestring
   PatronusFilter = 'Patronus Store Files (*.patronus)';
   AllFilesFilter = 'All Files (*.*)';
begin
  // localize
  TranslateComponent(Self);

  // use font setting of os (mainly intended for new vista font)
  SetDesktopIconFonts(Self.Font);  

  // create quality indicater control
  QualityIndicatorBar := TJvGradientProgressBarEx.Create(Self);
  QualityIndicatorBar.BarColorFrom := $000080FF;  // orange
  QualityIndicatorBar.BarColorTo := clLime;
  QualityIndicatorBar.SetBounds(100, 116, 235, 19);
  QualityIndicatorBar.Parent := Self;

  // Init dialogs
  SelectStoreDialog.Filter := PatronusFilter+'|*.patronus|'+AllFilesFilter+'|*.*';
  SelectStoreDialog.DefaultExt := 'patronus';
  CreateStoreDialog.Filter := SelectStoreDialog.Filter;
  CreateStoreDialog.DefaultExt := SelectStoreDialog.DefaultExt;

  // Default values
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

procedure TOpenStoreForm.Reset;
begin
  // Default values
  SelectedStoreFile := '';
  CurrentDefaultFile := '';
  Mode := osmLoad;
  Key := '';
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

procedure TOpenStoreForm.SetKey(const Value: string);
begin
  KeyEdit.Text := Value;
end;

procedure TOpenStoreForm.SetMakeDefault(const Value: Boolean);
begin
  MakeDefaultCheckBox.Checked := Value;
end;

procedure TOpenStoreForm.SetMode(const Value: TOpenStoreMode);
begin
  FMode := Value;
  UpdateInterface;
end;

procedure TOpenStoreForm.SetSelectedStoreFile(const Value: string);
begin
  FSelectedStoreFile := Value;
  UpdateInterface;
  MakeDefaultCheckBox.Checked := Value = CurrentDefaultFile;
end;

procedure TOpenStoreForm.UpdateInterface;
begin
  if SelectedStoreFile <> '' then
  begin
    StoreFilenameLabel.Caption := SelectedStoreFile;
    StoreFilenameLabel.Hint := SelectedStoreFile;
    // Check if store file exists - if not, this is a new file and we need
    // to change the label of the master key input edit.
    if Mode = osmLoad then
    begin
      KeyLabel.Caption := _('Enter Key:');
      LoadButton.Caption := _('Load');
      QualityIndicatorBar.Visible := False;
      QualityLabel.Visible := False;
    end else
    begin
      KeyLabel.Caption := _('Choose Key:');
      LoadButton.Caption := _('Create');
      QualityIndicatorBar.Visible := True;
      QualityLabel.Visible := True;
      UpdateQualityIndicator;
    end;
    KeyLabel.Visible := True;
    KeyEdit.Visible := True;
    LoadButton.Enabled := True;
    MakeDefaultCheckBox.Enabled := True;
  end else
  begin
    StoreFilenameLabel.Caption := _('(none)');
    QualityIndicatorBar.Visible := False;
    QualityLabel.Visible := False;
    LoadButton.Caption := _('Load');
    KeyLabel.Visible := False;
    KeyEdit.Visible := False;
    LoadButton.Enabled := False;
    MakeDefaultCheckBox.Enabled := False;    
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
