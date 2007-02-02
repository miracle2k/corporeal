program patronus;

// gettext localizations
// store config / window positions etc
// about window
// config window

uses
  Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  PWStoreModel in 'PWStoreModel.pas',
  CSVParser in 'CSVParser.pas',
  ItemPropertiesFormUnit in 'ItemPropertiesFormUnit.pas' {ItemPropertiesForm},
  FormValidation in 'FormValidation.pas',
  Core in 'Core.pas',
  AboutFormUnit in 'AboutFormUnit.pas' {AboutForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := AppShortName;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
