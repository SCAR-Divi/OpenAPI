{$REGION 'Documentation'}
///	<summary>
///	  This namespace contains all of the types defined by the OpenAPI.
///	</summary>
{$ENDREGION}
unit OpenAPI.Types;

interface

uses
  System.Types, System.SysUtils;

type
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A pointer to a <see cref="OpenAPI.Types|TPoint">TPoint</see> value.
  ///	</summary>
  {$ENDREGION}
  PPoint = System.Types.PPoint;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A type representing a 2-dimensional point.
  ///	</summary>
  {$ENDREGION}
  TPoint = System.Types.TPoint;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A helper for the <see cref="OpenAPI.Types|TPoint">TPoint</see> type.
  ///	</summary>
  {$ENDREGION}
  TPointHelper = record helper for TPoint
  public
    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Converts the point to a string, formatted as (X,Y).
    ///	</summary>
    ///	<returns>
    ///	  The box in string format.
    ///	</returns>
    {$ENDREGION}
    function ToString: string;
  end;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A dynamic array of <see cref="OpenAPI.Types|TPoint">TPoint</see> values.
  ///	</summary>
  {$ENDREGION}
  TPointArray = array of TPoint;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A 2-dimensional dynamic array of TPoint values.
  ///	</summary>
  {$ENDREGION}
  T2DPointArray = array of TPointArray;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A dynamic array of Extended values.
  ///	</summary>
  ///	<remarks>
  ///	  Extended values have are floating point with a 19 digit precision, stored in 10 bytes.
  ///	</remarks>
  ///	<seealso cref="TPointArray" />
  {$ENDREGION}
  TExtArray = array of Extended;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A 2-dimensional dynamic array of Extended values.
  ///	</summary>
  {$ENDREGION}
  T2DExtArray = array of TExtArray;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A dynamic array of Integer values.
  ///	</summary>
  {$ENDREGION}
  TIntArray = array of Integer;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A 2-dimensional dynamic array of Integer values.
  ///	</summary>
  {$ENDREGION}
  T2DIntArray = array of TIntArray;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A dynamic array of Boolean values.
  ///	</summary>
  {$ENDREGION}
  TBoolArray = array of Boolean;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A 2-dimensional dynamic array of Boolean values.
  ///	</summary>
  {$ENDREGION}
  T2DBoolArray = array of TBoolArray;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A pointer to a TBox value.
  ///	</summary>
  {$ENDREGION}
  PBox = ^TBox;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A data structure which represents a box/rectangle, specified by the upper-left and
  ///	  lower-right coordinates.
  ///	</summary>
  {$ENDREGION}
  TBox = record

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The x-coordinate of the upper-left corner of the box.
    ///	</summary>
    {$ENDREGION}
    X1: Integer;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The y-coordinate of the upper-left corner of the box.
    ///	</summary>
    {$ENDREGION}
    Y1: Integer;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The x-coordinate of the lower-right corner of the box.
    ///	</summary>
    {$ENDREGION}
    X2: Integer;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The y-coordinate of the lower-right corner of the box.
    ///	</summary>
    {$ENDREGION}
    Y2: Integer;
  private
    function GetWidth: Integer;
    function GetHeight: Integer;
  public
    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Creates a box from a set of integer coordinates.
    ///	</summary>
    ///	<param name="X1">
    ///	  The x-coordinate of the upper-left point.
    ///	</param>
    ///	<param name="Y1">
    ///	  The y-coordinate of the upper-left point.
    ///	</param>
    ///	<param name="X2">
    ///	  The x-coordinate of the lower-right point.
    ///	</param>
    ///	<param name="Y2">
    ///	  The y-coordinate of the lower-right point.
    ///	</param>
    {$ENDREGION}
    constructor Create(const X1, Y1, X2, Y2: Integer); overload;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Creates a new box from a TRect.
    ///	</summary>
    ///	<param name="Rect">
    ///	  The rectangle that will be converted.
    ///	</param>
    {$ENDREGION}
    constructor Create(const Rect: TRect); overload;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Offsets the box' x-coordinates.
    ///	</summary>
    ///	<param name="Offset">
    ///	  The offset value.
    ///	</param>
    ///	<remarks>
    ///	  The function essentially moves the box over the x-axis.
    ///	</remarks>
    {$ENDREGION}
    procedure OffsetX(const Offset: Integer);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Offsets the box' y-coordinates.
    ///	</summary>
    ///	<param name="Offset">
    ///	  The offset value.
    ///	</param>
    ///	<remarks>
    ///	  The function essentially moves the box over the y-axis.
    ///	</remarks>
    {$ENDREGION}
    procedure OffsetY(const Offset: Integer);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Adds a second box by determining the smallest box that encapsulates both.
    ///	</summary>
    ///	<param name="Box">
    ///	  The box that will be added.
    ///	</param>
    {$ENDREGION}
    procedure Add(const Box: TBox);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Expands the size of the box in every direction.
    ///	</summary>
    ///	<param name="SizeChange">
    ///	  The size increment.
    ///	</param>
    {$ENDREGION}
    procedure Expand(const SizeChange: Integer);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Determines the center point of the box.
    ///	</summary>
    ///	<returns>
    ///	  The center point of the box.
    ///	</returns>
    ///	<remarks>
    ///	  The method to determine the center uses integer division, as such it rounds down.
    ///	</remarks>
    {$ENDREGION}
    function Center: TPoint;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Determines if a point (<paramref name="X" />, <paramref name="Y" />) is inside of the box.
    ///	</summary>
    ///	<param name="X">
    ///	  The x-coordinate of the point to validate.
    ///	</param>
    ///	<param name="Y">
    ///	  The y-coordinate of the point to validate.
    ///	</param>
    ///	<returns>
    ///	  True if the point lies within the box.
    ///	</returns>
    {$ENDREGION}
    function Contains(const X, Y: Integer): Boolean; overload;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Determines if a point <paramref name="P" /> is inside of the box.
    ///	</summary>
    ///	<param name="P">
    ///	  The point to validate.
    ///	</param>
    ///	<returns>
    ///	  True if the point lies inside of the box.
    ///	</returns>
    {$ENDREGION}
    function Contains(const P: TPoint): Boolean; overload;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Converts the box to a string, formatted as (X1,Y1,X2,Y2).
    ///	</summary>
    ///	<returns>
    ///	  The box in string format.
    ///	</returns>
    {$ENDREGION}
    function ToString: string;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Returns the width of the box.
    ///	</summary>
    ///	<value>
    ///	  The width of the box.
    ///	</value>
    {$ENDREGION}
    property Width: Integer read GetWidth;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Returns the height of the box.
    ///	</summary>
    ///	<value>
    ///	  The height of the box.
    ///	</value>
    {$ENDREGION}
    property Height: Integer read GetHeight;
  end;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A dynamic array of <see cref="TBox">TBox</see> values.
  ///	</summary>
  {$ENDREGION}
  TBoxArray = array of TBox;

{$REGION 'Documentation'}
///	<summary>
///	  Generates a <see cref="OpenAPI.Types|TPoint">TPoint</see> from a given set of coordinates.
///	</summary>
///	<param name="X">
///	  The x-coordinate of the point.
///	</param>
///	<param name="Y">
///	  The y-coordinate of the point.
///	</param>
///	<returns>
///	  The point at the given coordinates.
///	</returns>
{$ENDREGION}
function Point(const X, Y: Integer): TPoint;

{$REGION 'Documentation'}
///	<summary>
///	  Creates a box from a set of integer coordinates.
///	</summary>
///	<param name="X1">
///	  The x-coordinate of the upper-left point.
///	</param>
///	<param name="Y1">
///	  The y-coordinate of the upper-left point.
///	</param>
///	<param name="X2">
///	  The x-coordinate of the lower-right point.
///	</param>
///	<param name="Y2">
///	  The y-coordinate of the lower-right point.
///	</param>
///	<returns>
///	  The box defined by the given coordinates.
///	</returns>
{$ENDREGION}
function Box(const X1, Y1, X2, Y2: Integer): TBox;

implementation

uses
  System.Math;

{ TPointHelper }

function TPointHelper.ToString: string;
begin
  Result := '(' + IntToStr(X) + ',' + IntToStr(Y) + ')';
end;

{ TBox }

constructor TBox.Create(const X1, Y1, X2, Y2: Integer);
begin
  Self.X1 := X1;
  Self.Y1 := Y1;
  Self.X2 := X2;
  Self.Y2 := Y2;
end;

procedure TBox.Add(const Box: TBox);
begin
  Self.X1 := Min(Self.X1, Box.X1);
  Self.Y1 := Min(Self.Y1, Box.Y1);
  Self.X2 := Max(Self.X2, Box.X2);
  Self.Y2 := Max(Self.Y2, Box.Y2);
end;

function TBox.Center: TPoint;
begin
  Result.X := Self.X1 + GetWidth div 2;
  Result.Y := Self.Y1 + GetHeight div 2;
end;

function TBox.Contains(const X, Y: Integer): Boolean;
begin
  Result := (Self.X1 <= X) and (Self.X2 >= X) and (Self.Y1 <= Y) and (Self.Y2 >= Y);
end;

function TBox.Contains(const P: TPoint): Boolean;
begin
  Result := Contains(P.X, P.Y);
end;

constructor TBox.Create(const Rect: TRect);
begin
  Self.X1 := Rect.Left;
  Self.Y1 := Rect.Top;
  Self.X2 := Rect.Right - 1;
  Self.Y2 := Rect.Bottom - 1;
end;

procedure TBox.Expand(const SizeChange: Integer);
begin
  Self.X1 := Self.X1 - SizeChange;
  Self.Y1 := Self.Y1 - SizeChange;
  Self.X2 := Self.X2 + SizeChange;
  Self.Y2 := Self.Y2 + SizeChange;
end;

function TBox.GetHeight: Integer;
begin
  Result := Y2 - Y1 + 1;
end;

function TBox.GetWidth: Integer;
begin
  Result := X2 - X1 + 1;
end;

procedure TBox.OffsetX(const Offset: Integer);
begin
  X1 := X1 + Offset;
  X2 := X2 + Offset;
end;

procedure TBox.OffsetY(const Offset: Integer);
begin
  Y1 := Y1 + Offset;
  Y2 := Y2 + Offset;
end;

function TBox.ToString: string;
begin
  Result := '(' + IntToStr(X1) + ',' + IntToStr(Y1) + ',' + IntToStr(X2) + ',' + IntToStr(Y2) + ')';
end;

function PointToStr(const Pt: TPoint): string;
begin
  Result := Pt.ToString;
end;

function Point(const X, Y: Integer): TPoint;
begin
  Result := TPoint.Create(X, Y);
end;

function Box(const X1, Y1, X2, Y2: Integer): TBox;
begin
  Result := TBox.Create(X1, Y1, X2, Y2);
end;

end.
