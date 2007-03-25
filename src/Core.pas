unit Core;

interface

uses
  Windows,
  VersionInfo;

const
  AppShortName = 'Patronus';
  AppWebsiteUrl = 'http://www.elsdoerfer.info/patronus';
  function AppnameWithVersion: string;
  function AppVersion: string;

var
  // This will store our custom windows message we use to tell an already
  // existing instance to activate itself once a second is started up.
  // It is registered with windows in the init section of this unit.
  WM_INSTANCE_LIMIT_MESSAGE: DWORD;

// Commonly used strings
resourcestring
   XMLFilter = 'XML Files (*.xml)';
   AllFilesFilter = 'All Files (*.*)';
   PatronusFilter = 'Patronus Store Files (*.patronus)';

   TogglePasswordCharHint = 'Toggle Hide/Show Passwords';

implementation

function AppVersion: string;
begin
  Result := MakeVersionString(vsfFull);  
end;

function AppnameWithVersion: string;
begin
  Result := AppShortname+' '+MakeVersionString(vsfShort);
end;

initialization
  // Use guid as identifier
  WM_INSTANCE_LIMIT_MESSAGE :=
    RegisterWindowMessage('{18C01079-A5B4-490C-B9A1-791438C2B6A6}');

end.
