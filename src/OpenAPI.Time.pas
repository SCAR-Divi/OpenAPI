{$REGION 'Documentation'}
///	<summary>
///	  This namespace contains all time and time measurement related functions.
///	</summary>
{$ENDREGION}
unit OpenAPI.Time;

interface

uses
  System.SysUtils,

  OpenAPI.Types;

type
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  An exception type used by the TChrono class to indicate errors.
  ///	</summary>
  {$ENDREGION}
  EChronoException = class(Exception);

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Measures time intervals with greater precision than using tick count. All time measurements
  ///	  are returned as floating point millisecond values.
  ///	</summary>
  {$ENDREGION}
  TChrono = class
  private
    FFrequency: Int64;
    FStart: Int64;
    FCount: Integer;
    FIvals: TExtArray;
    FActive: Boolean;
    function GetMean: Extended;
    function GetIvals(const Idx: Integer): Extended;
    function GetTotal: Extended;
  public
    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Creates an instance of the class.
    ///	</summary>
    {$ENDREGION}
    constructor Create;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Sets a time marker. When no time is being recorded, this will initiate a measurement. If
    ///	  the object tis already been activated, it will record the time interval since the last
    ///	  time <see cref="Mark" /> was called and deactivate the object until <see cref="Mark" />
    ///	  is called again.
    ///	</summary>
    ///	<returns>
    ///	  -1 if <see cref="Mark" /> is called to initiate a measurement or the elapsed time since a
    ///	  measurement was initiated.
    ///	</returns>
    {$ENDREGION}
    function Mark: Extended;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Resets the chrono instance. This erases all recorded data.
    ///	</summary>
    {$ENDREGION}
    procedure Reset;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Determines if the object is in an active state, which means it's currently measuring
    ///	  elapsed time.
    ///	</summary>
    ///	<value>
    ///	  True if the object is in an active state.
    ///	</value>
    {$ENDREGION}
    property Active: Boolean read FActive;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The number of time intervals last recorded.
    ///	</summary>
    {$ENDREGION}
    property Count: Integer read FCount;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  All time intervals last measured.
    ///	</summary>
    ///	<param name="Idx">
    ///	  The index of the stored interval.
    ///	</param>
    ///	<value>
    ///	  The requested interval.
    ///	</value>
    ///	<exception cref="EChronoException">
    ///	  If the index is out of bounds.
    ///	</exception>
    {$ENDREGION}
    property Ivals[const Idx: Integer]: Extended read GetIvals;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The arithmetic mean of all measured intervals.
    ///	</summary>
    {$ENDREGION}
    property Mean: Extended read GetMean;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Returns the total amount of time elapsed curing all recorded intervals.
    ///	</summary>
    ///	<value>
    ///	  The total elapsed time.
    ///	</value>
    {$ENDREGION}
    property Total: Extended read GetTotal;
  end;

implementation

uses
  WinApi.Windows,

  OpenAPI.TEA;

{ TChrono }

constructor TChrono.Create;
begin
  Reset;
  QueryPerformanceFrequency(FFrequency);
end;

function TChrono.GetMean: Extended;
begin
  Result := TEAMean(FIvals);
end;

function TChrono.GetIvals(const Idx: Integer): Extended;
begin
  if (Idx < 0) or (Idx >= FCount) then
    raise EChronoException.Create('Index out of bounds');
  Result := FIvals[Idx];
end;

function TChrono.GetTotal: Extended;
begin
  Result := TEASum(FIvals);
end;

function TChrono.Mark: Extended;
var
  Counter: Int64;
begin
  if FActive then
  begin
    QueryPerformanceCounter(Counter);
    Result := (Counter - FStart) / FFrequency * 1000;
    SetLength(FIvals, FCount + 1);
    FIvals[FCount] := Result;
    Inc(FCount);
    FActive := False;
  end else begin
    FActive := True;
    Result := -1;
    QueryPerformanceCounter(FStart);
  end;
end;

procedure TChrono.Reset;
begin
  FActive := False;
  SetLength(FIvals, 0);
  FCount := 0;
end;

end.
