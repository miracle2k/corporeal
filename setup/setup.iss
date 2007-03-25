; Needs the Inno Setup Preprocessor, and requires some variables (version stuff etc.)
; to be defined via the command line. We could use some ifdef constructs to make it
; compile without those from the IDE as well, but it's not really needed so far.
;
; Here are the variables that are expected:
;   VersionStrShort   - e.g. 1.5 (major/minor)
;   VersionStrLong    - e.g. 1.5-rc1 (major/minor/ident)
;   VersionStrFull    - e.g. 1.5-rc1.3434 (major/minor/ident/build)
;   OutputFilename    - full path to were to put stuff, e.g. G:\myapp\setup.exe


; general constants
#define AppName "Patronus"
#define AppNameSystem "Patronus"       ; to be used in startmenu/directory names etc.
#define AppURL "http://www.elsdoerfer.info/patronus"

; macro to remove the path and the extension from a filename, e.g. "G:\myapp\setup.exe" => "setup"
#define ExtractBasename(str *S) \
  Local[1] = Copy(OutputFilename,RPos('\',OutputFilename)), \
  Local[1] = Copy(Local[1],1,RPos('.',Local[1])-1), \
  Local[1]


[Setup]
AppName={#AppName}
AppVerName={#AppName} {#VersionStrLong}
AppPublisher=Michael Elsdörfer
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}
DefaultDirName={pf}\{#AppNameSystem}
DefaultGroupName={#AppNameSystem}
; We don't create a submenu, only an icon
DisableProgramGroupPage=yes
AllowNoIcons=yes
; relative to SourceDir
OutputDir=..\
Compression=lzma/max
SolidCompression=yes
SourceDir=..\build\output\
; this one is tough, we need to extract the base filename
OutputBaseFilename={#ExtractBasename(OutputFilename)}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs

[Registry]
; create empty registry key, but do not write any values. we do this only so that
; the uninstaller will the delete the key (and all it's values), as our app
; stores some data in the registry.
Root: HKCU; Subkey: "Software\Patronus"; Flags: uninsdeletekey

[Icons]
Name: "{commonprograms}\{#AppNameSystem}"; Filename: "{app}\patronus.exe"
Name: "{commondesktop}\{#AppNameSystem}"; Filename: "{app}\patronus.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\patronus.exe"; Description: "{cm:LaunchProgram,{#AppName}}"; Flags: nowait postinstall skipifsilent

