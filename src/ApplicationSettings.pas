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

unit ApplicationSettings;

interface

uses
  Classes, SysUtils, Forms;

type
  TCorporealSettings = class(TPersistent)
  private
    FDefaultStore: string;
    FAutoLockAfter: Integer;
    FLimitToOneInstance: Boolean;
    procedure SetDefaultStore(const Value: string);
    procedure SetAutoLockAfter(const Value: Integer);
    function GetApplicationExePath: WideString;
    procedure SetApplicationExePath(const Value: WideString);
    procedure SetLimitToOneInstance(const Value: Boolean);
  published
  public
    constructor Create; virtual;
  published
    property DefaultStore: string read FDefaultStore write SetDefaultStore;
    property AutoLockAfter: Integer read FAutoLockAfter write SetAutoLockAfter;
    // This makes sure the path to the executable is automatically written to the registry
    property ApplicationExePath: WideString read GetApplicationExePath write SetApplicationExePath;
    property LimitToOneInstance: Boolean read FLimitToOneInstance write SetLimitToOneInstance;
  end;

function Settings: TCorporealSettings;

implementation

var
  InternalSettingsObj: TCorporealSettings = nil;

function Settings: TCorporealSettings;
begin
  if InternalSettingsObj = nil then
    InternalSettingsObj := TCorporealSettings.Create;
  Result := InternalSettingsObj;
end;

{ TCorporealSettings }

constructor TCorporealSettings.Create;
begin
  FDefaultStore := '';
  FAutoLockAfter := 10;
  FLimitToOneInstance := True;
end;

function TCorporealSettings.GetApplicationExePath: WideString;
begin
  Result := ExtractFilePath(Application.ExeName);
end;

procedure TCorporealSettings.SetApplicationExePath(const Value: WideString);
begin
  // do not accept any values for this
end;

procedure TCorporealSettings.SetAutoLockAfter(const Value: Integer);
begin
  FAutoLockAfter := Value;
end;

procedure TCorporealSettings.SetDefaultStore(const Value: string);
begin
  FDefaultStore := Value;
end;

procedure TCorporealSettings.SetLimitToOneInstance(const Value: Boolean);
begin
  FLimitToOneInstance := Value;
end;

initialization

finalization
  if InternalSettingsObj <> nil then
    InternalSettingsObj.Free;

end.
