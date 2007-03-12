program patronus;

{$R 'patronus.res' 'patronus.rc'}

uses
  ExceptionLog, ETypes,
  gnugettext,
  Forms,
  Graphics,
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
  VistaCompat in 'VistaCompat.pas';

  // translate all messages from eurekalog
  procedure TranslateEurekaLog;
  var
    I: Integer;
  begin
    for I := Integer(Low(TMessageType)) to Integer(High(TMessageType)) do
    begin
      with CurrentEurekaLogOptions do
        CustomizedTexts[TMessageType(I)] :=
          dgettext('eureka', CustomizedTexts[TMessageType(I)]);
    end;
  end;

begin
  // Exclude some stuff from translation
  TP_GlobalIgnoreClass(TFont);
  // Localize EurekaLog Messages
  TranslateEurekaLog;

  Application.Initialize;
  Application.Title := AppShortName;
  Application.CreateForm(TMainForm, MainForm);

  // Don't just show the form, intercept with custom logic
  Application.ShowMainForm := False;
  MainForm.TryToShow;

  Application.Run;
end.
