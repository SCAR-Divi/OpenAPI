unit OpenAPI.TPA;

interface

uses
  System.Types, System.Math, System.SysUtils,

  {$IFDEF EXPORTS}uPSComponent, uEngine_PascalScript,{$ENDIF}

  OpenAPI.Globals;

type
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  A simple alias of the Exception class to identify errors thrown by TPA functions.
  ///	</summary>
  {$ENDREGION}
  ETPAException = class(Exception);

{$REGION 'Documentation'}
///	<summary>
///	  Sorts a given set of points by their Euclidean distance from the origin at 0, 0 by using the
///	  ShellSort sorting algorithm.
///	</summary>
///	<param name="TPA">
///	  The unsorted <see cref="OpenAPI.Globals|TPointArray" />, which will be sorted.
///	</param>
///	<remarks>
///	  SortTPA calls SortTPAEx internally by referencing the point at 0, 0 as offset.
///	  <code lang="Delphi">
///	SortTPAEx(TPA, Point(0, 0));</code>
///	</remarks>
///	<seealso cref="SortTPAEx" />
{$ENDREGION}
procedure SortTPA(var TPA: TPointArray);

{$REGION 'Documentation'}
///	<summary>
///	  Sorts a given set of points by their Euclidean distance from a given point by using the
///	  ShellSort sorting algorithm.
///	</summary>
///	<param name="TPA">
///	  The unsorted <see cref="OpenAPI.Globals|TPointArray" />, which will be sorted.
///	</param>
///	<param name="Point">
///	  The refence point used to calculate distances.
///	</param>
///	<seealso cref="SortTPA" />
{$ENDREGION}
procedure SortTPAEx(var TPA: TPointArray; const Point: TPoint);

{$REGION 'Documentation'}
///	<summary>
///	  Combines 2 <see cref="OpenAPI.Globals|TPointArray">TPointArrays</see> by appending one to the
///	  other and returning the resulting new <see cref="OpenAPI.Globals|TPointArray" />.
///	</summary>
///	<param name="TPA1">
///	  The first TPointArray.
///	</param>
///	<param name="TPA2">
///	  The TPointArray which will be appended to TPA1.
///	</param>
///	<returns>
///	  A TPointArray containing TPA1 with TPA2 appended to the end.
///	</returns>
{$ENDREGION}
function CombineTPA(const TPA1, TPA2: TPointArray): TPointArray;

{$REGION 'Documentation'}
///	<summary>
///	  Returns True if the given TPA has zero elements.
///	</summary>
///	<param name="TPA">
///	  The TPA which will be verified.
///	</param>
///	<returns>
///	  True if TPA has zero elements, False in any other case.
///	</returns>
{$ENDREGION}
function TPAEmpty(const TPA: TPointArray): Boolean;

{$REGION 'Documentation'}
///	<summary>
///	  Offsets the coordindates of a given <see cref="OpenAPI.Globals|TPointArray" />.
///	</summary>
///	<param name="TPA">
///	  The <see cref="OpenAPI.Globals|TPointArray" /> to be offset.
///	</param>
///	<param name="XOffset">
///	  The x-coordinate offset value.
///	</param>
///	<param name="YOffset">
///	  The y-coordinate offset value.
///	</param>
{$ENDREGION}
procedure OffsetTPA(var TPA: TPointArray; const XOffset, YOffset: Integer); inline;

{$REGION 'Documentation'}
///	<summary>
///	  Returns a copy of a given <see cref="OpenAPI.Globals|TPointArray" />.
///	</summary>
///	<param name="TPA">
///	  The <see cref="OpenAPI.Globals|TPointArray" /> to copy.
///	</param>
///	<returns>
///	  A new <see cref="OpenAPI.Globals|TPointArray" /> with copies of all original values in TPA.
///	</returns>
///	<remarks>
///	  This function is used to create copies of
///	  <see cref="OpenAPI.Globals|TPointArray">TPointArrays</see> as arrays are passed by reference
///	  and cannot be duplicated by assignment.
///	</remarks>
///	<seealso cref="CopyTPAEx" />
{$ENDREGION}
function CopyTPA(const TPA: TPointArray): TPointArray;

{$REGION 'Documentation'}
///	<summary>
///	  Returns a subset of a given <see cref="OpenAPI.Globals|TPointArray" />.
///	</summary>
///	<param name="TPA">
///	  The TPointArray to copy.
///	</param>
///	<param name="Index">
///	  The index from which to start copying the <see cref="OpenAPI.Globals|TPointArray" />.
///	</param>
///	<param name="Count">
///	  The number of items to copy starting at Index.
///	</param>
///	<returns>
///	  A new TPointArray with copies of all original values in the subset of TPA.
///	</returns>
///	<seealso cref="CopyTPA" />
{$ENDREGION}
function CopyTPAEx(const TPA: TPointArray; const Index, Count: Integer): TPointArray;

{$REGION 'Documentation'}
///	<summary>
///	  Reverses the order of the elements of a given <see cref="OpenAPI.Globals|TPointArray" />.
///	</summary>
///	<param name="TPA">
///	  The <see cref="OpenAPI.Globals|TPointArray" /> which will be reversed in order.
///	</param>
{$ENDREGION}
procedure ReverseTPA(var TPA: TPointArray);

{$REGION 'Documentation'}
///	<summary>
///	  Converts a given <see cref="OpenAPI.Globals|TPointArray" /> to a string.
///	</summary>
///	<param name="TPA">
///	  The <see cref="OpenAPI.Globals|TPointArray" /> which will be converted to a string.
///	</param>
///	<returns>
///	  The string formatted as (X1,Y1);(X2,Y2);...;(Xn,Yn).
///	</returns>
{$ENDREGION}
function TPAToStr(const TPA: TPointArray): string;

{$REGION 'Documentation'}
///	<summary>
///	  Calculates the standard deviation of the sum of all x-coordinates and y-coordinates of the
///	  given <see cref="OpenAPI.Globals|TPointArray" />.
///	</summary>
///	<param name="TPA">
///	  The <see cref="OpenAPI.Globals|TPointArray" /> which will be used to calculate the standard
///	  deviations.
///	</param>
///	<param name="XSpread">
///	  The standard deviation for the x-coordinates.
///	</param>
///	<param name="YSpread">
///	  The standard deviation for the y-coordinates.
///	</param>
{$ENDREGION}
procedure TPASpread(const TPA: TPointArray; out XSpread, YSpread: Extended);

implementation

procedure SortTPA(var TPA: TPointArray);
begin
  SortTPAEx(TPA, Point(0, 0));
end;

procedure SortTPAEx(var TPA: TPointArray; const Point: TPoint);
var
  Lo, Hi, Idx, Idx2, GapIdx, Gap: Integer;
  PtDist, TmpX, TmpY: Extended; // Extended datatype to accommodate large coordinates
  Pt: TPoint;
  Dists: TExtArray;
begin
  Lo := Low(TPA); Hi := High(TPA);
  if Hi - Lo + 1 <= 1 then Exit;
  SetLength(Dists, Hi - Lo + 1);
  for Idx := Lo to Hi do
  begin
    TmpX := TPA[Idx].X - Point.X; TmpY := TPA[Idx].Y - Point.Y;
    Dists[Idx] := TmpX * TmpX + TmpY * TmpY; // No root to save computation time
  end;
  for GapIdx := 0 to 25 do
  begin
    Gap := SHELLGAPS[GapIdx];
    for Idx := Lo + Gap to Hi do
    begin
      PtDist := Dists[Idx];
      Pt := TPA[Idx];
      Idx2 := Idx;
      while ((Idx2 >= Gap) and (Dists[Idx2 - Gap] > PtDist)) do
      begin
        Dists[Idx2] := Dists[Idx2 - Gap];
        TPA[Idx2] := TPA[Idx2 - Gap];
        Idx2 := Idx2 - Gap;
      end;
      Dists[Idx2] := PtDist;
      TPA[Idx2] := Pt;
    end;
  end;
end;

function CombineTPA(const TPA1, TPA2: TPointArray): TPointArray;
begin
  Result := Copy(TPA1, 0, Length(TPA1));
  SetLength(Result, Length(TPA1) + Length(TPA2));
  Move(TPA2[0], Result[Length(TPA1)], Length(TPA2) * SizeOf(TPoint));
end;

function TPAEmpty(const TPA: TPointArray): Boolean;
begin
  Result := Length(TPA) = 0;
end;

procedure OffsetTPA(var TPA: TPointArray; const XOffset, YOffset: Integer); inline;
var
  PtPtr, PtPtrMax: PPoint;
begin
  PtPtr := @TPA[0];
  PtPtrMax := PtPtr; Inc(PtPtrMax, Length(TPA));
  while PtPtr <> PtPtrMax do
  begin
    Inc(PtPtr^.X, XOffset);
    Inc(PtPtr^.Y, YOffset);
    Inc(PtPtr);
  end;
end;

function CopyTPA(const TPA: TPointArray): TPointArray;
begin
  Result := Copy(TPA, 0, Length(TPA));
end;

function CopyTPAEx(const TPA: TPointArray; const Index, Count: Integer): TPointArray;
begin
  Result := Copy(TPA, Max(0, Index), Min(Length(TPA), Count));
end;

procedure ReverseTPA(var TPA: TPointArray);
var
  Pt: TPoint;
  PtPtrLeft, PtPtrRight: PPoint;
  Idx, Hi, Mid: Integer;
begin
  Hi := High(TPA);
  if Hi < 1 then Exit;
  Mid := Hi div 2;
  PtPtrLeft := @TPA[0];
  PtPtrRight := @TPA[Hi];
  for Idx := 0 to Mid do
  begin
    Pt := PtPtrLeft^;
    PtPtrLeft^ := PtPtrRight^;
    PtPtrRight^ := Pt;
    Inc(PtPtrLeft);
    Dec(PtPtrRight);
  end;
end;

function TPAToStr(const TPA: TPointArray): string;
var
  PtPtr: PPoint;
  Idx, Hi: Integer;
begin
  Hi := High(TPA);
  if Hi >= 0 then Exit('');
  PtPtr := @TPA[0];
  Result := '';
  for Idx := 0 to Hi do
  begin
    Result := Result + '(' + IntToStr(PtPtr^.X) + ',' + IntToStr(PtPtr^.Y) + ')';
    if Idx <> Hi then
      Result := Result + ';';
    Inc(PtPtr);
  end;
end;

procedure TPASpread(const TPA: TPointArray; out XSpread, YSpread: Extended);
var
  XValues, YValues: array of Extended;
  Len: Integer;
  PtPtr, PtPtrMax: PPoint;
  XPtr, YPtr: PExtended;
begin
  Len := Length(TPA);
  SetLength(XValues, Len);
  SetLength(YValues, Len);
  // Set up pointers
  PtPtr := @TPA[0];
  PtPtrMax := PtPtr;
  Inc(PtPtrMax, Len);
  XPtr := @XValues[0];
  YPtr := @YValues[0];
  // Split coordinates
  while PtPtr <> PtPtrMax do
  begin
    XPtr^ := PtPtr^.X;
    YPtr^ := PtPtr^.Y;
    Inc(PtPtr);
    Inc(XPtr);
    Inc(YPtr);
  end;
  // Calculate standard deviation of coordinates
  XSpread := StdDev(XValues);
  YSpread := StdDev(YValues);
end;

initialization
  // Functions documented at wiki.scar-divi.com are marked with an empty comment
{$IFDEF EXPORTS}
  TExportMngr_PS.Instance['Functions'].Add(procedure(const Engine: TPSScript)
  begin
    Engine.AddFunction(@SortTPA, 'procedure SortTPA(var TPA: TPointArray);'); //
    Engine.AddFunction(@SortTPAEx, 'procedure SortTPAEx(var TPA: TPointArray; const Point: TPoint);'); //
    Engine.AddFunction(@CombineTPA, 'function CombineTPA(const TPA1, TPA2: TPointArray): TPointArray;'); //
    Engine.AddFunction(@TPAEmpty, 'function TPAEmpty(const TPA: TPointArray): Boolean;'); //
    Engine.AddFunction(@OffsetTPA, 'procedure OffsetTPA(var TPA: TPointArray; const XOffset, YOffset: Integer);'); //
    Engine.AddFunction(@CopyTPA, 'function CopyTPA(const TPA: TPointArray): TPointArray;'); //
    Engine.AddFunction(@CopyTPAEx, 'function CopyTPAEx(const TPA: TPointArray; const Index, Count: Integer): TPointArray;'); //
    Engine.AddFunction(@ReverseTPA, 'procedure ReverseTPA(var TPA: TPointArray);'); //
    Engine.AddFunction(@TPAToStr, 'function TPAToStr(const TPA: TPointArray): string;'); //
    Engine.AddFunction(@TPASpread, 'procedure TPASpread(const TPA: TPointArray; out XSpread, YSpread: Extended);');
  end);
{$ENDIF}
end.
