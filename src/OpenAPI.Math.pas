{$REGION 'Documentation'}
///	<summary>
///	  This namespace contains all mathematical functions.
///	</summary>
{$ENDREGION}
unit OpenAPI.Math;

interface

uses
  System.Math

  {$IFDEF EXPORTS}, uPSComponent, uEngine_PascalScript{$ENDIF};

{$REGION 'Documentation'}
///	<summary>
///	  Calculates the Euclidean distance between two points.
///	</summary>
///	<param name="X1">
///	  The x-coordinate of the first point.
///	</param>
///	<param name="Y1">
///	  The y-coordinate of the first point.
///	</param>
///	<param name="X2">
///	  The x-coordinate of the second point.
///	</param>
///	<param name="Y2">
///	  The y-coordinate of the second point.
///	</param>
///	<returns>
///	  The distance between the two points.
///	</returns>
{$ENDREGION}
function Distance(const X1, Y1, X2, Y2: Integer): Extended;

{$REGION 'Documentation'}
///	<summary>
///	  Returns True if a given point falls within or on a given circle.
///	</summary>
///	<param name="X">
///	  The x-coordinate of the point.
///	</param>
///	<param name="Y">
///	  The y-coordinate of the point.
///	</param>
///	<param name="CenterX">
///	  The x-coordinate of the circle's center.
///	</param>
///	<param name="CenterY">
///	  The y-coordinate of the circle's center.
///	</param>
///	<param name="Radius">
///	  The radius of the circle.
///	</param>
///	<returns>
///	  True if (X, Y) falls in or on the circle at (CenterX, CenterY) with a given Radius.
///	</returns>
{$ENDREGION}
function InCircle(const X, Y, CenterX, CenterY, Radius: Integer): Boolean; inline;

implementation

function Distance(const X1, Y1, X2, Y2: Integer): Extended;
var
  XDiff, YDiff: Extended;
begin
  XDiff := X1 - X2;
  YDiff := Y1 - Y2;
  Result := Sqrt(XDiff * XDiff + YDiff * YDiff);
end;

function InCircle(const X, Y, CenterX, CenterY, Radius: Integer): Boolean; inline;
begin
  Result := (X - CenterX) * (X - CenterX) + (Y - CenterY) * (Y - CenterY) <= Radius * Radius;
end;

initialization
  // Functions documented at wiki.scar-divi.com are marked with an empty comment
{$IFDEF EXPORTS}
  TExportMngr_PS.Instance['Functions'].Add(procedure(const Engine: TPSScript)
  begin
    Engine.AddFunction(@Distance, 'function Distance(const X1, Y1, X2, Y2: Integer): Extended;'); //
    Engine.AddFunction(@InCircle, 'function InCircle(const X, Y, CX, CY, R: Integer): Boolean;'); //
  end);
{$ENDIF}
end.
