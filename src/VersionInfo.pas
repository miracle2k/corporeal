unit VersionInfo;

// Depending on build mode, retrieve the actual version info from an include.

interface

uses
  SysUtils;

{
    What we expect from the include file:

    // Format:  MAJOR.MINOR-STRING.BUILD
    // Example: 1.5-rc2.434
    // -1 values will be ignored
    APP_VERSION_MAJOR    = -1;
    APP_VERSION_MINOR    = -1;
    APP_VERSION_IDENT    = 'ide-build';
    APP_VERSION_BUILD    = -1;
    // A codename for the version, e.g. "Longhorn"
    APP_VERSION_NAME     = '';
}

{$IFDEF AUTOMATED_BUILD}
  {$INCLUDE VersionInfoBuild.inc}
{$ELSE}
  {$INCLUDE VersionInfoIDE.inc}
{$ENDIF}

const
  // As the minor version is not simply a counter, we need to specify a
  // precision, which at the same time limits the maximum number of the
  // minor version. E.g., if this is set to "2", then a minor version of "1"
  // actually means "x.01", and "x.1" would be represented by a minor version
  // of "10". "3" digits would mean that a minor version of 1 actually means
  // "x.001". It is possible to change this number during the application
  // lifecycle, but then the meaning of all previously used version numbers
  // will change, so bear that in mind.
  MINOR_VERSION_DIGITS = 2;

type
  TVersionStringFormat = (
    vsfFull,     // major/minor/ident/build
    vsfLong,     // major/minor/ident
    vsfShort     // major/minor
  );

function MakeVersionString(AVersionFormat: TVersionStringFormat): string;

implementation

{$WARNINGS off}  // Prevent "Comparison always evaluates to True" for constant comparisons
function MakeVersionString(AVersionFormat: TVersionStringFormat): string;
var
  MinorStr: string;
  I: Integer;
begin
  Result := '';

  // Start off with major version
  if (APP_VERSION_MAJOR<>-1) then
  begin
    Result := Result+IntToStr(APP_VERSION_MAJOR);
    // No minor version without a major on
    if (APP_VERSION_MINOR<>-1) then
    begin
      // format minor version: add 0's at beginning, remove trailing ones
      MinorStr := Format('%.*d', [MINOR_VERSION_DIGITS, APP_VERSION_MINOR]);
      for I := Length(MinorStr) downto 2 do // downto 2 - never remove first char
        if MinorStr[I]='0' then Delete(MinorStr, I, 1)
        else Break;       

      Result := Result+'.'+MinorStr;
    end;
  end;

  // Ident
  if (APP_VERSION_IDENT<>'') then
  begin
    if Result <> '' then Result := Result+'-';
    Result := Result+APP_VERSION_IDENT;
  end;

  // Add build number
  if (APP_VERSION_BUILD<>-1) then
    Result := Result+'.'+IntToStr(APP_VERSION_BUILD);
end;
{$WARNINGS on}

end.
