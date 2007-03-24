unit Core;

interface

uses
  VersionInfo;

const
  AppShortName = 'Patronus';
  AppWebsiteUrl = 'http://www.elsdoerfer.info/patronus';
  function AppnameWithVersion: string;
  function AppVersion: string;

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

end.
