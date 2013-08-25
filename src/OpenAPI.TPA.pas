unit OpenAPI.TPA;

interface

uses
  System.Types,

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

implementation
procedure SortTPA(var TPA: TPointArray);
begin
  SortTPAEx(TPA, Point(0, 0));
end;

procedure SortTPAEx(var TPA: TPointArray; const Point: TPoint);
var
  Lo, Hi, Idx, GapIdx, Gap, Idx2: Integer;
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

initialization
  // Functions documented at wiki.scar-divi.com are marked with an empty comment
{$IFDEF EXPORTS}
  TExportMngr_PS.Instance['Functions'].Add(procedure(const Engine: TPSScript)
  begin
    Engine.AddFunction(@SortTPAEx, 'procedure SortTPAEx(var TPA: TPointArray; const Point: TPoint);'); //
    Engine.AddFunction(@SortTPA, 'procedure SortTPA(var TPA: TPointArray);'); //
  end);
{$ENDIF}
end.
