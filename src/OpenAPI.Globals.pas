{$REGION 'Documentation'}
///	<summary>
///	  This namespace contains a series of shared global variables, constants, types and functions,
///	  which are used in various units of the OpenAPI. This unit is not meant to be used direcly.
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
  ///	  A pointer to the <see cref="TRGBColor" /> type.
  ///	</summary>
  {$ENDREGION}
  PRGBColor = ^TRGBColor;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A "union" type, which unifies a 24-bit color with it's RGB components. This allows both the
  ///	  color and it's components to be accessed directly from the memory without additional
  ///	  processing.
  ///	</summary>
  {$ENDREGION}
  TRGBColor = packed record
    case Boolean of
      True: (Extra, B, G, R: Byte);
      False: (Color: Integer);
  end;

implementation

end.
