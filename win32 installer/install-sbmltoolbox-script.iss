;  Filename    : install_libsbml_script.iss
;  Description : file to create windows installation of sbmltoolbox
;  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
;  Organization: University of Hertfordshire STRC
;  Created     : 2004-03-15
;  Revision    : $Id$
;  Source      : $Source$
;
;  Copyright 2003 California Institute of Technology, the Japan Science
;  and Technology Corporation, and the University of Hertfordshire
;
;  This library is free software; you can redistribute it and/or modify it
;  under the terms of the GNU Lesser General Public License as published
;  by the Free Software Foundation; either version 2.1 of the License, or
;  any later version.
;
;  This library is distributed in the hope that it will be useful, but
;  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
;  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
;  documentation provided hereunder is on an "as is" basis, and the
;  California Institute of Technology, the Japan Science and Technology
;  Corporation, and the University of Hertfordshire have no obligations to
;  provide maintenance, support, updates, enhancements or modifications.  In
;  no event shall the California Institute of Technology, the Japan Science
;  and Technology Corporation or the University of Hertfordshire be liable
;  to any party for direct, indirect, special, incidental or consequential
;  damages, including lost profits, arising out of the use of this software
;  and its documentation, even if the California Institute of Technology
;  and/or Japan Science and Technology Corporation and/or University of
;  Hertfordshire have been advised of the possibility of such damage.  See
;  the GNU Lesser General Public License for more details.
;
;  You should have received a copy of the GNU Lesser General Public License
;  along with this library; if not, write to the Free Software Foundation,
;  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
;
;  The original code contained here was initially developed by:
;
;      Sarah Keating
;      Science and Technology Research Centre
;      University of Hertfordshire
;      Hatfield, AL10 9AB
;      United Kingdom
;
;      http://www.sbml.org
;      mailto:sbml-team@caltech.edu
;
;  Contributor(s):

[Setup]
AppName=SBMLToolbox
AppVerName=SBMLToolbox 2.0.2
AppPublisher=SBMLTeam
AppPublisherURL=http://www.sbml.org
AppSupportURL=http://www.sbml.org
AppUpdatesURL=http://www.sbml.org


DefaultDirName={pf}\SBML\SBMLToolbox-2.0.2
DefaultGroupName=SBMLToolbox
DisableProgramGroupPage=yes
WizardSmallImageFile=sbmltoolbox-installer-mini-logo.bmp
WizardImageFile=sbmltoolbox-installer-graphic.bmp
UsePreviousAppDir=no


[Files]
Source: "C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox\*"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox\toolbox\*"; DestDir: "{app}\toolbox"; Flags: ignoreversion recursesubdirs
Source: "C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox\docs\*"; DestDir: "{app}\docs"; Flags: ignoreversion recursesubdirs
Source: "C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox\extern\*"; DestDir: "{app}\extern"; Flags: ignoreversion recursesubdirs
Source: "C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox\extern\bin\*"; DestDir: "{sys}"; Check: GetSys;
Source: "C:\SBMLToolbox_cvs\win32_installer\SBMLToolbox\extern\bin\*"; DestDir: "{code:GetLibDir}"; Flags: ignoreversion; Check: GetOverwrite;
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Registry]
Root: HKCU; Subkey: "Software\SBML"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\SBML\SBMLToolbox"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\SBML"; Flags: uninsdeletekeyifempty
Root: HKLM; Subkey: "Software\SBML\SBMLToolbox"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\SBML\SBMLToolbox"; ValueType: string; ValueName: "Version"; ValueData: "2.0.2"
Root: HKLM; Subkey: "Software\SBML\SBMLToolbox"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"

[Code]
{global variables}
var
  MatlabExists : Boolean;
  ToolboxExists, LibsbmlNotFound : Boolean;
  LibsbmlPath, BindingExists: Boolean;
  LibsbmlVersion, LibsbmlPathDir, ToolboxVersion, ToolboxPath: String;
  LaterLibsbmlVers, LaterToolboxVers : Integer;
  LibsbmlOverwrite, BindingDelete, LibsbmlSystem : String;


{functions to activate buttons and url on screen}
procedure AboutButtonOnClick(Sender: TObject);
begin

{*********************************************************************************************************
 The text for this message box is what the user will see if they click the About button during installation

 Feel free to alter it to taste but beware it must all be on one line.

  Note: it includes a version number
**********************************************************************************************************}
  MsgBox('This setup installs the Windows release of SBMLToolbox 2.0.2 using libSBML 2.3.4. All the necessary libraries are included.', mbInformation, mb_Ok);
end;

procedure URLLabelOnClick(Sender: TObject);
var
  Dummy: Integer;
begin
  InstShellExec('http://www.sbml.org', '', '', SW_SHOWNORMAL, Dummy);
end;


{function to initialise the wizard form
i.e. add an about button and the url to all sheets}
procedure InitializeWizard();
var
  AboutButton, CancelButton: TButton;
  URLLabel: TNewStaticText;
begin
 CancelButton := WizardForm.CancelButton;


  AboutButton := TButton.Create(WizardForm);
  AboutButton.Left := WizardForm.ClientWidth - CancelButton.Left - CancelButton.Width;
  AboutButton.Top := CancelButton.Top;
  AboutButton.Width := CancelButton.Width;
  AboutButton.Height := CancelButton.Height;
  AboutButton.Caption := '&About...';
  AboutButton.OnClick := @AboutButtonOnClick;
  AboutButton.Parent := WizardForm;

  URLLabel := TNewStaticText.Create(WizardForm);
  URLLabel.Top := AboutButton.Top + AboutButton.Height - URLLabel.Height - 2;
  URLLabel.Left := AboutButton.Left + AboutButton.Width + 20;
  URLLabel.Caption := 'www.sbml.org';
  URLLabel.Font.Style := URLLabel.Font.Style + [fsUnderLine];
  URLLabel.Font.Color := clBlue;
  URLLabel.Cursor := crHand;
  URLLabel.OnClick := @URLLabelOnClick;
  URLLabel.Parent := WizardForm;

 end;

{function to return matlab root directory}
function GetMatlabRoot(S : String): String;
var
  Names: TArrayOfString;
  Root:String;
  Number: Longint;
  Key: String;

begin
  RegGetSubKeyNames(HKLM, 'Software\Mathworks\MATLAB', Names);

  Number := GetArrayLength(Names);
  if Number = 0 then
    Root := ''
  else begin
    Key := '';
    Key := Key + 'Software\Mathworks\MATLAB\';
    Key := Key + Names[Number-1];
    RegQueryStringValue(HKLM, Key, 'MATLABROOT', Root);
  end;

  Result := Root;
end;

function GetLibsbmlVersion(): String;
var
  Vers:String;
  Key: String;

begin

  Key := '';
  Key := Key + 'Software\SBML\libsbml\';
  RegQueryStringValue(HKLM, Key, 'Version', Vers);

  Result := Vers;
end;

{function to return version number stored in registry}
function GetToolboxVersion(): String;
var
  Vers:String;
  Key: String;

begin

  Key := '';
  Key := Key + 'Software\SBML\SBMLToolbox\';
  RegQueryStringValue(HKLM, Key, 'Version', Vers);

  Result := Vers;
end;

{function to check whether a version of toolbox already exists}
function DoesToolboxExist(): Boolean;
var
     VersionNo: String;
     Exists: Boolean;
begin
     VersionNo := GetToolboxVersion();
     
     if (VersionNo = '') then
      Exists := False
      else
      Exists := True;

      
      Result := Exists;

end;

{function to check whether a preinstalled version number is later than the
  current installation
  returns 1 is the version installed is later than this version
          0 if the version installed equals this version
          -1 if the version installed is earlier than this version}
function LaterVersion(VersionNo, CurrentVers : String) : Integer;
var
  First, Second, Third: Longint;
  CurrentFirst, CurrentSecond, CurrentThird: Longint;
  Later : Integer;
begin
  if (VersionNo = '') then begin
    First := 0;
    Second := 0;
    Third := 0;
  end else begin
    First := StrToInt(StrGet(VersionNo, 1));
    Second := StrToInt(StrGet(VersionNo, 3));
    Third := StrToInt(StrGet(VersionNo, 5));
  end;
  CurrentFirst := StrToInt(StrGet(CurrentVers, 1));
  CurrentSecond := StrToInt(StrGet(CurrentVers, 3));
  CurrentThird := StrToInt(StrGet(CurrentVers, 5));

  if (First > CurrentFirst) then  begin
    Later := 1;
  end else if ((First = CurrentFirst) and (Second > CurrentSecond)) then begin
    Later := 1;
  end else if ((First = CurrentFirst) and (Second = CurrentSecond) and (Third > CurrentThird)) then begin
    Later := 1;
  end else if ((First = CurrentFirst) and (Second = CurrentSecond) and (Third = CurrentThird)) then begin
    Later := 0;
  end else begin
    Later := -1;
  end;

  {check for a beta version}
  if (Later = 0) then begin
    if (Length(CurrentVers) = 6) then begin
      if (Length(VersionNo) < 6) then begin
        Later := 1;
      end else begin
        Later := 0;
      end;
    end;
  end;
  Result:= Later;

end;


function InitializeSetup(): Boolean;
var
  MLRoot : String;
  Temp, Temp1: String;
  TempBool : Boolean;
  
begin
  { set flags}
  
  LibsbmlOverwrite := '0';
  BindingDelete := '0';
  LibsbmlSystem := '0';
  
  {look for matlab on the system}
  MLRoot := GetMatlabRoot('');
  if (MLRoot = '') then
    MatlabExists := False
  else
    MatlabExists := True;

  {look for libsbml in environmental PATH }
  Temp := GetEnv('PATH');
  Temp1 := FileSearch('libsbml.lib', Temp);
  
  if not (Temp1 = '') then begin
    LibsbmlPath := True;
    LibsbmlPathDir := RemoveBackslash(ExtractFilePath(Temp1));
  end else begin
    LibsbmlPath := False;
    LibsbmlPathDir := '';
  end;

  {look for a version no and check whether it is later than this}
  LibsbmlVersion := GetLibsbmlVersion();
  LaterLibsbmlVers := LaterVersion(LibsbmlVersion, '2.3.4');

  if ((LibsbmlVersion = '') and (not LibsbmlPath))  then
    LibsbmlNotFound := True;
    
  {look for SBMLbinding in matlab toolbox directory
   this is where it will be if installed using the
   libsbml installation package}
  Temp := Format1('%s\SBMLBinding', MLRoot);

  TempBool := DirExists(Temp);

  if (TempBool) then
    BindingExists := True
 else
    BindingExists := False;

  
  {look for prvious version of SBMLToolbox}
  ToolboxExists := DoesToolboxExist();

    {look for a version no and check whether it is later than this}
  ToolboxVersion := GetToolboxVersion();
  LaterToolboxVers := LaterVersion(ToolboxVersion, '2.0.2');

  if not MatlabExists then begin
    Result := MsgBox('MATLAB cannot be located on this system.' #13 'The SBMLToolbox requires MATLAB.' #13#13 'Do you want to continue?', mbConfirmation, MB_YESNO) = idYes;
  end else begin
    { Let Setup run }
    Result := True;
  end;
end;


function ScriptDlgPages(CurPage: Integer; BackClicked: Boolean): Boolean;
var

  Next: Boolean;

begin
  if ((not BackClicked and (CurPage = wpWelcome)) or (BackClicked and (CurPage = wpSelectDir))) then begin

    { insert a page after the welcome page that only displays
      if the toolbox or the binding already exist}
   if ToolboxExists then begin

      ScriptDlgPageOpen();

      { Set some captions  }
      ScriptDlgPageSetCaption('Previously installed versions');
      ScriptDlgPageSetSubCaption1('');

      if (ToolboxVersion = '') then begin
        Next := OutputMsg('An unidentified version of SBMLToolbox has been found'#13#13'Press Next to continue with the installation or Cancel to exit', True);
      end else if (LaterToolboxVers = 0) then begin
        Next := OutputMsg('This version of SBMLToolbox has already been installed on the system'#13#13'Press Next to continue with the installation or Cancel to exit', True);
      end else if (LaterToolboxVers = 1) then begin
        Next := OutputMsg('A later version of SBMLToolbox has already been installed on the system'#13#13'Press Next to continue with the installation or Cancel to exit', True);
      end else begin
        Next := OutputMsg('An earlier version of SBMLToolbox has already been installed on the system. Files may be overwritten.'#13#13'Press Next to continue with the installation or Cancel to exit', True);
      end;
      


    {toolbox doesnt exist
     check for binding}
    end else if BindingExists then begin

      ScriptDlgPageOpen();

      { Set some captions  }
      ScriptDlgPageSetCaption('Previously installed versions');
      ScriptDlgPageSetSubCaption1('');

      ScriptDlgPageSetSubCaption2('The libsbml matlab binding functions have been found'#13'These will create conflict with the SBMLToolbox function and should be deleted');

      Next := InputOption('Delete the libsbml matlab binding functions' , BindingDelete);

    end else begin

      if not BackClicked then
        Next := True
      else
        Next := False;

    end;

    if not BackClicked then
      Result := Next
    else
      Result := not Next;

    { Close the wizard page. Do a FullRestore only if the click (see above) is not allowed }
    ScriptDlgPageClose(not Result);


  end else if ((not BackClicked and (CurPage = wpSelectDir)) or (BackClicked and (CurPage = wpReady))) then begin

    if (LibsbmlVersion = '') then begin
        ScriptDlgPageOpen();

        ScriptDlgPageSetCaption('libsbml library files');
        ScriptDlgPageSetSubCaption1('SBMLToolbox 2.0.2 uses libsbml 2.3.4');
        ScriptDlgPageClearCustom();

        if LibsbmlPath then begin

          ScriptDlgPageSetSubCaption2('An unidentified version of libsbml has already been installed on the system');

          Next := InputOption('Overwrite libsbml libraries in ''' + LibsbmlPathDir + '''' , LibsbmlOverwrite);

        end else begin

          ScriptDlgPageSetSubCaption2('SBMLToolbox requires the libsbml library files to be on the PATH'#13#13'Setup can copy these to the system directory ''' + GetSystemDir()+ ''''#13'Or you can use install.m within the SBMLToolbox');

          Next := InputOption('Write libsbml libraries to ''' + GetSystemDir() + '''' , LibsbmlSystem);

        end;

    end else if ((not LaterLibsbmlVers = 0) or (not LibsbmlPath)) then begin
      ScriptDlgPageOpen();

      ScriptDlgPageSetCaption('libsbml library files');
      ScriptDlgPageSetSubCaption1('SBMLToolbox uses libsbml 2.3.4');
      ScriptDlgPageClearCustom();
      if LibsbmlPath then begin

        if (LaterLibsbmlVers = 1) then begin
          ScriptDlgPageSetSubCaption2('A later version of libsbml has already been installed on the system');
        end else begin
          ScriptDlgPageSetSubCaption2('An earlier version of libsbml has already been installed on the system');
        end;

        Next := InputOption('Overwrite libsbml libraries in ''' + LibsbmlPathDir + '''' , LibsbmlOverwrite);

      end else begin

        ScriptDlgPageSetSubCaption2('SBMLToolbox requires the libsbml library files to be on the PATH'#13#13'Setup can copy these to the system directory ''' + GetSystemDir()+ ''''#13'Or you can use install.m within the SBMLToolbox');

        Next := InputOption('Write libsbml libraries to ''' + GetSystemDir() + '''' , LibsbmlSystem);

      end;

    end else begin
        if not BackClicked then
          Next := True
        else
          Next := False;
    end;

    if not BackClicked then
      Result := Next
    else
      Result := not Next;

    { Close the wizard page. Do a FullRestore only if the click (see above) is not allowed }

    ScriptDlgPageClose(not Result);

  end else begin

    Result := True;

  end;

end;

function NextButtonClick(CurPage: Integer): Boolean;
var
  Deleted : Boolean;
  DirName : String;
begin
  case CurPage of
    wpSelectDir:
    if ToolboxExists and (WizardDirValue = ToolboxPath) then begin
      MsgBox('Setup will overwrite files in ''' + WizardDirValue + '''.', mbInformation, MB_OK);
    end;
    wpReady:
    if (BindingDelete = '1') then begin
      DirName := GetMatlabroot('') + '\SBMLbinding';
      Deleted := DelTree(DirName, True, True, True);
      if not Deleted then begin
        MsgBox('Setup could not delete directory ''' + DirName + '''.', mbInformation, MB_OK);
      end;
    
    end;

 end;

  Result := ScriptDlgPages(CurPage, False);
end;

function BackButtonClick(CurPage: Integer): Boolean;
begin
  Result := ScriptDlgPages(CurPage, True);
end;

function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
  S: String;
begin
  { Fill the 'Ready Memo' with the normal settings and the custom settings }
  S := '';
  S := S + MemoDirInfo + NewLine;
  S := S + NewLine;


  if ((not LibsbmlNotFound) and LibsbmlPath) then begin
     if (LibsbmlOverwrite = '1') then begin
        S := S + 'Overwriting libsbml library files to' + NewLine;
        S := S + '      ' + LibsbmlPathDir;
        S := S + NewLine;
      end else begin
        S := S + 'Not overwriting libsbml library files' + NewLine;
        S := S + NewLine;
      end;
  end else begin
      if (LibsbmlSystem = '1') then begin
        S := S + 'Writing libsbml library files to system directory' + NewLine;
        S := S + '      ' + GetSystemDir();
        S := S + NewLine;
      end else begin
        S := S + 'Not writing libsbml library files to system directory' + NewLine;
        S := S + 'You will need to run install.m to use the SBMLToolbox';
        S := S + NewLine;
      end;
  end;

  S := S + NewLine;

  if BindingExists then begin
    if (BindingDelete = '1') then begin
      S := S + 'Deleting libsbml matlab binding files from' + NewLine;
      S := S + '      ' + GetMatlabroot('') + '\SBMLbinding';
      S := S + NewLine;
    end else begin
      S := S + 'Not deleting libsbml matlab binding files' + NewLine;
      S := S + NewLine;
    end;
  end;

  Result := S;
end;

{ function to return flag as to whether to write libraries to system directory}
function GetSys() : Boolean;
begin
  if LibsbmlSystem = '1' then
    Result := True
  else
    Result := False;
end;
{ function to return flag as to whether to write libraries to system directory}
function GetOverwrite() : Boolean;
begin
  if LibsbmlOverwrite = '1' then
    Result := True
  else
    Result := False;
end;

function GetLibDir(S : String) : String;
begin
  Result := LibsbmlPathDir;
end;

