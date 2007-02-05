unit JvGradientProgressBarEx;

interface

uses
  Windows, ComCtrls, Classes, Types, Graphics, JvProgressBar;

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
end;

procedure TJvGradientProgressBarEx.DrawBar(ACanvas: TCanvas; BarSize: Integer);
var
  R: TRect;
begin
  // we don't support smooth=false or orientation=vertical (yet?)
  if not Smooth or (Orientation = pbVertical) then
  begin
    inherited;
  end
  else begin
    R := ClientRect;
    InflateRect(R, -1, -1);  // don't override edge painted by inherited
    ACanvas.Brush.Color := Color;

    ACanvas.Lock;
    try
      inherited DrawBar(ACanvas, R.Right);
      R.Left := BarSize;
      ACanvas.FillRect(R);
    finally
      ACanvas.Unlock;
    end;
  end;
end;

end.
