unit OpenAPI.TPA;

interface

uses
  System.Types, System.Math,

  {$IFDEF EXPORTS}uPSComponent, uEngine_PascalScript,{$ENDIF}

  OpenAPI.Globals;

///	<summary>
///	  Sorts a given set of points by their Euclidean distance from the origin at 0, 0 by using the
///	  ShellSort sorting algorithm.
///	</summary>
///	<param name="TPA">
///	  The unsorted TPointArray, which will be sorted.
///	</param>
procedure SortTPA(var TPA: TPointArray);

///	<summary>
///	  Sorts a given set of points by their Euclidean distance from a given point by using the
///	  ShellSort sorting algorithm.
///	</summary>
///	<param name="TPA">
///	  The unsorted TPointArray, which will be sorted.
///	</param>
///	<param name="Point">
///	  The refence point used to calculate distances.
///	</param>
procedure SortTPAEx(var TPA: TPointArray; const Point: TPoint);

///	<summary>
///	  Combines 2 TPointArrays by appending one to the other and returning the resulting new
///	  TPointArray.
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
function CombineTPA(const TPA1, TPA2: TPointArray): TPointArray;

///	<summary>
///	  Returns True if the given TPA has zero elements.
///	</summary>
///	<param name="TPA">
///	  The TPA which will be verified.
///	</param>
///	<returns>
///	  True if TPA has zero elements, False in any other case.
///	</returns>
function TPAEmpty(const TPA: TPointArray): Boolean;

///	<summary>
///	  Offsets the coordindates of a given TPointArray.
///	</summary>
///	<param name="TPA">
///	  The TPointArray to be offset.
///	</param>
///	<param name="XOffset">
///	  The x-coordinate offset value.
///	</param>
///	<param name="YOffset">
///	  The y-coordinate offset value.
///	</param>
procedure OffsetTPA(var TPA: TPointArray; const XOffset, YOffset: Integer); inline;

///	<summary>
///	  Returns a copy of a given TPointArray.
///	</summary>
///	<param name="TPA">
///	  The TPointArray to copy.
///	</param>
///	<returns>
///	  A new TPointArray with copies of all original values in TPA.
///	</returns>
///	<remarks>
///	  This function is used to create copies of TPointArrays as arrays are passed by reference and
///	  cannot be duplicated by assignment.
///	</remarks>
function CopyTPA(const TPA: TPointArray): TPointArray;

///	<summary>
///	  Returns a subset of a given TPointArray.
///	</summary>
///	<param name="TPA">
///	  The TPointArray to copy.
///	</param>
///	<param name="Index">
///	  The index from which to start copying the TPointArray.
///	</param>
///	<param name="Count">
///	  The number of items to copy starting at Index.
///	</param>
///	<returns>
///	  A new TPointArray with copies of all original values in the subset of TPA.
///	</returns>
function CopyTPAEx(const TPA: TPointArray; const Index, Count: Integer): TPointArray;

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
  end);
{$ENDIF}
end.
