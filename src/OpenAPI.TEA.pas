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

implementation

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

initialization
  // Functions documented at wiki.scar-divi.com are marked with an empty comment
{$IFDEF EXPORTS}
  TExportMngr_PS.Instance['Functions'].Add(procedure(const Engine: TPSScript)
  begin
    Engine.AddFunction(@TEAMean, 'function TEAMean(const TEA: TExtArray): Extended;'); //
    Engine.AddFunction(@TEASum, 'function TEASum(const TEA: TExtArray): Extended;'); //
  end);
{$ENDIF}
end.
