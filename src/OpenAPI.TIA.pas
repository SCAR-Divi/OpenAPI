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

  OpenAPI.Globals;

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

implementation

function TIAToStr(const TIA: TIntArray): string;
var
  CurPtr: PInteger;
  Idx, Hi: Integer;
begin
  Hi := High(TIA);
  if Hi < 0 then Exit('');
  CurPtr := @TIA[0];
  Result := '';
  for Idx := 0 to Hi do
  begin
    Result := Result + IntToStr(CurPtr^);
    if Idx <> Hi then
      Result := Result + ',';
    Inc(CurPtr);
  end;
end;

initialization
  // Functions documented at wiki.scar-divi.com are marked with an empty comment
{$IFDEF EXPORTS}
  TExportMngr_PS.Instance['Functions'].Add(procedure(const Engine: TPSScript)
  begin
    Engine.AddFunction(@TIAToStr, 'function TIAToStr(const TIA: TIntArray): string;'); //
  end);
{$ENDIF}
end.
