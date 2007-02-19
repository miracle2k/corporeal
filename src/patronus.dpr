program patronus;

// gettext localizations
// store config / window positions etc
// config window
// vista ready

uses
  Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  PWStoreModel in 'PWStoreModel.pas',
  ItemPropertiesFormUnit in 'ItemPropertiesFormUnit.pas' {ItemPropertiesForm},
  FormValidation in 'FormValidation.pas',
  Core in 'Core.pas',
  AboutFormUnit in 'AboutFormUnit.pas' {AboutForm},
  ConfigFormUnit in 'ConfigFormUnit.pas' {ConfigForm},
  PasswordGeneratorFormUnit in 'PasswordGeneratorFormUnit.pas' {PasswordGeneratorForm},
  Utilities in 'Utilities.pas',
  JvGradientProgressBarEx in 'JvGradientProgressBarEx.pas',
  OpenStoreFormUnit in 'OpenStoreFormUnit.pas' {OpenStoreForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := AppShortName;
  Application.ShowMainForm := False;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
