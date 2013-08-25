{$REGION 'Documentation'}
///	<summary>
///	  This namespace contains a series of shared global variables, constants, types and functions,
///	  which are used in various other namespaces.
///	</summary>
{$ENDREGION}
unit OpenAPI.Globals;

interface

uses
  System.Types, System.SysUtils;

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
