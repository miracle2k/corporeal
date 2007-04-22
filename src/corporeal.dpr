{-----------------------------------------------------------------------------
The contents of this file are subject to the GNU General Public License
Version 2.0 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.gnu.org/copyleft/gpl.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Initial Developer of the Original Code is Michael ElsdÃ¶rfer.
All Rights Reserved.

$Id$

You may retrieve the latest version of this file at the Corporeal
Website, located at http://www.elsdoerfer.info/corporeal

Known Issues:
-----------------------------------------------------------------------------}

program corporeal;

{$R 'corporeal.res' 'corporeal.rc'}

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


