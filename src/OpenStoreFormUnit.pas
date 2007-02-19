unit OpenStoreFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, JvExControls, JvLabel,
  JvGradientProgressBarEx;

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
    procedure SetKey(const Value: string);
  protected
    procedure UpdateInterface;
    procedure UpdateQualityIndicator;
  public
    procedure Reset;
  public
    property SelectedStoreFile: string read FSelectedStoreFile write SetSelectedStoreFile;
    property Key: string read GetKey write SetKey;
    property Mode: TOpenStoreMode read FMode write SetMode;
  end;

var
  OpenStoreForm: TOpenStoreForm;

implementation

uses
  Utilities;

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
begin
  // create quality indicater control
  QualityIndicatorBar := TJvGradientProgressBarEx.Create(Self);
  QualityIndicatorBar.BarColorFrom := $000080FF;  // orange
  QualityIndicatorBar.BarColorTo := clLime;
  QualityIndicatorBar.SetBounds(100, 116, 235, 19);
  QualityIndicatorBar.Parent := Self;

  // Init dialogs
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

procedure TOpenStoreForm.KeyEditChange(Sender: TObject);
begin
  UpdateQualityIndicator;
end;

procedure TOpenStoreForm.Reset;
begin
  // Default values
  SelectedStoreFile := '';
  Mode := osmLoad;
  Key := '';
end;

procedure TOpenStoreForm.SetKey(const Value: string);
begin
  KeyEdit.Text := Value;
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
      KeyLabel.Caption := 'Enter Key:';
      LoadButton.Caption := 'Load';
      QualityIndicatorBar.Visible := False;
      QualityLabel.Visible := False;
    end else
    begin
      KeyLabel.Caption := 'Choose Key:';
      LoadButton.Caption := 'Create';
      QualityIndicatorBar.Visible := True;
      QualityLabel.Visible := True;
      UpdateQualityIndicator;
    end;
    KeyLabel.Visible := True;
    KeyEdit.Visible := True;
    LoadButton.Enabled := True;
  end else
  begin
    StoreFilenameLabel.Caption := '(none)';
    QualityIndicatorBar.Visible := False;
    QualityLabel.Visible := False;
    LoadButton.Caption := 'Load';
    KeyLabel.Visible := False;
    KeyEdit.Visible := False;
    LoadButton.Enabled := False;
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
  QualityLabel.Caption := IntToStr(EstimatedBits)+' bits';
end;

end.
