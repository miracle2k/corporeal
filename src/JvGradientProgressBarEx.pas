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

unit JvGradientProgressBarEx;

interface

uses
  Windows, ComCtrls, Controls, Classes, Types, Graphics, JvProgressBar;

type
  TJvGradientProgressBarEx = class(TJvGradientProgressBar)
  protected
    procedure DrawBar(ACanvas: TCanvas; BarSize: Integer); override;
  public
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{ TJvGradientProgressBarEx }

constructor TJvGradientProgressBarEx.Create(AOwner: TComponent);
begin
  inherited;
  Smooth := True;
  ControlStyle := ControlStyle + [csOpaque];
end;

procedure TJvGradientProgressBarEx.DrawBar(ACanvas: TCanvas; BarSize: Integer);
var
  R: TRect;
  MemoryBitmap: TBitmap;
begin
  // we don't support smooth=false or orientation=vertical (yet?)
  if not Smooth or (Orientation = pbVertical) then
  begin
    inherited;
  end
  else begin
    MemoryBitmap := TBitmap.Create;
    MemoryBitmap.Width := ClientWidth;
    MemoryBitmap.Height := ClientHeight;

    R := ClientRect;
    InflateRect(R, -1, -1);  // don't override edge painted by inherited
    MemoryBitmap.Canvas.Brush.Color := Color;
        
    try
      inherited DrawBar(MemoryBitmap.Canvas, R.Right);
      R.Left := BarSize;
      MemoryBitmap.Canvas.FillRect(R);

      // flip
      ACanvas.Draw(0, 0, MemoryBitmap);
    finally
      MemoryBitmap.Free;
    end;
  end;
end;

end.
