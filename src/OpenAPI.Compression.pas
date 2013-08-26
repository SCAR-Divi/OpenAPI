unit OpenAPI.Compression;

interface

uses
  ZLibEx

  {$IFDEF EXPORTS}, uPSComponent, uEngine_PascalScript{$ENDIF};

{$REGION 'Documentation'}
///	<summary>
///	  Compresses a string using the ZLib compression library.
///	</summary>
///	<param name="Str">
///	  The string to compress.
///	</param>
///	<returns>
///	  The compressed string.
///	</returns>
{$ENDREGION}
function ZLibCompress(const Str: AnsiString): AnsiString;

{$REGION 'Documentation'}
///	<summary>
///	  Decompresses a string that was compressed with the ZLib compression library.
///	</summary>
///	<param name="Str">
///	  The compressed string.
///	</param>
///	<returns>
///	  The decompressed string or an empty string if an error occurred.
///	</returns>
{$ENDREGION}
function ZLibDecompress(const Str: AnsiString): AnsiString;

implementation

function ZLibCompress(const Str: AnsiString): AnsiString;
begin
  Result := ZCompressStr(Str, zcMax);
end;

function ZLibDecompress(const Str: AnsiString): AnsiString;
begin
  try
    Result := ZDecompressStr(Str);
  except
    Result := '';
  end;
end;

initialization
  TExportMngr_PS.Instance['Functions'].Add(procedure(const Engine: TPSScript)
  begin
    Engine.AddFunction(@ZLibCompress, 'function ZLibCompress(const Str: AnsiString): AnsiString;'); //
    Engine.AddFunction(@ZLibDecompress, 'function ZLibDecompress(const Str: AnsiString): AnsiString;'); //
  end);
end.
