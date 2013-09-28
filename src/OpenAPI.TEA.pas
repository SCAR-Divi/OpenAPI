{$REGION 'Documentation'}
///	<summary>
///	  This namespace contains all functions relating to
///	  <see cref="OpenAPI.Globals|TExtArray">TExtArrays</see>.
///	</summary>
{$ENDREGION}
unit OpenAPI.TEA;

interface

uses
  System.SysUtils,

  {$IFDEF EXPORTS}uPSComponent, uEngine_PascalScript,{$ENDIF}

  OpenAPI.Types;

type
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A simple alias of the Exception class to identify errors thrown by TEA functions.
  ///	</summary>
  {$ENDREGION}
  ETEAException = class(Exception);

{$REGION 'Documentation'}
///	<summary>
///	  Calculates the mean of an array of values.
///	</summary>
///	<param name="TEA">
///	  The array of values.
///	</param>
///	<returns>
///	  The mean of <paramref name="TEA" />.
///	</returns>
{$ENDREGION}
function TEAMean(const TEA: TExtArray): Extended;

{$REGION 'Documentation'}
///	<summary>
///	  Calculates the sum of all of the values in <paramref name="TEA" />.
///	</summary>
///	<param name="TEA">
///	  The array to determine the sum of.
///	</param>
///	<returns>
///	  The sum of all of the values in <paramref name="TEA" />.
///	</returns>
{$ENDREGION}
function TEASum(const TEA: TExtArray): Extended;

{$REGION 'Documentation'}
///	<summary>
///	  Clamps <paramref name="TEA" /> between <paramref name="Min" /> and <paramref name="Max" />,
///	  if <paramref name="Min" /> is smaller than or equal to <paramref name="Max" />.
///	</summary>
///	<param name="TEA">
///	  The array which will be clamped between <paramref name="Min" /> and <paramref name="Max" />.
///	</param>
///	<param name="Min">
///	  The lower bound for the values.
///	</param>
///	<param name="Max">
///	  The upper bound for the values.
///	</param>
{$ENDREGION}
procedure ClampTEA(var TEA: TExtArray; const Min, Max: Extended);

implementation

uses
  OpenAPI.Math;

function TEAMean(const TEA: TExtArray): Extended;
var
  Len: Integer;
  ValPtr, MaxPtr: PExtended;
begin
  Result := 0;
  Len := Length(TEA);
  if Len = 0 then
    raise ETEAException.Create('Array is empty!');
  ValPtr := @TEA[0];
  MaxPtr := @TEA[0]; Inc(MaxPtr, Len);
  repeat
    Result := Result + ValPtr^ / Len;
    Inc(ValPtr);
  until ValPtr = MaxPtr;
end;

function TEASum(const TEA: TExtArray): Extended;
var
  Len: Integer;
  ValPtr, MaxPtr: PExtended;
begin
  Result := 0;
  Len := Length(TEA);
  if Len = 0 then
    Exit;
  ValPtr := @TEA[0];
  MaxPtr := @TEA[0]; Inc(MaxPtr, Len);
  while ValPtr <> MaxPtr do
  begin
    Result := Result + ValPtr^;
    Inc(ValPtr);
  end;
end;

procedure ClampTEA(var TEA: TExtArray; const Min, Max: Extended);
var
  ValPtr: PExtended;
  Idx, Hi: Integer;
begin
  Hi := High(TEA);
  if Hi < 0 then Exit;
  ValPtr := @TEA[0];
  for Idx := 0 to Hi do
  begin
    ClampExt(ValPtr^, Min, Max);
    Inc(ValPtr);
  end;
end;

initialization
  // Functions documented at wiki.scar-divi.com are marked with an empty comment
{$IFDEF EXPORTS}
  TExportMngr_PS.Instance['Functions'].Add(procedure(const Engine: TPSScript)
  begin
    Engine.AddFunction(@TEAMean, 'function TEAMean(const TEA: TExtArray): Extended;'); //
    Engine.AddFunction(@TEASum, 'function TEASum(const TEA: TExtArray): Extended;'); //
    Engine.AddFunction(@ClampTEA, 'procedure ClampTEA(var TEA: TExtArray; const Min, Max: Extended);');
  end);
{$ENDIF}
end.
