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
