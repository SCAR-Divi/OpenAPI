unit OpenAPI.Globals;

interface

uses
  System.Types;

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

implementation

end.
