{$REGION 'Documentation'}
///	<summary>
///	  This namespace contains a series of shared global variables, constants, types and functions,
///	  which are used in various other namespaces.
///	</summary>
{$ENDREGION}
unit OpenAPI.Globals;

interface

uses
  System.Types, System.SysUtils, System.Math;

const
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Gaps for the ShellSort algorithm as defined by Sedgewick. These gaps result in a worst case 
  ///	   time complexity of O(N^(4/3)).
  ///	</summary>
  {$ENDREGION}
  SHELLGAPS: array[0..25] of Integer = (1147718700, 510097200, 226709866, 100759940, 44782196, 19903198, 8845866,
    3931496, 1747331, 776591, 345152, 153401, 68178, 30301, 13467, 5985, 2660, 1182, 525, 233, 103, 46, 20, 9, 4, 1);

type
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A pointer to a TPoint value.
  ///	</summary>
  {$ENDREGION}
  PPoint = ^TPoint;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A dynamic array of TPoint values.
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
  ///	  A dynamic array of Boolean values.
  ///	</summary>
  {$ENDREGION}
  TBoolArray = array of Boolean;

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
    X1, Y1, X2, Y2: Integer;
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

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  An operator to cast the box to a string implicitly.
    ///	</summary>
    ///	<param name="Box">
    ///	  The box that will be converted.
    ///	</param>
    ///	<returns>
    ///	  The box stored as a string, formatted as (X1,Y1,X2,Y2).
    ///	</returns>
    {$ENDREGION}
    class operator Implicit(const Box: TBox): string;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  An operator to cast the box to a string explicitly.
    ///	</summary>
    ///	<param name="Box">
    ///	  The box that will be converted.
    ///	</param>
    ///	<returns>
    ///	  The box stored as a string, formatted as (X1,Y1,X2,Y2).
    ///	</returns>
    {$ENDREGION}
    class operator Explicit(const Box: TBox): string;
  end;
  TBoxArray = array of TBox;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A simple and high-performance inline stack implementation.
  ///	</summary>
  ///	<typeparam name="T">
  ///	  The type of data that will be stored in the stack.
  ///	</typeparam>
  ///	<remarks>
  ///	  The stack has a minimum array size which it will never drop below to avoid a big amount of
  ///	  SetLength operations, which could seriously deteriorate the performance of the stack. The
  ///	  size of the array is also increments by doubling it or halving it, with the minimum size as
  ///	  lower limit.
  ///	</remarks>
  {$ENDREGION}
  TSimpleStack<T> = record
  private
    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The array which holds all data present on the stack.
    ///	</summary>
    {$ENDREGION}
    FData: array of T;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The number of items on the stack.
    ///	</summary>
    {$ENDREGION}
    FSize: Integer;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The size of the data array.
    ///	</summary>
    {$ENDREGION}
    FActualSize: Integer;
  public
    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Initiates the stack. This should <b>always</b> be called before using the stack.
    ///	</summary>
    {$ENDREGION}
    procedure Setup; inline;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Returns True if the stack does not contain any data entries.
    ///	</summary>
    {$ENDREGION}
    function IsEmpty: Boolean; inline;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Returns the data entry that was pushed on the stack last.
    ///	</summary>
    ///	<exception cref="Exception">
    ///	  Thrown when trying to pop an item from an empty stack.
    ///	</exception>
    ///	<remarks>
    ///	  This function will half the array size of the stack if the number of data entries drops
    ///	  below half the size of the array.
    ///	</remarks>
    {$ENDREGION}
    function Pop: T; inline;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Adds a value to the top of the stack.
    ///	</summary>
    ///	<param name="Value">
    ///	  The value that will be pushed onto the stack.
    ///	</param>
    ///	<remarks>
    ///	  This function will double the size of the stack's internal data array if the the number
    ///	  of items on the stack equals the size of the array.
    ///	</remarks>
    {$ENDREGION}
    procedure Push(const Value: T); inline;
  end;

implementation

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

class operator TBox.Explicit(const Box: TBox): string;
begin
  Result := '(' + IntToStr(Box.X1) + ', ' + IntToStr(Box.Y1) + ', ' +
    IntToStr(Box.X2) + ', ' + IntToStr(Box.Y2) + ')';
end;

function TBox.GetHeight: Integer;
begin
  Result := Y2 - Y1 + 1;
end;

function TBox.GetWidth: Integer;
begin
  Result := X2 - X1 + 1;
end;

class operator TBox.Implicit(const Box: TBox): string;
begin
  Result := '(' + IntToStr(Box.X1) + ', ' + IntToStr(Box.Y1) + ', ' +
    IntToStr(Box.X2) + ', ' + IntToStr(Box.Y2) + ')';
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

{ TSimpleStack<T> }

const MINSTACKSIZE = 1024;

function TSimpleStack<T>.IsEmpty: Boolean;
begin
  Result := FSize = 0;
end;

function TSimpleStack<T>.Pop: T;
begin
  if FSize = 0 then
    raise Exception.Create('Stack is empty')
  else begin
    Dec(FSize);
    Result := FData[FSize];
    if (FActualSize <> MINSTACKSIZE) and ((FActualSize div 2) >= FSize) then
    begin
      FActualSize := FActualSize div 2;
      SetLength(FData, FActualSize);
    end;
  end;
end;

procedure TSimpleStack<T>.Push(const Value: T);
begin
  FData[FSize] := Value;
  Inc(FSize);
  if FActualSize = FSize then
  begin
    FActualSize := FActualSize * 2;
    SetLength(FData, FActualSize);
  end;
end;

procedure TSimpleStack<T>.Setup;
begin
  FSize := 0;
  SetLength(FData, MINSTACKSIZE);
  FActualSize := MINSTACKSIZE;
end;

end.
