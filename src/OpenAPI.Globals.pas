unit OpenAPI.Globals;

interface

uses
  System.Types;

const
  ///	<summary>
  ///	  Gaps for the ShellSort algorithm as defined by Sedgewick. These gaps result in a worst case 
  ///	  time complexity of O(N^(4/3)).
  ///	</summary>
  SHELLGAPS: array[0..25] of Integer = (1147718700, 510097200, 226709866, 100759940, 44782196, 19903198, 8845866,
    3931496, 1747331, 776591, 345152, 153401, 68178, 30301, 13467, 5985, 2660, 1182, 525, 233, 103, 46, 20, 9, 4, 1);

type
  ///	<summary>
  ///	  A pointer to a TPoint value.
  ///	</summary>
  PPoint = ^TPoint;

  ///	<summary>
  ///	  A dynamic array of TPoint values.
  ///	</summary>
  TPointArray = array of TPoint;

  ///	<summary>
  ///	  A 2-dimensional dynamic array of TPoint values.
  ///	</summary>
  T2DPointArray = array of TPointArray;

  ///	<summary>
  ///	  A dynamic array of Extended values.
  ///	</summary>
  ///	<remarks>
  ///	  Extended values have are floating point with a 19 digit precision, stored in 10 bytes.
  ///	</remarks>
  TExtArray = array of Extended;

  ///	<summary>
  ///	  A 2-dimensional array of extended values.
  ///	</summary>
  T2DExtArray = array of TExtArray;

implementation

end.
