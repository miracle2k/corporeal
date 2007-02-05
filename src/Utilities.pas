unit Utilities;

interface

// Ported to Delphi from KeePass Password Safe (PwUtil.cpp)
function EstimatePasswordBits(Password: WideString): Integer;

// Extremely simple password generator, and not really "random".
function GenerateRandomPassword(DrawSet: string; PwLength: Integer): string;

implementation

uses
  SysUtils, Math, JclStrHashMap;

const CHARSPACE_ESCAPE      =  60;
const CHARSPACE_ALPHA       =  26;
const CHARSPACE_NUMBER      =  10;
const CHARSPACE_SIMPSPECIAL =  16;
const CHARSPACE_EXTSPECIAL  =  17;
const CHARSPACE_HIGH        =  112;

function EstimatePasswordBits(Password: WideString): Integer;
var
  I: Integer;
  PwLength: Integer;
  EffectiveLength: Double;
  CurChar: WideChar;
  HasChLower, HasChUpper, HasChNumber, HasChSimpleSpecial, HasChExtSpecial,
    HasChHigh, hasChEscape: Boolean;
  CharSpace: Integer;
  BitsPerChar: Double;  
  DiffFactor: Double;
  Diff: Integer;
  Differences, CharCounts: TStringHashMap;
  _int: PInteger;
  function FreeHashData(AUserData: PUserData; const AStr: string; var APtr: PData): Boolean;
  begin
    Dispose(APtr);
    Result := True;
  end;
begin
  Differences := TStringHashMap.Create(CaseSensitiveTraits, 1);
  CharCounts := TStringHashMap.Create(CaseSensitiveTraits, 1);
  HasChLower := False; HasChUpper := False; HasChNumber := False; 
    HasChSimpleSpecial := False; HasChExtSpecial := False;
    HasChHigh := False; hasChEscape := False;
  try
    // If there is no password, return 0 (bits)
    if Password = '' then begin Result := 0; Exit; end;
    PwLength := Length(Password);
    if PwLength = 0 then begin Result := 0; Exit; end;

    // loop through all characters
    EffectiveLength := 0;
    for I := 1 to PwLength do
    begin
      CurChar := Password[I];

      // determine character class
      if (Ord(Ord(CurChar)) < Ord(' ')) then HasChEscape := true;
      if ((Ord(CurChar) >= Ord('A')) and(Ord(CurChar) <= Ord('Z'))) then HasChUpper := True;
      if ((Ord(CurChar) >= Ord('a')) and (Ord(CurChar) <= Ord('z'))) then HasChLower := True;
      if ((Ord(CurChar) >= Ord('0')) and (Ord(CurChar) <= Ord('9'))) then HasChNumber := True;
      if ((Ord(CurChar) >= Ord(' ')) and (Ord(CurChar) <= Ord('/'))) then HasChSimpleSpecial := True;
      if ((Ord(CurChar) >= Ord(':')) and (Ord(CurChar) <= Ord('@'))) then HasChExtSpecial := True;
      if ((Ord(CurChar) >= Ord('[')) and (Ord(CurChar) <= Ord('`'))) then HasChExtSpecial := True;
      if ((Ord(CurChar) >= Ord('{')) and (Ord(CurChar) <= Ord('~'))) then HasChExtSpecial := True;
      if (Ord(CurChar) > Ord('~')) then HasChHigh := True;

      // diff factor? (not sure what this is for)
      DiffFactor := 1.0;
      if (I > 1) then
      begin
        Diff := Ord(CurChar) - Ord(Password[I-1]);

        if not Differences.Has(IntToStr(Diff)) then
        begin
          New(_int);
          _int^ := 1;
          Differences.Add(IntToStr(Diff), _int);
        end
        else begin
          Inc(PInteger(Differences.Data[IntToStr(Diff)])^);
          DiffFactor := DiffFactor / PInteger(Differences.Data[IntToStr(Diff)])^;
        end;
      end;

      if not CharCounts.Has(CurChar) then
      begin
        New(_int);
        _int^ := 1;
        CharCounts.Add(CurChar, _int);
        EffectiveLength := EffectiveLength + DiffFactor;
      end
      else begin
        Inc(PInteger(CharCounts.Data[CurChar])^);
        EffectiveLength := EffectiveLength +
          DiffFactor * (1.0 / PInteger(CharCounts.Data[CurChar])^);
      end;
    end;

    // Calculate total number of bits to consider
    CharSpace := 0;
    if (HasChEscape = TRUE) then Inc(CharSpace, CHARSPACE_ESCAPE);
    if (HasChUpper = TRUE) then Inc(CharSpace, CHARSPACE_ALPHA);
    if (HasChLower = TRUE) then Inc(CharSpace, CHARSPACE_ALPHA);
    if (HasChNumber = TRUE) then Inc(CharSpace, CHARSPACE_NUMBER);
    if (HasChSimpleSpecial = TRUE) then Inc(CharSpace, CHARSPACE_SIMPSPECIAL);
    if (HasChExtSpecial = TRUE) then Inc(CharSpace, CHARSPACE_EXTSPECIAL);
    if (HasChHigh = TRUE) then Inc(CharSpace, CHARSPACE_HIGH);

    // Usually shoulnd't happen
    if CharSpace = 0 then begin Result := 0; Exit; end;

    // Calculate total bit strength
    BitsPerChar := Ln(CharSpace) / Ln(2.00);
    Result := Ceil(BitsPerChar * EffectiveLength);
  finally   
    // Free the both hashes, plus the memory we filled along the way
    Differences.Iterate(nil, @FreeHashData);
    Differences.Free;
    CharCounts.Iterate(nil, @FreeHashData);
    CharCounts.Free;
  end;
end;

function GenerateRandomPassword(DrawSet: string; PwLength: Integer): string;
var
  I: Integer;
begin
  Randomize;
  Result := '';
  for I := 1 to PwLength do
  begin
    Result := Result + DrawSet[Random(Length(DrawSet))+1];
  end;
end;

end.
