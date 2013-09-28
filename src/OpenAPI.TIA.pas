{$REGION 'Documentation'}
///	<summary>
///	  This namespace contains all functions relating to
///	  <see cref="OpenAPI.Globals|TIntArray">TIntArrays</see>.
///	</summary>
{$ENDREGION}
unit OpenAPI.TIA;

interface

uses
  System.SysUtils,

  {$IFDEF EXPORTS}uPSComponent, uEngine_PascalScript,{$ENDIF}

  OpenAPI.Types;

{$REGION 'Documentation'}
///	<summary>
///	  Converts <paramref name="TIA" /> to a string.
///	</summary>
///	<param name="TIA">
///	  The array which will be converted to a string.
///	</param>
///	<returns>
///	  The string formatted as V1,V2,...,Vn.
///	</returns>
{$ENDREGION}
function TIAToStr(const TIA: TIntArray): string;

{$REGION 'Documentation'}
///	<summary>
///	  Clamps <paramref name="TIA" /> between <paramref name="Min" /> and <paramref name="Max" />,
///	  if <paramref name="Min" /> is smaller than or equal to <paramref name="Max" />.
///	</summary>
///	<param name="TIA">
///	  The array which will be clamped between <paramref name="Min" /> and <paramref name="Max" />.
///	</param>
///	<param name="Min">
///	  The lower bound for the values.
///	</param>
///	<param name="Max">
///	  The upper bound for the values.
///	</param>
{$ENDREGION}
procedure ClampTIA(var TIA: TIntArray; const Min, Max: Integer);

implementation

uses
  OpenAPI.Math;

function TIAToStr(const TIA: TIntArray): string;
var
  ValPtr: PInteger;
  Idx, Hi: Integer;
begin
  Hi := High(TIA);
  if Hi < 0 then Exit('');
  ValPtr := @TIA[0];
  Result := '';
  for Idx := 0 to Hi do
  begin
    Result := Result + IntToStr(ValPtr^);
    if Idx <> Hi then
      Result := Result + ',';
    Inc(ValPtr);
  end;
end;

procedure ClampTIA(var TIA: TIntArray; const Min, Max: Integer);
var
  ValPtr: PInteger;
  Idx, Hi: Integer;
begin
  Hi := High(TIA);
  if Hi < 0 then Exit;
  ValPtr := @TIA[0];
  for Idx := 0 to Hi do
  begin
    ClampInt(ValPtr^, Min, Max);
    Inc(ValPtr);
  end;
end;

initialization
  // Functions documented at wiki.scar-divi.com are marked with an empty comment
{$IFDEF EXPORTS}
  TExportMngr_PS.Instance['Functions'].Add(procedure(const Engine: TPSScript)
  begin
    Engine.AddFunction(@TIAToStr, 'function TIAToStr(const TIA: TIntArray): string;'); //
    Engine.AddFunction(@ClampTIA, 'procedure ClampTIA(var TIA: TIntArray; const Min, Max: Integer);');
  end);
{$ENDIF}
end.
