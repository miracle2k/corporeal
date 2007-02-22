[Setup]
AppName=Patronus
; Don't use version for now, enable way to add this automatically via build process
AppVerName=Patronus
AppPublisher=Michael Elsdörfer
AppPublisherURL=http://www.elsdoerfer.info/patronus
AppSupportURL=http://www.elsdoerfer.info/patronus
AppUpdatesURL=http://www.elsdoerfer.info/patronus
DefaultDirName={pf}\Patronus
DefaultGroupName=Patronus
; We don't create a submenu
DisableProgramGroupPage=yes
AllowNoIcons=yes
OutputBaseFilename=patronus-setup
; relative to SourceDir
OutputDir=..\
Compression=lzma/max
SolidCompression=yes
SourceDir=..\build\output\

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs


[Icons]
Name: "{commonprograms}\Patronus"; Filename: "{app}\Patronus.exe"
Name: "{commondesktop}\Patronus"; Filename: "{app}\Patronus.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\Patronus.exe"; Description: "{cm:LaunchProgram,Patronus}"; Flags: nowait postinstall skipifsilent

