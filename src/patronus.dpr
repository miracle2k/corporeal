program patronus;

// TODO: enable xml export

uses
  gnugettext,
  Forms,
  Graphics,
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
  OpenStoreFormUnit in 'OpenStoreFormUnit.pas' {OpenStoreForm},
  ApplicationSettings in 'ApplicationSettings.pas',
  VistaCompat in 'VistaCompat.pas';

{$R *.res}

begin
  // Exclude some stuff from translation
  TP_GlobalIgnoreClass(TFont);

  Application.Initialize;
  Application.Title := AppShortName;
  Application.CreateForm(TMainForm, MainForm);

  // Don't just show the form, intercept with custom logic
  Application.ShowMainForm := False;
  MainForm.TryToShow;

  Application.Run;
end.
