{$REGION 'Documentation'}
///	<summary>
///	  This namespace contains all filesystem related functions.
///	</summary>
{$ENDREGION}
unit OpenAPI.FileSystem;

interface

{$IFDEF EXPORTS}
uses
  uPSComponent, uEngine_PascalScript;
{$ENDIF}

type
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  The base class for various file formats.
  ///	</summary>
  {$ENDREGION}
  TFile = class abstract

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Loads a file into the object.
    ///	</summary>
    ///	<param name="Path">
    ///	  The path to load the file from.
    ///	</param>
    ///	<returns>
    ///	  True if the file was loaded successfully.
    ///	</returns>
    {$ENDREGION}
    function LoadFromFile(const Path: string): Boolean; virtual;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Saves the data in the object to a file.
    ///	</summary>
    ///	<param name="Path">
    ///	  The path to save the file to.
    ///	</param>
    ///	<returns>
    ///	  True if the file was saved successfully.
    ///	</returns>
    {$ENDREGION}
    function SaveToFile(const Path: string): Boolean; virtual; abstract;
  end;

{$REGION 'Documentation'}
///	<summary>
///	  Verifies the validity of a filesystem path.
///	</summary>
///	<param name="Path">
///	  The path to validate.
///	</param>
///	<returns>
///	  True if the given path is valid.
///	</returns>
{$ENDREGION}
function IsValidPath(const Path: string): Boolean;

{$REGION 'Documentation'}
///	<summary>
///	  Determines the age of a file.
///	</summary>
///	<param name="Path">
///	  The path to the file to determine the age of.
///	</param>
///	<returns>
///	  The date and time at which the file was last modified. -1 is returned if the function fails.
///	</returns>
{$ENDREGION}
function FileAge(const Path: string): TDateTime;

{$REGION 'Documentation'}
///	<summary>
///	  Deletes a file from the filesystem.
///	</summary>
///	<param name="Path">
///	  The path to the file which will be deleted.
///	</param>
///	<returns>
///	  True if the file was deleted successfully.
///	</returns>
{$ENDREGION}
function DeleteFile(const Path: string): Boolean;

{$REGION 'Documentation'}
///	<summary>
///	  Moves a file from one location to another.
///	</summary>
///	<param name="OldPath">
///	  The current location of the file.
///	</param>
///	<param name="NewPath">
///	  The new location to which the file will be moved.
///	</param>
///	<returns>
///	  True if the file was moved successfully.
///	</returns>
{$ENDREGION}
function MoveFile(const OldPath, NewPath: string): Boolean;

{$REGION 'Documentation'}
///	<summary>
///	  Copies a file from one location to another.
///	</summary>
///	<param name="OldPath">
///	  The current location of the file.
///	</param>
///	<param name="NewPath">
///	  The new location to which the file will be copied.
///	</param>
///	<returns>
///	  True if the file was copied successfully.
///	</returns>
{$ENDREGION}
function CopyFile(const OldPath, NewPath: string): Boolean;

implementation

uses
  System.SysUtils, System.IOUtils, WinApi.Windows;

{ TFile }

function TFile.LoadFromFile(const Path: string): Boolean;
begin
  Result := FileExists(Path);
end;

function IsValidPath(const Path: string): Boolean;
begin
  Result := TPath.HasValidPathChars(Path, False);
end;

function FileAge(const Path: string): TDateTime;
var
  Time: Integer;
begin
  Result := -1;
  if IsValidPath(Path) and FileExists(Path) then
  begin
    Time := System.SysUtils.FileAge(Path);
    if Time > -1 then
      Result := FileDateToDateTime(Time);
  end;
end;

function DeleteFile(const Path: string): Boolean;
begin
  Result := IsValidPath(Path) and FileExists(Path) and DeleteFile(PChar(Path));
end;

function MoveFile(const OldPath, NewPath: string): Boolean;
begin
  Result := False;
  if IsValidPath(OldPath) and FileExists(OldPath) then
  begin
    ForceDirectories(ExtractFilePath(NewPath));
    Result := WinApi.Windows.MoveFile(PChar(OldPath), PChar(NewPath));
  end;
end;

function CopyFile(const OldPath, NewPath: string): Boolean;
begin
  Result := False;
  if IsValidPath(OldPath) and FileExists(OldPath) then
  begin
    ForceDirectories(ExtractFilePath(NewPath));
    Result := WinApi.Windows.CopyFile(PChar(OldPath), PChar(NewPath), False);
  end;
end;

initialization
  // Functions documented at wiki.scar-divi.com are marked with an empty comment
{$IFDEF EXPORTS}
  TExportMngr_PS.Instance['Functions'].Add(procedure(const Engine: TPSScript)
  begin
    Engine.AddFunction(@IsValidPath, 'function IsValidPath(const Path: string): Boolean;');
    Engine.AddFunction(@DeleteFile, 'function DeleteFile(const Path: string): Boolean;'); //
    Engine.AddFunction(@FileAge, 'function FileAge(const Path: string): TDateTime;'); //
    Engine.AddFunction(@MoveFile, 'function MoveFile(const OldPath, NewPath: string): Boolean;');
    Engine.AddFunction(@CopyFile, 'function CopyFile(const OldPath, NewPath: string): Boolean;');
  end);
{$ENDIF}
end.
