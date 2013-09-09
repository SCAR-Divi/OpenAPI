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
    FLast: Int64;
    FElapsed: Extended;
    FCount: Integer;
    FIvals: TExtArray;
    FActive: Boolean;
    function GetIvalMean: Extended;
    function GetIvals(const Idx: Integer): Extended;
  public
    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Creates an instance of the class.
    ///	</summary>
    {$ENDREGION}
    constructor Create;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Startes/resets the chrono instance. Elapsed time will be measured from the point where
    ///	  this method was called. All previously measured intervals are erased when calling this
    ///	  method.
    ///	</summary>
    {$ENDREGION}
    procedure Start;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Marks the time elapsed since the last marking, with the call to
    ///	  <see cref="Start">Start</see>being the first mark. The interval will be stored internally
    ///	  as well as being returned.
    ///	</summary>
    ///	<returns>
    ///	  The time elapsed since the last mark.
    ///	</returns>
    {$ENDREGION}
    function Mark: Extended;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Stops measuring the elapsed time and returns the time elapsed since the start, as well as
    ///	  storing the last interval.
    ///	</summary>
    {$ENDREGION}
    function Stop: Extended;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Returns the amount of time elapsed since <see cref="Start">Start</see> was called.
    ///	</summary>
    ///	<returns>
    ///	  The elapsed time.
    ///	</returns>
    {$ENDREGION}
    function Check: Extended;

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
    {$ENDREGION}
    property Ivals[const Idx: Integer]: Extended read GetIvals;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The arithmetic mean of all measured intervals.
    ///	</summary>
    {$ENDREGION}
    property IvalMean: Extended read GetIvalMean;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  The time elapsed during the last measurement from <see cref="Start">Start</see> to
    ///	  <see cref="Stop">Stop</see>.
    ///	</summary>
    ///	<value>
    ///	  The elapsed time or -1 if the object has not been started and stopped before.
    ///	</value>
    {$ENDREGION}
    property Elapsed: Extended read FElapsed;
  end;

implementation

uses
  WinApi.Windows,

  OpenAPI.TEA;

{ TChrono }

function TChrono.Check: Extended;
var
  Counter: Int64;
begin
  if not FActive then
    raise EChronoException.Create('Chrono not active');
  Result := (FStart - Counter) / FFrequency * 1000;
end;

constructor TChrono.Create;
begin
  FActive := False;
  FElapsed := -1;
  SetLength(FIvals, 0);
  QueryPerformanceFrequency(FFrequency);
end;

function TChrono.GetIvalMean: Extended;
begin
  Result := TEAMean(FIvals);
end;

function TChrono.GetIvals(const Idx: Integer): Extended;
begin
  if (Idx < 0) or (Idx >= FCount) then
    raise EChronoException.Create('Index out of bounds');
  Result := FIvals[Idx];
end;

function TChrono.Mark: Extended;
var
  Counter: Int64;
begin
  QueryPerformanceCounter(Counter);
  SetLength(FIvals, FCount + 1);
  FIvals[FCount] := (Counter - FLast) / FFrequency * 1000;
  Inc(FCount);
  FLast := Counter;
end;

procedure TChrono.Start;
begin
  FElapsed := 0;
  SetLength(FIvals, 0);
  FCount := 0;
  FActive := True;
  QueryPerformanceCounter(FStart);
  FLast := FStart;
end;

function TChrono.Stop: Extended;
var
  Counter: Int64;
begin
  if not FActive then
    raise EChronoException.Create('Chrono not active');
  QueryPerformanceCounter(Counter);
  // Set last interval
  SetLength(FIvals, FCount + 1);
  FIvals[FCount] := (Counter - FLast) / FFrequency * 1000;
  Inc(FCount);
  // Determine total elapsed time
  FElapsed := (Counter - FStart) / FFrequency * 1000;
  Result := FElapsed;
  FActive := False;
end;

end.
