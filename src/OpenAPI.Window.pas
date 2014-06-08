unit OpenAPI.Window;

interface

uses
  WinApi.Windows,

  OpenAPI.Types;

{$REGION 'Documentation'}
///	<summary>
///	  Returns a handle to the desktop window.
///	</summary>
///	<returns>
///	  The desktop window handle.
///	</returns>
///	<remarks>
///	  The desktop window is the area that covers the monitor(s) where the taskbar is visible.
///	</remarks>
///	<seealso cref="GetShellWindow" />
///	<seealso cref="GetActiveWindow" />
{$ENDREGION}
function GetDesktopWindow: HWND;

{$REGION 'Documentation'}
///	<summary>
///	  Returns a handle to the shell window.
///	</summary>
///	<returns>
///	  The shell window handle.
///	</returns>
///	<remarks>
///	  The shell window is the area that covers all monitors.
///	</remarks>
///	<seealso cref="GetDesktopWindow" />
///	<seealso cref="GetActiveWindow" />
{$ENDREGION}
function GetShellWindow: HWND;

{$REGION 'Documentation'}
///	<summary>
///	  Returns a handle to the currently active/foreground window.
///	</summary>
///	<returns>
///	  The active window handle.
///	</returns>
///	<seealso cref="GetDesktopWindow" />
///	<seealso cref="GetShellWindow" />
{$ENDREGION}
function GetActiveWindow: HWND;

{$REGION 'Documentation'}
///	<summary>
///	  Returns the handle of the parent window of a given window.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<returns>
///	  The handle of the parent window or 0 if the window has no parent.
///	</returns>
///	<seealso cref="GetOuterWindow" />
{$ENDREGION}
function GetParentWindow(const Wnd: HWND): HWND;

{$REGION 'Documentation'}
///	<summary>
///	  Returns a <see cref="OpenAPI.Types|TBox" /> with the coordinates of a given window or its client area.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<param name="ClientArea">
///	  If set to true, the resolting box will contain the coordinates of the window's client area, rather than the
///   entire window.
///	</param>
///	<returns>
///	  The box with the window or its client area's coordinates.
///	</returns>
///	<remarks>
///	  The function will return a <see cref="OpenAPI.Types|TBox" /> with all 0 elements if the given window is invalid.
///	</remarks>
///	<seealso cref="GetWindowBox" />
///	<seealso cref="SetWindowBox" />
///	<seealso cref="GetWindowSize" />
{$ENDREGION}
function GetWindowBoxEx(const Wnd: HWND; const ClientArea: Boolean): TBox;

{$REGION 'Documentation'}
///	<summary>
///	  Returns a <see cref="OpenAPI.Types|TBox" /> with the coordinates of a given window (not its client area).
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<returns>
///	  The box with the window's coordinates.
///	</returns>
///	<remarks>
///	  The function will return a <see cref="OpenAPI.Types|TBox" /> with all 0 elements if the given window is invalid.
///	</remarks>
///	<seealso cref="GetWindowBoxEx" />
///	<seealso cref="SetWindowBox" />
///	<seealso cref="GetWindowSize" />
{$ENDREGION}
function GetWindowBox(const Wnd: HWND): TBox;

{$REGION 'Documentation'}
///	<summary>
///	  Returns the text of a given window.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<returns>
///	  The window's text, which is often/usually displayed in its titlebar.
///	</returns>
///	<remarks>
///	  The function will return an empty string if the given window is invalid.
///	</remarks>
///	<seealso cref="SetWindowText" />
///	<seealso cref="GetWindowClass" />
{$ENDREGION}
function GetWindowText(const Wnd: HWND): string;

{$REGION 'Documentation'}
///	<summary>
///	  Returns the class name of a given window.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<returns>
///	  The window's class name.
///	</returns>
///	<remarks>
///	  The function will return an empty string if the given window is invalid.
///	</remarks>
///	<seealso cref="GetWindowText" />
{$ENDREGION}
function GetWindowClass(const Wnd: HWND): string;

{$REGION 'Documentation'}
///	<summary>
///	  Changes the text of a given window.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<param name="Text">
///	  The new text which will be stored in (and possibly displayed by) the window.
///	</param>
///	<remarks>
///	  The function will fail silently if the given window is invalid.
///	</remarks>
///	<seealso cref="GetWindowText" />
{$ENDREGION}
procedure SetWindowText(const Wnd: HWND; const Text: string);

{$REGION 'Documentation'}
///	<summary>
///	  Returns the handle of the outer most window that contains a given window (and which is not the desktop).
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<returns>
///	  True the handle of the outer most window or 0 if none could be determined.
///	</returns>
///	<seealso cref="GetParentWindow" />
{$ENDREGION}
function GetOuterWindow(const Wnd: HWND): HWND;

{$REGION 'Documentation'}
///	<summary>
///	  Changes the opacity of a given window.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<param name="Level">
///	  The new opacity level with 0 being fully transparent and 255 being fully opaque.
///	</param>
///	<remarks>
///	  The function will fail silently if the given window is invalid.
///	</remarks>
///	<seealso cref="GetWindowTransp" />
{$ENDREGION}
procedure SetWindowTransp(const Wnd: HWND; const Level: Byte);

{$REGION 'Documentation'}
///	<summary>
///	  Returns the opacity of a given window.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<returns>
///	  The opacity level of the given window with 0 being fully transparent and 255 being fully opaque.
///	</returns>
///	<remarks>
///	  The function will return 0 if the given window is invalid.
///	</remarks>
///	<seealso cref="SetWindowTransp" />
{$ENDREGION}
function GetWindowTransp(const Wnd: HWND): Byte;

{$REGION 'Documentation'}
///	<summary>
///	  Changes a window to or from topmost state. Topmost means that it is not possible for other (regular) windows to be
///   placed on top of it.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<param name="TopMost">
///	  When true, the window will change to topmost state, when False the state is revoked.
///	</param>
///	<remarks>
///	  The function will fail silently if the given window is invalid.
///	</remarks>
///	<seealso cref="IsWindowTopMost" />
{$ENDREGION}
procedure SetWindowTopMost(const Wnd: HWND; const TopMost: Boolean);

{$REGION 'Documentation'}
///	<summary>
///	  Checks whether the given window is set to topmost. This does not mean that it is focused, but rather that it is
///   not possible for other (regular) windows to be placed on top of it.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<returns>
///	  True if the given window is set to topmost, otherwise False.
///	</returns>
///	<remarks>
///	  The function will return False if the given window is invalid.
///	</remarks>
///	<seealso cref="SetWindowTopMost" />
{$ENDREGION}
function IsWindowTopMost(const Wnd: HWND): Boolean;

{$REGION 'Documentation'}
///	<summary>
///	  Validates whether a given window is valid.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<returns>
///	  True if the given handle is valid, otherwise False.
///	</returns>
{$ENDREGION}
function IsWindowValid(const Wnd: HWND): Boolean;

{$REGION 'Documentation'}
///	<summary>
///	  Changes the position and dimensions of a window.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<param name="Box">
///	  The new coordinates of the window's upper-left and lower-right corners as a <see cref="OpenAPI.Types|TBox" />.
///	</param>
///	<remarks>
///	  The function will fail silently if the given window is invalid.
///	</remarks>
///	<seealso cref="GetWindowBox" />
///	<seealso cref="GetWindowBoxEx" />
{$ENDREGION}
procedure SetWindowBox(const Wnd: HWND; const Box: TBox);

{$REGION 'Documentation'}
///	<summary>
///	  Returns the dimensions of a window or its client area.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<param name="Width">
///	  Returns the width of the window.
///	</param>
///	<param name="Height">
///	  Returns the height the window.
///	</param>
///	<param name="ClientArea">
///	  The function will process the window's client area when this is set to True.
///	</param>
///	<remarks>
///	  The function will return 0 for Width and Height if the given window is invalid.
///	</remarks>
///	<seealso cref="GetWindowSize" />
///	<seealso cref="SetWindowSize" />
{$ENDREGION}
procedure GetWindowSizeEx(const Wnd: HWND; out Width, Height: Integer; const ClientArea: Boolean);

{$REGION 'Documentation'}
///	<summary>
///	  Returns the dimensions of a window (not its client area).
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<param name="Width">
///	  Returns the width of the window.
///	</param>
///	<param name="Height">
///	  Returns the height the window.
///	</param>
///	<remarks>
///	  The function will return 0 for Width and Height if the given window is invalid.
///	</remarks>
///	<seealso cref="GetWindowSizeEx" />
///	<seealso cref="SetWindowSize" />
{$ENDREGION}
procedure GetWindowSize(const Wnd: HWND; out Width, Height: Integer);

{$REGION 'Documentation'}
///	<summary>
///	  Changes the dimensions of a window.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<param name="Width">
///	  The new width for the window.
///	</param>
///	<param name="Height">
///	  The new height for the window.
///	</param>
///	<remarks>
///	  The function will fail silently if the given window is invalid.
///	</remarks>
///	<seealso cref="GetWindowSize" />
///	<seealso cref="GetWindowSizeEx" />
{$ENDREGION}
procedure SetWindowSize(const Wnd: HWND; const Width, Height: Integer);

{$REGION 'Documentation'}
///	<summary>
///	  Activates a given window by moving it to the foreground and giving it focus.
///	</summary>
///	<param name="Wnd">
///	  The handle to the window.
///	</param>
///	<remarks>
///	  The function will fail silently if the given window is invalid.
///	</remarks>
{$ENDREGION}
procedure ActivateWindow(const Wnd: HWND);

implementation

uses
  {$IFDEF EXPORTS}uPSComponent, uEngine_PascalScript,{$ENDIF}

  Vcl.Graphics, WinApi.Messages,

  PerlRegEx;

function User32_GetShellWindow: HWND; stdcall; external user32 name 'GetShellWindow';
function User32_GetLayeredWindowAttributes(HWND: HWND; out crKey: TColor; out bAlpha: Byte; out dwFlags: DWORD):
  BOOL; stdcall; external user32 name 'GetLayeredWindowAttributes';

function GetDesktopWindow: HWND;
begin
  Result := WinApi.Windows.GetDesktopWindow;
end;

function GetShellWindow: HWND;
begin
  Result := User32_GetShellWindow;
end;

function GetActiveWindow: HWND;
begin
  Result := GetForegroundWindow;
end;

function GetParentWindow(const Wnd: HWND): HWND;
begin
  if IsWindow(Wnd) then
    Result := GetAncestor(Wnd, GA_PARENT)
  else
    Result := 0;
end;

function GetWindowBoxEx(const Wnd: HWND; const ClientArea: Boolean): TBox;
var
  Point: TPoint;
  Rect: TRect;
begin
  if IsWindow(Wnd) then
  begin
    if ClientArea then
    begin
      ClientToScreen(Wnd, Point);
      GetClientRect(Wnd, Rect);
      Result := TBox.Create(Point.X, Point.Y, Point.X + Rect.Right - 1, Point.Y + Rect.Bottom - 1);
    end else begin
      GetWindowRect(Wnd, Rect);
      Result := TBox.Create(Rect);
    end;
  end else
    Result := TBox.Create(0, 0, 0, 0);
end;

function GetWindowBox(const Wnd: HWND): TBox;
begin
  Result := GetWindowBoxEx(Wnd, False);
end;

function GetWindowText(const Wnd: HWND): string;
var
  Len: Integer;
begin
  Result := '';
  if IsWindow(Wnd) then
  begin
    Len := GetWindowTextLength(Wnd) + 1;
    SetLength(Result, Len);
    SetLength(Result, WinApi.Windows.GetWindowText(Wnd, @Result[1], Len));
  end;
end;

function GetWindowClass(const Wnd: HWND): string;
begin
  Result := '';
  if IsWindow(Wnd) then
  begin
    SetLength(Result, 256);
    SetLength(Result, GetClassName(Wnd, @Result[1], 256));
  end;
end;

procedure SetWindowText(const Wnd: HWND; const Text: string);
begin
  if IsWindow(Wnd) then
    SetWindowText(Wnd, PChar(Text));
end;

function GetOuterWindow(const Wnd: HWND): HWND;
var
  DesktopWnd, TmpWnd, WndNew: HWND;
begin
  Result := 0;
  if IsWindow(Wnd) then
  begin
    DesktopWnd := GetDesktopWindow;
    TmpWnd := Wnd;
    while (TmpWnd <> DesktopWnd) and (TmpWnd <> 0) do
    begin
      WndNew := TmpWnd;
      TmpWnd := GetParent(WndNew);
    end;
    Result := WndNew;
  end;
end;

procedure SetWindowTransp(const Wnd: HWND; const Level: Byte);
var
  OuterWnd: HWND;
  Info: TOSVersionInfo;
begin
  if IsWindow(Wnd) then
  begin
    OuterWnd := GetOuterWindow(Wnd);
    if Level = 0 then
      SetWindowLong(OuterWnd, GWL_EXSTYLE, GetWindowLong(OuterWnd, GWL_EXSTYLE) and not WS_EX_LAYERED)
    else begin
      Info.dwOSVersionInfoSize := SizeOf(Info);
      GetVersionEx(Info);
      if (Info.dwPlatformId = VER_PLATFORM_WIN32_NT) and (Info.dwMajorVersion >= 5) then
      begin
        SetWindowLong(OuterWnd, GWL_EXSTYLE, GetWindowLong(OuterWnd, GWL_EXSTYLE) or WS_EX_LAYERED);
        SetLayeredWindowAttributes(OuterWnd, 0, Level, LWA_ALPHA);
      end;
    end;
    InvalidateRect(OuterWnd, nil, True);
    UpdateWindow(OuterWnd);
  end;
end;

function GetWindowTransp(const Wnd: HWND): Byte;
var
  OuterWnd: HWND;
  Long: Integer;
  TranspCol: TColor;
  Alpha: Byte;
  Flags: DWORD;
begin
  Result := 0;
  if IsWindow(Wnd) then
  begin
    OuterWnd := GetOuterWindow(Wnd);
    Long := GetWindowLong(OuterWnd, GWL_EXSTYLE);
    if Long and WS_EX_LAYERED <> 0 then
    begin
      User32_GetLayeredWindowAttributes(OuterWnd, TranspCol, Alpha, Flags);
      if Flags and LWA_ALPHA <> 0 then
        Result := Alpha;
    end;
  end;
end;

procedure SetWindowTopMost(const Wnd: HWND; const TopMost: Boolean);
begin
  if IsWindow(Wnd) then
    if TopMost then
      SetWindowPos(Wnd, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE)
    else
      SetWindowPos(Wnd, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
end;

function IsWindowTopMost(const Wnd: HWND): Boolean;
var
  OuterWnd: HWND;
begin
  if IsWindow(Wnd) then
  begin
    OuterWnd := GetOuterWindow(Wnd);
    Result := GetWindowLong(OuterWnd, GWL_EXSTYLE) and WS_EX_TOPMOST <> 0;
  end else
    Result := False;
end;

function IsWindowValid(const Wnd: HWND): Boolean;
begin
  Result := IsWindow(Wnd);
end;

procedure SetWindowBox(const Wnd: HWND; const Box: TBox);
begin
  if IsWindow(Wnd) then
    MoveWindow(Wnd, Box.X1, Box.Y1, Box.Width, Box.Height, True);
end;

procedure GetWindowSizeEx(const Wnd: HWND; out Width, Height: Integer; const ClientArea: Boolean);
var
  Rect: TRect;
begin
  if IsWindow(Wnd) then
  begin
    if ClientArea then
      GetClientRect(Wnd, Rect)
    else
      GetWindowRect(Wnd, Rect);
    Width := Rect.Width;
    Height := Rect.Height;
  end else begin
    Width := 0;
    Height := 0;
  end;
end;

procedure GetWindowSize(const Wnd: HWND; out Width, Height: Integer);
begin
  GetWindowSizeEx(Wnd, Width, Height, False);
end;

procedure SetWindowSize(const Wnd: HWND; const Width, Height: Integer);
var
  Rect: TRect;
begin
  if IsWindow(Wnd) then
  begin
    GetWindowRect(Wnd, Rect);
    MoveWindow(Wnd, Rect.Left, Rect.Top, Width, Height, True);
  end;
end;

procedure ActivateWindow(const Wnd: HWND);
begin
  if IsWindow(Wnd) then
  begin
    SendMessage(Wnd, WM_SYSCOMMAND, SC_HOTKEY, Wnd);
    SetForegroundWindow(Wnd);
  end;
end;

initialization
  // Functions documented at wiki.scar-divi.com are marked with an empty comment
{$IFDEF EXPORTS}
  TExportMngr_PS.Instance['Functions'].Add(procedure(const Engine: TPSScript)
  begin
    Engine.AddFunction(@GetDesktopWindow, 'function GetDesktopWindow: HWND;'); //
    Engine.AddFunction(@GetShellWindow, 'function GetShellWindow: HWND;'); //
    Engine.AddFunction(@GetActiveWindow, 'function GetActiveWindow: HWND;'); //
    Engine.AddFunction(@GetParentWindow, 'function GetParentWindow(const Wnd: HWND): HWND;'); //
    Engine.AddFunction(@GetWindowBoxEx, 'function GetWindowBoxEx(const Wnd: HWND; const ClientArea: Boolean): TBox;'); //
    Engine.AddFunction(@GetWindowBox, 'function GetWindowBox(const Wnd: HWND): TBox;'); //
    Engine.AddFunction(@GetWindowText, 'function GetWindowText(const Wnd: HWND): string;'); //
    Engine.AddFunction(@GetWindowClass, 'function GetWindowClass(const Wnd: HWND): string;'); //
    Engine.AddFunction(@SetWindowText, 'procedure SetWindowText(const Wnd: HWND; const Text: string);'); //
    Engine.AddFunction(@GetOuterWindow, 'function GetOuterWindow(const Wnd: HWND): HWND;'); //
    Engine.AddFunction(@GetWindowTransp, 'function GetWindowTransp(const Wnd: HWND): Byte;');
    Engine.AddFunction(@SetWindowTransp, 'procedure SetWindowTransp(const Wnd: HWND; const Level: Byte);');
    Engine.AddFunction(@SetWindowTopMost, 'procedure SetWindowTopMost(const Wnd: HWND; const TopMost: Boolean);'); //
    Engine.AddFunction(@IsWindowTopMost, 'function IsWindowTopMost(const Wnd: HWND): Boolean;'); //
    Engine.AddFunction(@IsWindowValid, 'function IsWindowValid(const Wnd: HWND): Boolean;'); //
    Engine.AddFunction(@SetWindowBox, 'procedure SetWindowBox(const Wnd: HWND; const Box: TBox);'); //
    Engine.AddFunction(@GetWindowSizeEx, 'procedure GetWindowSizeEx(const Wnd: HWND; out Width, Height: Integer; const ClientArea: Boolean);'); //
    Engine.AddFunction(@GetWindowSize, 'procedure GetWindowSize(const Wnd: HWND; out Width, Height: Integer);'); //
    Engine.AddFunction(@SetWindowSize, 'procedure SetWindowSize(const Wnd: HWND; const Width, Height: Integer);'); //
    Engine.AddFunction(@ActivateWindow, 'procedure ActivateWindow(const Wnd: HWND);'); //
  end);
{$ENDIF}
end.
