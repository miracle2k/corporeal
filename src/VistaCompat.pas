{-----------------------------------------------------------------------------
The contents of this file are subject to the GNU General Public License
Version 2.0 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.gnu.org/copyleft/gpl.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

$Id$

You may retrieve the latest version of this file at the Patronus
Website, located at http://www.elsdoerfer.info/patronus

Known Issues:
-----------------------------------------------------------------------------}

// from http://www.installationexcellence.com/articles/VistaWithDelphi/Index.html

unit VistaCompat;

interface

uses
  Forms, Windows, Graphics;

function IsWindowsVista: Boolean;
procedure SetVistaFonts(const AForm: TCustomForm);
procedure SetVistaContentFonts(const AFont: TFont);
procedure SetDesktopIconFonts(const AFont: TFont);
procedure ExtendGlass(const AHandle: THandle; const AMargins: TRect);
function CompositingEnabled: Boolean;
  
const
  VistaFont = 'Segoe UI'; 
  VistaContentFont = 'Calibri';
  XPContentFont = 'Verdana';
  XPFont = 'Tahoma';    

var
  CheckOSVerForFonts: Boolean = True;

implementation

uses
  SysUtils, Dialogs, Controls, UxTheme;   

procedure SetVistaTreeView(const AHandle: THandle);
begin
  if IsWindowsVista then
    SetWindowTheme(AHandle, 'explorer', nil);
end;

procedure SetVistaFonts(const AForm: TCustomForm);
begin
  if (IsWindowsVista or not CheckOSVerForFonts)
    and not SameText(AForm.Font.Name, VistaFont)
    and (Screen.Fonts.IndexOf(VistaFont) >= 0) then
  begin
    AForm.Font.Size := AForm.Font.Size + 1;
    AForm.Font.Name := VistaFont;
  end;
end;

procedure SetVistaContentFonts(const AFont: TFont);
begin
  if (IsWindowsVista or not CheckOSVerForFonts)
    and not SameText(AFont.Name, VistaContentFont)
    and (Screen.Fonts.IndexOf(VistaContentFont) >= 0) then
  begin
    AFont.Size := AFont.Size + 2;
    AFont.Name := VistaContentFont;
  end;
end;

procedure SetDefaultFonts(const AFont: TFont);
begin
  AFont.Handle := GetStockObject(DEFAULT_GUI_FONT);
end;

procedure SetDesktopIconFonts(const AFont: TFont);
var
  LogFont: TLogFont;
begin
  if SystemParametersInfo(SPI_GETICONTITLELOGFONT, SizeOf(LogFont),
    @LogFont, 0) then
    AFont.Handle := CreateFontIndirect(LogFont)
  else
    SetDefaultFonts(AFont);
end;

function IsWindowsVista: Boolean;   
var
  VerInfo: TOSVersioninfo;
begin
  VerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(VerInfo);        
  Result := VerInfo.dwMajorVersion >= 6;
end;  

const
  dwmapi = 'dwmapi.dll';
  DwmIsCompositionEnabledSig = 'DwmIsCompositionEnabled';
  DwmExtendFrameIntoClientAreaSig = 'DwmExtendFrameIntoClientArea';
  TaskDialogSig = 'TaskDialog';

function CompositingEnabled: Boolean;
var
  DLLHandle: THandle;
  DwmIsCompositionEnabledProc: function(pfEnabled: PBoolean): HRESULT; stdcall;
  Enabled: Boolean;
begin
  Result := False;
  if IsWindowsVista then
  begin
    DLLHandle := LoadLibrary(dwmapi);

    if DLLHandle <> 0 then 
    begin
      @DwmIsCompositionEnabledProc := GetProcAddress(DLLHandle,
        DwmIsCompositionEnabledSig);

      if (@DwmIsCompositionEnabledProc <> nil) then
      begin
        DwmIsCompositionEnabledProc(@Enabled);
        Result := Enabled;
      end;

      FreeLibrary(DLLHandle);
    end;
  end;
end;

//from http://www.delphipraxis.net/topic93221,next.html
procedure ExtendGlass(const AHandle: THandle; const AMargins: TRect);
type
  _MARGINS = packed record 
    cxLeftWidth: Integer; 
    cxRightWidth: Integer; 
    cyTopHeight: Integer; 
    cyBottomHeight: Integer; 
  end; 
  PMargins = ^_MARGINS; 
  TMargins = _MARGINS; 
var 
  DLLHandle: THandle;
  DwmExtendFrameIntoClientAreaProc: function(destWnd: HWND; const pMarInset: 
    PMargins): HRESULT; stdcall;
  Margins: TMargins;
begin
  if IsWindowsVista and CompositingEnabled then
  begin
    DLLHandle := LoadLibrary(dwmapi);

    if DLLHandle <> 0 then
    begin
      @DwmExtendFrameIntoClientAreaProc := GetProcAddress(DLLHandle,
        DwmExtendFrameIntoClientAreaSig);

      if (@DwmExtendFrameIntoClientAreaProc <> nil) then
      begin
        ZeroMemory(@Margins, SizeOf(Margins));
        Margins.cxLeftWidth := AMargins.Left;
        Margins.cxRightWidth := AMargins.Right;
        Margins.cyTopHeight := AMargins.Top;
        Margins.cyBottomHeight := AMargins.Bottom;

        DwmExtendFrameIntoClientAreaProc(AHandle, @Margins);
      end;

      FreeLibrary(DLLHandle);
    end;
  end;
end;

end.
