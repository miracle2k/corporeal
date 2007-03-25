program patronus;

{$R 'patronus.res' 'patronus.rc'}

uses
  ExceptionLog,
  GnuGetText,
  EurekaLogGetText,
  Forms,
  Graphics,
  Windows,
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  PWStoreModel in 'PWStoreModel.pas',
  ItemPropertiesFormUnit in 'ItemPropertiesFormUnit.pas' {ItemPropertiesForm},
  Core in 'Core.pas',
  AboutFormUnit in 'AboutFormUnit.pas' {AboutForm},
  ConfigFormUnit in 'ConfigFormUnit.pas' {ConfigForm},
  PasswordGeneratorFormUnit in 'PasswordGeneratorFormUnit.pas' {PasswordGeneratorForm},
  Utilities in 'Utilities.pas',
  JvGradientProgressBarEx in 'JvGradientProgressBarEx.pas',
  OpenStoreFormUnit in 'OpenStoreFormUnit.pas' {OpenStoreForm},
  ApplicationSettings in 'ApplicationSettings.pas',
  VistaCompat in 'VistaCompat.pas',
  VersionInfo in 'VersionInfo.pas';

begin
  // Exclude some stuff from translation
  TP_GlobalIgnoreClass(TFont);
  // Localize EurekaLog Messages
  GetTextTranslateEurekaLog();

  // Check if there is another instance (and if there is a limit in place)
  CreateMutex(nil, false, '{B61F4E9F-2C45-46CD-9771-79D484E843E0}');  // random guid
  // If that failed, there is another app running
  if GetLastError = ERROR_ALREADY_EXISTS then
  begin
    // we notify it to activate itself
    SendMessage(HWND_BROADCAST, WM_INSTANCE_LIMIT_MESSAGE, 0, 0);
    // we shut down
    Halt(0);
  end;

  // Boot up application
  Application.Initialize;
  Application.Title := AppShortName;
  Application.CreateForm(TMainForm, MainForm);

  // Don't just show the form, intercept with custom logic
  Application.ShowMainForm := False;
  MainForm.TryToShow;

  // Go!
  Application.Run;
end.
