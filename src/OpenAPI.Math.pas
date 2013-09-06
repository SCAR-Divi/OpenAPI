{$REGION 'Documentation'}
///	<summary>
///	  This namespace contains all mathematical functions.
///	</summary>
{$ENDREGION}
unit OpenAPI.Math;

interface

uses
  System.Math, System.Types,

  {$IFDEF EXPORTS}uPSComponent, uEngine_PascalScript,{$ENDIF}

  OpenAPI.Types;

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
///	  True if (<paramref name="X" />, <paramref name="Y" />) falls in or on the circle at (
///	  <paramref name="CenterX" />, <paramref name="CenterY" />) with a given Radius.
///	</returns>
{$ENDREGION}
function InCircle(const X, Y, CenterX, CenterY, Radius: Integer): Boolean; inline;

{$REGION 'Documentation'}
///	<summary>
///	  Generates a random point which falls within the given <paramref name="Box" />.
///	</summary>
///	<param name="Box">
///	  The box from which a random point will be generated.
///	</param>
///	<returns>
///	  The random point which falls inside of, or on the boundary of <paramref name="Box" />.
///	</returns>
{$ENDREGION}
function RndBoxPoint(const Box: TBox): TPoint;

{$REGION 'Documentation'}
///	<summary>
///	  Checks if a point falls inside of a triangle.
///	</summary>
///	<param name="X">
///	  The x-coordinate of the point to check.
///	</param>
///	<param name="Y">
///	  The y-coordinate of the point to check.
///	</param>
///	<param name="X1">
///	  The x-coordinate of the triangle's first corner.
///	</param>
///	<param name="Y1">
///	  The y-coordinate of the triangle's first corner.
///	</param>
///	<param name="X2">
///	  The x-coordinate of the triangle's second corner.
///	</param>
///	<param name="Y2">
///	  The y-coordinate of the triangle's second corner.
///	</param>
///	<param name="X3">
///	  The x-coordinate of the triangle's third corner.
///	</param>
///	<param name="Y3">
///	  The y-coordinate of the triangle's third corner.
///	</param>
///	<returns>
///	  True if the point (<paramref name="X" />, <paramref name="Y" />) falls inside of the triangle
///	  specified by (<paramref name="X1" />, <paramref name="Y1" />), (<paramref name="X2" />,
///	  <paramref name="Y2" />) and (<paramref name="X3" />, <paramref name="Y3" />).
///	</returns>
{$ENDREGION}
function InTriangle(const X, Y, X1, Y1, X2, Y2, X3, Y3: Integer): Boolean; inline;

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
  Result := Sqr(X - CenterX) + Sqr(Y - CenterY) <= Sqr(Radius);
end;

function RndBoxPoint(const Box: TBox): TPoint;
var
  Width, Height, Rnd: Extended;
begin
  Width := Box.X2 - Box.X1;
  Height := Box.Y2 - Box.Y1;
  if (Width = 0) or (Height = 0) then
  begin
    Result.X := Box.X1 + Round(Width * Random);
    Result.Y := Box.Y1 + Round(Height * Random);
    Exit;
  end;
  Rnd := Width * Height * Random;
  Result.X := Round(Rnd) mod Round(Width) + Box.X1;
  Result.Y := Round(Rnd) div Round(Width) + Box.Y1;
end;

function InTriangle(const X, Y, X1, Y1, X2, Y2, X3, Y3: Integer): Boolean; inline;
var
  A, B, C: Integer;
begin
  A := (Y - Y1) * (X2 - X1) - (X - X1) * (Y2 - Y1);
  B := (Y - Y3) * (X1 - X3) - (X - X3) * (Y1 - Y3);
  C := (Y - Y2) * (X3 - X2) - (X - X2) * (Y3 - Y2);
  Result := ((A <> 0) and ((A < 0) = (B < 0)) and ((B < 0) = (C < 0)));
end;

initialization
  // Functions documented at wiki.scar-divi.com are marked with an empty comment
{$IFDEF EXPORTS}
  TExportMngr_PS.Instance['Functions'].Add(procedure(const Engine: TPSScript)
  begin
    Engine.AddFunction(@Distance, 'function Distance(const X1, Y1, X2, Y2: Integer): Extended;'); //
    Engine.AddFunction(@InCircle, 'function InCircle(const X, Y, CX, CY, R: Integer): Boolean;'); //
    Engine.AddFunction(@RndBoxPoint, 'function RndBoxPoint(const Box: TBox): TPoint;');
    Engine.AddFunction(@InTriangle, 'function InTriangle(const X, Y, X1, Y1, X2, Y2, X3, Y3: Integer): Boolean;'); //
  end);
{$ENDIF}
end.
