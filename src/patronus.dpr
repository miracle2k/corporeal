program patronus;

// gettext localizations
// store config / window positions etc
// config window
// vista ready
// pw generation wizard
// pw security quality indicator

uses
  Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  PWStoreModel in 'PWStoreModel.pas',
  CSVParser in 'CSVParser.pas',
  ItemPropertiesFormUnit in 'ItemPropertiesFormUnit.pas' {ItemPropertiesForm},
  FormValidation in 'FormValidation.pas',
  Core in 'Core.pas',
  AboutFormUnit in 'AboutFormUnit.pas' {AboutForm},
  ConfigFormUnit in 'ConfigFormUnit.pas' {ConfigForm},
  PasswordGeneratorFormUnit in 'PasswordGeneratorFormUnit.pas' {PasswordGeneratorForm},
  Utilities in 'Utilities.pas',
  JvGradientProgressBarEx in 'JvGradientProgressBarEx.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := AppShortName;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
