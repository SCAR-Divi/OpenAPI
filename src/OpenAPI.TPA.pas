{$REGION 'Documentation'}
///	<summary>
///	  This namespace contains all functions relating to
///	  <see cref="OpenAPI.Globals|TPointArray">TPointArrays</see>.
///	</summary>
{$ENDREGION}
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
///	  <see href="http://en.wikipedia.org/wiki/Shellsort">ShellSort</see> sorting algorithm.
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
///	  Sorts a given set of points by their Euclidean distance from a given point by using the
///	  <see href="http://en.wikipedia.org/wiki/Shellsort">ShellSort</see> sorting algorithm.
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
///	  Combines two <see cref="OpenAPI.Globals|TPointArray">TPointArrays</see> by appending one to the
///	  other and returning the resulting new <see cref="OpenAPI.Globals|TPointArray">TPointArray</see>.
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
///	  Offsets the coordindates of a given <see cref="OpenAPI.Globals|TPointArray">TPointArray</see>.
///	</summary>
///	<param name="TPA">
///	  The <see cref="OpenAPI.Globals|TPointArray">TPointArray</see> to be offset.
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
///	  Returns a copy of a given <see cref="OpenAPI.Globals|TPointArray">TPointArray</see>.
///	</summary>
///	<param name="TPA">
///	  The <see cref="OpenAPI.Globals|TPointArray">TPointArray</see> to copy.
///	</param>
///	<returns>
///	  A new <see cref="OpenAPI.Globals|TPointArray">TPointArray</see> with copies of all original values in TPA.
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
///	  Returns a subset of a given <see cref="OpenAPI.Globals|TPointArray">TPointArray</see>.
///	</summary>
///	<param name="TPA">
///	  The TPointArray to copy.
///	</param>
///	<param name="Index">
///	  The index from which to start copying the <see cref="OpenAPI.Globals|TPointArray">TPointArray</see>.
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
///	  Reverses the order of an array of two-dimensional points.
///	</summary>
///	<param name="TPA">
///	  The array which will be reversed in order.
///	</param>
{$ENDREGION}
procedure ReverseTPA(var TPA: TPointArray);

{$REGION 'Documentation'}
///	<summary>
///	  Converts an array of two-dimensional points to a string.
///	</summary>
///	<param name="TPA">
///	  The array which will be converted to a string.
///	</param>
///	<returns>
///	  The string formatted as (X1,Y1);(X2,Y2);...;(Xn,Yn).
///	</returns>
{$ENDREGION}
function TPAToStr(const TPA: TPointArray): string;

{$REGION 'Documentation'}
///	<summary>
///	  Calculates the standard deviation of the sum of all x-coordinates and y-coordinates of the
///	  given array of two-dimensional points.
///	</summary>
///	<param name="TPA">
///	  The array of points which will be used to calculate the standard deviations.
///	</param>
///	<param name="XSpread">
///	  The standard deviation for the x-coordinates.
///	</param>
///	<param name="YSpread">
///	  The standard deviation for the y-coordinates.
///	</param>
{$ENDREGION}
procedure TPASpread(const TPA: TPointArray; out XSpread, YSpread: Extended);

{$REGION 'Documentation'}
///	<summary>
///	  Checks if two arrays of two-dimensional points have the same lengths, elements and order.
///	</summary>
///	<param name="TPA1">
///	  The first array.
///	</param>
///	<param name="TPA2">
///	  The second array.
///	</param>
///	<returns>
///	  True if the arrays are identical.
///	</returns>
{$ENDREGION}
function TPAEquals(const TPA1, TPA2: TPointArray): Boolean; inline;

{$REGION 'Documentation'}
///	<summary>
///	  Sorts a given array of two-dimensional points by ascending x-coordinates.
///	</summary>
///	<param name="TPA">
///	  The array of points that will be sorted.
///	</param>
{$ENDREGION}
procedure SortTPAByX(var TPA: TPointArray);

{$REGION 'Documentation'}
///	<summary>
///	  Sorts a given array of two-dimensional points by ascending y-coordinates.
///	</summary>
///	<param name="TPA">
///	  The array of points that will be sorted.
///	</param>
{$ENDREGION}
procedure SortTPAByY(var TPA: TPointArray);

{$REGION 'Documentation'}
///	<summary>
///	  Splits up an array of two-dimensional points by clustering all points within a certain
///	  (Euclidean) distance from each other together.
///	</summary>
///	<param name="TPA">
///	  The array of points that will be processed.
///	</param>
///	<param name="Dist">
///	  The maximum distance two points in the same cluster can be separated.
///	</param>
///	<returns>
///	  A two-dimensional array which holds all of the clustered points.
///	</returns>
///	<remarks>
///	  This is an O(N²) algorithm, it's not advised to use it on large datasets. It should handle up
///	  to at least 10000 points fairly well.
///	</remarks>
///	<seealso cref="SplitTPAEx" />
{$ENDREGION}
function SplitTPA(const TPA: TPointArray; const Dist: Integer): T2DPointArray;

{$REGION 'Documentation'}
///	<summary>
///	  Splits up an array of two-dimensional points by clustering all points within a certain
///	  distance from each other together.
///	</summary>
///	<param name="TPA">
///	  The array of points that will be processed.
///	</param>
///	<param name="XMax">
///	  The maximum distance on the x-axis.
///	</param>
///	<param name="YMax">
///	  The maximum distance on the y-axis.
///	</param>
///	<param name="Dist">
///	  The maximum distance two points in the same cluster can be separated.
///	</param>
///	<returns>
///	  A two-dimensional array which holds all of the clustered points.
///	</returns>
///	<remarks>
///	  This is an O(N²) algorithm, it's not advised to use it on large datasets. It should handle up
///	  to at least 10000 points fairly well.
///	</remarks>
///	<seealso cref="SplitTPA" />
{$ENDREGION}
function SplitTPAEx(const TPA: TPointArray; const XMax, YMax: Integer): T2DPointArray;

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

function TPAEquals(const TPA1, TPA2: TPointArray): Boolean; inline;
var
  Idx, Len1, Len2: Integer;
  PtPtrP1, PtPtrP2: PPoint;
begin
  Result := False;
  Len1 := Length(TPA1);
  Len2 := Length(TPA2);
  if Len1 <> Len2 then
    Exit
  else if Len1 = 0 then
    Exit(True);
  PtPtrP1 := @TPA1[0];
  PtPtrP2 := @TPA2[0];
  for Idx := 0 to Len1 - 1 do
  begin
    if PtPtrP1^ <> PtPtrP2^ then
      Exit;
    Inc(PtPtrP1);
    Inc(PtPtrP2);
  end;
  Result := True;
end;

procedure SortTPAByX(var TPA: TPointArray);
var
  Lo, Hi, Idx, GapIdx, Gap, Idx2: Integer;
  Pt: TPoint;
const
  SHELLGAPS: array[0..15] of Integer = (345152, 153401, 68178, 30301, 13467, 5985, 2660, 1182, 525, 233, 103, 46, 20, 9, 4, 1);
begin
  Lo := Low(TPA); Hi := High(TPA);
  if Hi - Lo + 1 <= 1 then Exit;
  for GapIdx := 0 to 15 do
  begin
    Gap := SHELLGAPS[GapIdx];
    for Idx := Lo + Gap to Hi do
    begin
      Pt := TPA[Idx];
      Idx2 := Idx;
      while ((Idx2 >= Gap) and (TPA[Idx2 - Gap].X > Pt.X)) do
      begin
        TPA[Idx2] := TPA[Idx2 - Gap];
        Idx2 := Idx2 - Gap;
      end;
      TPA[Idx2] := Pt;
    end;
  end;
end;

procedure SortTPAByY(var TPA: TPointArray);
var
  Lo, Hi, Idx, GapIdx, Gap, Idx2: Integer;
  Pt: TPoint;
const
  SHELLGAPS: array[0..15] of Integer = (345152, 153401, 68178, 30301, 13467, 5985, 2660, 1182, 525, 233, 103, 46, 20, 9, 4, 1);
begin
  Lo := Low(TPA); Hi := High(TPA);
  if Hi - Lo + 1 <= 1 then Exit;
  for GapIdx := 0 to 15 do
  begin
    Gap := SHELLGAPS[GapIdx];
    for Idx := Lo + Gap to Hi do
    begin
      Pt := TPA[Idx];
      Idx2 := Idx;
      while ((Idx2 >= Gap) and (TPA[Idx2 - Gap].Y > Pt.Y)) do
      begin
        TPA[Idx2] := TPA[Idx2 - Gap];
        Idx2 := Idx2 - Gap;
      end;
      TPA[Idx2] := Pt;
    end;
  end;
end;

function SplitTPA(const TPA: TPointArray; const Dist: Integer): T2DPointArray;
var
  Len, DistSqr, ResPos, ResAPos, Idx, IdxCheck, XDiff, YDiff: Integer;
  Points: TPointArray;
  Checked: TBoolArray;
  Active: TSimpleStack<TPoint>;
  Pt, PtCheck: TPoint;
begin
  // Setup
  Len := Length(TPA);
  if Len = 0 then Exit;
  DistSqr := Dist * Dist;
  Points := Copy(TPA);
  SortTPAByX(Points); // Sort by X for sweepline
  SetLength(Checked, Len);
  FillChar(Checked[0], Len * SizeOf(Boolean), 0); // Set all values in Checked to False
  SetLength(Result, Len);
  ResPos := 0;
  Idx := 0;
  Active.Setup;
  // Start sweep
  while Idx < Len do
  begin
    if not Checked[Idx] then
    begin
      // Init new result array
      SetLength(Result[ResPos], 1);
      Pt := Points[Idx];
      Result[ResPos][0] := Pt;
      ResAPos := 1;
      Checked[Idx] := True;
      Active.Push(Pt);
      // Process current point
      while not Active.IsEmpty do
      begin
        Pt := Active.Pop;
        IdxCheck := Idx + 1;
        // Evaluate remaining points
        while IdxCheck < Len do
        begin
          if not Checked[IdxCheck] then
          begin
            PtCheck := Points[IdxCheck];
            XDiff := PtCheck.X - Pt.X;
            // If the next point has an X distance larger than the allowed distance, all of the following
            // points are out of range, as the points were sorted by increasing X coordinate.
            if XDiff > Dist then Break;
            YDiff := PtCheck.Y - Pt.Y;
            if XDiff * XDiff + YDiff * YDiff <= DistSqr then
            begin
              Active.Push(PtCheck);
              SetLength(Result[ResPos], ResAPos + 1);
              Result[ResPos][ResAPos] := PtCheck;
              Checked[IdxCheck] := True;
              Inc(ResAPos);
              if IdxCheck = Idx + 1 then
                Inc(Idx);
            end;
          end;
          Inc(IdxCheck);
        end;
      end;
      Inc(ResPos);
    end;
    Inc(Idx);
  end;
  SetLength(Result, ResPos);
end;

function SplitTPAEx(const TPA: TPointArray; const XMax, YMax: Integer): T2DPointArray;
var
  Len, ResPos, ResAPos, Idx, IdxCheck, XDiff, YDiff: Integer;
  Points: TPointArray;
  Checked: TBoolArray;
  Active: TSimpleStack<TPoint>;
  Pt, PtCheck: TPoint;
begin
  // Setup
  Len := Length(TPA);
  if Len = 0 then Exit;
  Points := Copy(TPA);
  SortTPAByX(Points); // Sort by X for sweepline
  SetLength(Checked, Len);
  FillChar(Checked[0], Len * SizeOf(Boolean), 0); // Set all values in Checked to False
  SetLength(Result, Len);
  ResPos := 0;
  Idx := 0;
  Active.Setup;
  // Start sweep
  while Idx < Len do
  begin
    if not Checked[Idx] then
    begin
      // Init new result array
      SetLength(Result[ResPos], 1);
      Pt := Points[Idx];
      Result[ResPos][0] := Pt;
      ResAPos := 1;
      Checked[Idx] := True;
      Active.Push(Pt);
      // Process current point
      while not Active.IsEmpty do
      begin
        Pt := Active.Pop;
        IdxCheck := Idx + 1;
        // Evaluate remaining points
        while IdxCheck < Len do
        begin
          if not Checked[IdxCheck] then
          begin
            PtCheck := Points[IdxCheck];
            XDiff := PtCheck.X - Pt.X;
            // If the next point has an X distance larger than the allowed distance, all of the following
            // points are out of range, as the points were sorted by increasing X coordinate.
            if XDiff > XMax then Break;
            YDiff := PtCheck.Y - Pt.Y;
            if (XDiff <= XMax) and (YDiff <= YMax) then
            begin
              Active.Push(PtCheck);
              SetLength(Result[ResPos], ResAPos + 1);
              Result[ResPos][ResAPos] := PtCheck;
              Checked[IdxCheck] := True;
              Inc(ResAPos);
              if IdxCheck = Idx + 1 then
                Inc(Idx);
            end;
          end;
          Inc(IdxCheck);
        end;
      end;
      Inc(ResPos);
    end;
    Inc(Idx);
  end;
  SetLength(Result, ResPos);
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
    Engine.AddFunction(@TPAEquals, 'function TPAEquals(const TPA1, TPA2: TPointArray): Boolean;'); //
    Engine.AddFunction(@SortTPAByX, 'procedure SortTPAByX(var TPA: TPointArray);');
    Engine.AddFunction(@SortTPAByY, 'procedure SortTPAByY(var TPA: TPointArray);');
    Engine.AddFunction(@SplitTPA, 'function SplitTPA(const TPA: TPointArray; const Dist: Integer): T2DPointArray;'); //
    Engine.AddFunction(@SplitTPAEx, 'function SplitTPAEx(const TPA: TPointArray; const XMax, YMax: Integer): T2DPointArray;'); //
  end);
{$ENDIF}
end.
