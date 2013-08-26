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

  PerlRegEx,

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
///	  The unsorted array.
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
///	  The unsorted array.
///	</param>
///	<param name="Point">
///	  The refence point used to calculate distances.
///	</param>
///	<seealso cref="SortTPA" />
{$ENDREGION}
procedure SortTPAEx(var TPA: TPointArray; const Point: TPoint);

{$REGION 'Documentation'}
///	<summary>
///	  Combines two <see cref="OpenAPI.Globals|TPointArray">TPointArrays</see> by appending one to
///	  the other and returning the resulting array.
///	</summary>
///	<param name="TPA1">
///	  The first TPointArray.
///	</param>
///	<param name="TPA2">
///	  The array which will be appended to <paramref name="TPA1" />.
///	</param>
///	<returns>
///	  A TPointArray containing TPA1 with TPA2 appended to the end.
///	</returns>
///	<remarks>
///	  The resulting array is a copy, it does not reference <paramref name="TPA1" /> or
///	  <paramref name="TPA2" />, as a result, these arrays remain unchanged.
///	</remarks>
{$ENDREGION}
function CombineTPA(const TPA1, TPA2: TPointArray): TPointArray;

{$REGION 'Documentation'}
///	<summary>
///	  Returns True if <paramref name="TPA" /> has zero elements.
///	</summary>
///	<param name="TPA">
///	  The array which will be verified.
///	</param>
///	<returns>
///	  True if <paramref name="TPA" /> has zero elements, False in any other case.
///	</returns>
{$ENDREGION}
function TPAEmpty(const TPA: TPointArray): Boolean;

{$REGION 'Documentation'}
///	<summary>
///	  Offsets the coordindates of a given <paramref name="TPA" />.
///	</summary>
///	<param name="TPA">
///	  The array to be offset.
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
///	  Returns a copy of <paramref name="TPA" />.
///	</summary>
///	<param name="TPA">
///	  The array to copy.
///	</param>
///	<returns>
///	  A new array with copies of all original values in TPA.
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
///	  Returns a subset of <paramref name="TPA" />.
///	</summary>
///	<param name="TPA">
///	  The TPointArray to copy.
///	</param>
///	<param name="Index">
///	  The index from which to start copying the array.
///	</param>
///	<param name="Count">
///	  The number of items to copy starting at Index.
///	</param>
///	<returns>
///	  A new array with copies of all original values in the subset of TPA.
///	</returns>
///	<seealso cref="CopyTPA" />
{$ENDREGION}
function CopyTPAEx(const TPA: TPointArray; const Index, Count: Integer): TPointArray;

{$REGION 'Documentation'}
///	<summary>
///	  Reverses the order of <paramref name="TPA" />.
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
///	  Converts a string to a <see cref="OpenAPI.Globals|TPointArray">TPointArray</see>.
///	</summary>
///	<param name="Str">
///	  The string containing the points.
///	</param>
///	<remarks>
///	  The conversion of the string is done using a flexible regular expression:
///	  (-?\d+)\s*,\s*(-?\d+)
///	  <note type="note">
///	    Match the regular expression below and capture its match into backreference number 1
///	    «(-?\d+)»<br />    Match the character “-” literally «-?»<br />        Between zero and one
///	    times, as many times as possible, giving back as needed (greedy) «?»<br />    Match a
///	    single digit 0..9 «\d+»<br />        Between one and unlimited times, as many times as
///	    possible, giving back as needed (greedy) «+»<br />Match a single character that is a
///	    “whitespace character” (spaces, tabs, and line breaks) «\s*»<br />    Between zero and
///	    unlimited times, as many times as possible, giving back as needed (greedy) «*»<br />Match
///	    the character “,” literally «,»<br />Match a single character that is a “whitespace
///	    character” (spaces, tabs, and line breaks) «\s*»<br />    Between zero and unlimited times,
///	    as many times as possible, giving back as needed (greedy) «*»<br />Match the regular
///	    expression below and capture its match into backreference number 2 «(-?\d+)»<br />    Match
///	    the character “-” literally «-?»<br />        Between zero and one times, as many times as
///	    possible, giving back as needed (greedy) «?»<br />    Match a single digit 0..9 «\d+»
///	    <br />        Between one and unlimited times, as many times as possible, giving back as
///	    needed (greedy) «+»
///	  </note>
///	</remarks>
{$ENDREGION}
function StrToTPA(const Str: string): TPointArray;

{$REGION 'Documentation'}
///	<summary>
///	  Calculates the standard deviation of the sum of all x-coordinates and y-coordinates of the
///	  <paramref name="TPA" />.
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
///	  Checks <paramref name="TPA1" /> and <paramref name="TPA2" /> have the same lengths, elements
///	  and order.
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
///	  Sorts <paramref name="TPA" /> by ascending x-coordinates.
///	</summary>
///	<param name="TPA">
///	  The array of points that will be sorted.
///	</param>
{$ENDREGION}
procedure SortTPAByX(var TPA: TPointArray);

{$REGION 'Documentation'}
///	<summary>
///	  Sorts a <paramref name="TPA" /> by ascending y-coordinates.
///	</summary>
///	<param name="TPA">
///	  The array of points that will be sorted.
///	</param>
{$ENDREGION}
procedure SortTPAByY(var TPA: TPointArray);

{$REGION 'Documentation'}
///	<summary>
///	  Splits up <paramref name="TPA" /> by clustering all points within a certain (Euclidean)
///	  distance from each other together.
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
///	  Splits up <paramref name="TPA" /> by clustering all points within a certain distance from
///	  each other together.
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

{$REGION 'Documentation'}
///	<summary>
///	  Fills every cell in <paramref name="TPA" /> with <paramref name="Value" />.
///	</summary>
///	<param name="TPA">
///	  The array that will be filled.
///	</param>
///	<param name="Value">
///	  The value the array will be filled with.
///	</param>
{$ENDREGION}
procedure FillTPA(var TPA: TPointArray; const Value: TPoint);

{$REGION 'Documentation'}
///	<summary>
///	  Fills the cells in <paramref name="TPA" /> with the values in <paramref name="Values" />.
///	</summary>
///	<param name="TPA">
///	  The array that will be filled.
///	</param>
///	<param name="Values">
///	  The array of values that will be used to fill <paramref name="TPA" />.
///	</param>
///	<remarks>
///	  The function cycles through the points in <paramref name="Values" /> if it's size is smaller
///	  than <paramref name="TPA" />'s.
///	</remarks>
{$ENDREGION}
procedure FillTPAEx(var TPA: TPointArray; const Values: TPointArray);

{$REGION 'Documentation'}
///	<summary>
///	  Removes the last item from <paramref name="TPA" /> and returns it.
///	</summary>
///	<param name="TPA">
///	  The array that will be processed.
///	</param>
///	<returns>
///	  The last value found in <paramref name="TPA" />.
///	</returns>
///	<exception cref="ETPAException">
///	  If <paramref name="TPA" /> is empty.
///	</exception>
{$ENDREGION}
function TPAPop(var TPA: TPointArray): TPoint;

{$REGION 'Documentation'}
///	<summary>
///	  Removes the first or last item from <paramref name="TPA" /> and returns it.
///	</summary>
///	<param name="TPA">
///	  The array that will be processed.
///	</param>
///	<param name="Front">
///	  If True, the first item at index zero will be removed, else the last item.
///	</param>
///	<returns>
///	  The last value found in <paramref name="TPA" />.
///	</returns>
///	<exception cref="ETPAException">
///	  If <paramref name="TPA" /> is empty.
///	</exception>
{$ENDREGION}
function TPAPopEx(var TPA: TPointArray; const Front: Boolean): TPoint;

{$REGION 'Documentation'}
///	<summary>
///	  Returns the boundaries of <paramref name="TPA" /> as a <see cref="OpenAPI.Globals|TBox">TBox</see>.
///	</summary>
///	<param name="TPA">
///	  The array which will be processed.
///	</param>
///	<returns>
///	  The smallest box that will encapsulate all points in <paramref name="TPA" />.
///	</returns>
{$ENDREGION}
function TPABounds(const TPA: TPointArray): TBox;

{$REGION 'Documentation'}
///	<summary>
///	  Checks if <paramref name="Point" /> is part of <paramref name="TPA" />.
///	</summary>
///	<param name="TPA">
///	  The reference array.
///	</param>
///	<param name="Point">
///	  The point to search for.
///	</param>
///	<returns>
///	  True if <paramref name="Point" /> was found in <paramref name="TPA" />.
///	</returns>
{$ENDREGION}
function TPAContains(const TPA: TPointArray; const Point: TPoint): Boolean; inline;

{$REGION 'Documentation'}
///	<summary>
///	  Determines the dimensions of the smallest box which can encase all of the points in
///	  <paramref name="TPA" />.
///	</summary>
///	<param name="TPA">
///	  The array to evaluate.
///	</param>
///	<param name="Width">
///	  The outputted width.
///	</param>
///	<param name="Height">
///	  The outputted height.
///	</param>
{$ENDREGION}
procedure TPADimensions(const TPA: TPointArray; out Width, Height: Integer);

{$REGION 'Documentation'}
///	<summary>
///	  Returns the area of the smallest box that can encase all of the points in
///	  <paramref name="TPA" />.
///	</summary>
///	<param name="TPA">
///	  The array to evaluate.
///	</param>
///	<returns>
///	  The area of <paramref name="TPA" />.
///	</returns>
{$ENDREGION}
function TPAArea(const TPA: TPointArray): Integer;

{$REGION 'Documentation'}
///	<summary>
///	  Returns the density of the points within the area of <paramref name="TPA" />.
///	</summary>
///	<param name="TPA">
///	  The array to evaluate.
///	</param>
///	<returns>
///	  The density of <paramref name="TPA" />.
///	</returns>
{$ENDREGION}
function TPADensity(const TPA: TPointArray): Extended;

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
  CurPtr, MaxPtr: PPoint;
begin
  CurPtr := @TPA[0];
  MaxPtr := CurPtr; Inc(MaxPtr, Length(TPA));
  while CurPtr <> MaxPtr do
  begin
    Inc(CurPtr^.X, XOffset);
    Inc(CurPtr^.Y, YOffset);
    Inc(CurPtr);
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
  LeftPtr, RightPtr: PPoint;
  Idx, Hi, Mid: Integer;
begin
  Hi := High(TPA);
  if Hi < 1 then Exit;
  Mid := Hi div 2;
  LeftPtr := @TPA[0];
  RightPtr := @TPA[Hi];
  for Idx := 0 to Mid do
  begin
    Pt := LeftPtr^;
    LeftPtr^ := RightPtr^;
    RightPtr^ := Pt;
    Inc(LeftPtr);
    Dec(RightPtr);
  end;
end;

function TPAToStr(const TPA: TPointArray): string;
var
  CurPtr: PPoint;
  Idx, Hi: Integer;
begin
  Hi := High(TPA);
  if Hi >= 0 then Exit('');
  CurPtr := @TPA[0];
  Result := '';
  for Idx := 0 to Hi do
  begin
    Result := Result + '(' + IntToStr(CurPtr^.X) + ',' + IntToStr(CurPtr^.Y) + ')';
    if Idx <> Hi then
      Result := Result + ';';
    Inc(CurPtr);
  end;
end;

function StrToTPA(const Str: string): TPointArray;
var
  Regex: TPerlRegEx;
  l: Integer;
begin
  SetLength(Result, 0);
  if Str = '' then Exit;
  Regex := TPerlRegEx.Create;
  try
    Regex.Options := [preCaseLess];
    Regex.RegEx := '(-?\d+)\s*,\s*(-?\d+)';
    Regex.Subject := Str;
    if Regex.Match then
      repeat
        l := Length(Result);
        SetLength(Result, l + 1);
        Result[l].X := StrToInt(Regex.Groups[1]);
        Result[l].Y := StrToInt(Regex.Groups[2]);
      until not Regex.MatchAgain;
  finally
    Regex.Free;
  end;
end;

procedure TPASpread(const TPA: TPointArray; out XSpread, YSpread: Extended);
var
  XValues, YValues: array of Extended;
  Len: Integer;
  CurPtr, MaxPtr: PPoint;
  XPtr, YPtr: PExtended;
begin
  Len := Length(TPA);
  SetLength(XValues, Len);
  SetLength(YValues, Len);
  // Set up pointers
  CurPtr := @TPA[0];
  MaxPtr := CurPtr;
  Inc(MaxPtr, Len);
  XPtr := @XValues[0];
  YPtr := @YValues[0];
  // Split coordinates
  while CurPtr <> MaxPtr do
  begin
    XPtr^ := CurPtr^.X;
    YPtr^ := CurPtr^.Y;
    Inc(CurPtr);
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
  Ptr1, Ptr2: PPoint;
begin
  Result := False;
  Len1 := Length(TPA1);
  Len2 := Length(TPA2);
  if Len1 <> Len2 then
    Exit
  else if Len1 = 0 then
    Exit(True);
  Ptr1 := @TPA1[0];
  Ptr2 := @TPA2[0];
  for Idx := 0 to Len1 - 1 do
  begin
    if Ptr1^ <> Ptr2^ then
      Exit;
    Inc(Ptr1);
    Inc(Ptr2);
  end;
  Result := True;
end;

procedure SortTPAByX(var TPA: TPointArray);
var
  Lo, Hi, Idx, GapIdx, Gap, Idx2: Integer;
  Pt: TPoint;
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
  // TODO: Investigate Stack vs Queue performance (as stack checks points in reverse order)
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

procedure FillTPA(var TPA: TPointArray; const Value: TPoint);
var
  Len: Integer;
  CurPtr, MaxPtr: PPoint;
begin
  Len := Length(TPA);
  if Len = 0 then Exit;
  CurPtr := @TPA[0];
  MaxPtr := @TPA[0];
  Inc(MaxPtr, Len);
  repeat
    CurPtr^ := Value;
    Inc(CurPtr);
  until CurPtr = MaxPtr;
end;

procedure FillTPAEx(var TPA: TPointArray; const Values: TPointArray);
var
  Idx, Len, VLen: Integer;
  CurPtr: PPoint;
begin
  Len := Length(TPA);
  if Len = 0 then Exit;
  VLen := Length(Values);
  if VLen = 0 then
    raise ETPAException.Create('No values given!');
  CurPtr := @TPA[0];
  for Idx := 0 to Len - 1 do
  begin
    CurPtr^ := Values[Idx mod VLen];
    Inc(CurPtr);
  end;
end;

function TPAPop(var TPA: TPointArray): TPoint;
var
  Idx, Len: Integer;
begin
  Len := Length(TPA);
  if Len = 0 then
    raise ETPAException.Create('Array is empty!');
  Result := TPA[Len - 1];
  SetLength(TPA, Len - 1);
end;

function TPAPopEx(var TPA: TPointArray; const Front: Boolean): TPoint;
var
  Idx, Len: Integer;
begin
  if not Front then
    Result := TPAPop(TPA)
  else begin
    Len := Length(TPA);
    if Len = 0 then
      raise ETPAException.Create('Array is empty!');
    Result := TPA[0];
    Move(TPA[1], TPA[0], (Len - 1) * SizeOf(TPoint));
    SetLength(TPA, Len - 1);
  end;
end;

function TPABounds(const TPA: TPointArray): TBox;
var
  Len: Integer;
  CurPtr, MaxPtr: PPoint;
begin
  Len := Length(TPA);
  if Len = 0 then Exit;
  with Result do
  begin
    CurPtr := @TPA[0];
    X1 := CurPtr^.X;
    Y1 := CurPtr^.Y;
    X2 := CurPtr^.X;
    Y2 := CurPtr^.Y;
    if Len = 1 then Exit;
    MaxPtr := @TPA[0];
    Inc(MaxPtr, Len);
    repeat
      if X1 > CurPtr^.X then X1 := CurPtr^.X else
        if X2 < CurPtr^.X then X2 := CurPtr^.X;
      if Y1 > CurPtr^.Y then Y1 := CurPtr^.Y else
        if Y2 < CurPtr^.Y then Y2 := CurPtr^.Y;
      Inc(CurPtr);
    until CurPtr = MaxPtr;
  end;
end;

function TPAContains(const TPA: TPointArray; const Point: TPoint): Boolean; inline;
var
  CurPtr, MaxPtr: PPoint;
begin
  Result := False;
  CurPtr := @TPA[0];
  MaxPtr := CurPtr; Inc(MaxPtr, Length(TPA));
  while CurPtr <> MaxPtr do
  begin
    if (CurPtr^.X = Point.X) and (CurPtr^.Y = Point.Y) then Exit(True);
    Inc(CurPtr);
  end;
end;

procedure TPADimensions(const TPA: TPointArray; out Width, Height: Integer);
var
  Box: TBox;
begin
  Box := TPABounds(TPA);
  Width := Box.X2 - Box.X1 + 1;
  Height := Box.Y2 - Box.Y1 + 1;
end;

function TPAArea(const TPA: TPointArray): Integer;
var
  Width, Height: Integer;
begin
  TPADimensions(TPA, Width, Height);
  Result := Width * Height;
end;

function TPADensity(const TPA: TPointArray): Extended;
begin
  Result := Length(TPA) / TPAArea(TPA);
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
    Engine.AddFunction(@StrToTPA, 'function StrToTPA(const Str: string): TPointArray;'); //
    Engine.AddFunction(@TPASpread, 'procedure TPASpread(const TPA: TPointArray; out XSpread, YSpread: Extended);');
    Engine.AddFunction(@TPAEquals, 'function TPAEquals(const TPA1, TPA2: TPointArray): Boolean;'); //
    Engine.AddFunction(@SortTPAByX, 'procedure SortTPAByX(var TPA: TPointArray);');
    Engine.AddFunction(@SortTPAByY, 'procedure SortTPAByY(var TPA: TPointArray);');
    Engine.AddFunction(@SplitTPA, 'function SplitTPA(const TPA: TPointArray; const Dist: Integer): T2DPointArray;'); //
    Engine.AddFunction(@SplitTPAEx, 'function SplitTPAEx(const TPA: TPointArray; const XMax, YMax: Integer): T2DPointArray;'); //
    Engine.AddFunction(@FillTPA, 'procedure FillTPA(var TPA: TPointArray; const Value: TPoint);');
    Engine.AddFunction(@FillTPAEx, 'procedure FillTPAEx(var TPA: TPointArray; const Values: TPointArray);');
    Engine.AddFunction(@TPAPop, 'function TPAPop(var TPA: TPointArray): TPoint;');
    Engine.AddFunction(@TPAPopEx, 'function TPAPopEx(var TPA: TPointArray; const Front: Boolean): TPoint;');
    Engine.AddFunction(@TPABounds, 'function TPABounds(const TPA: TPointArray): TBox;'); //
    Engine.AddFunction(@TPAContains, 'function TPAContains(const TPA: TPointArray; const Point: TPoint): Boolean;'); //
    Engine.AddFunction(@TPADimensions, 'procedure TPADimensions(const TPA: TPointArray; out Width, Height: Integer);'); //
    Engine.AddFunction(@TPAArea, 'function TPAArea(const TPA: TPointArray): Integer;'); //
    Engine.AddFunction(@TPADensity, 'function TPADensity(const TPA: TPointArray): Extended;'); //
  end);
{$ENDIF}
end.
