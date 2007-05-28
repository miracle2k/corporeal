{-----------------------------------------------------------------------------
The contents of this file are subject to the GNU General Public License
Version 2.0 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.gnu.org/copyleft/gpl.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Initial Developer of the Original Code is Michael Elsdörfer.
All Rights Reserved.

$Id$

You may retrieve the latest version of this file at the Corporeal
Website, located at http://www.elsdoerfer.info/corporeal

Known Issues:
-----------------------------------------------------------------------------}

unit Core;

interface

uses
  Windows,
  VersionInfo;

const
  AppShortName = 'Corporeal';
  AppWebsiteUrl = 'http://www.elsdoerfer.info/corporeal';
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
   CorporealFilter = 'Corporeal Store Files (*.corporeal;*.patronus)';

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
