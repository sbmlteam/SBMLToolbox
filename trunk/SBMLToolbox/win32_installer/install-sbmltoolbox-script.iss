
[Setup]
AppName=SBMLToolbox
AppVerName=SBMLToolbox 3.1.2
AppPublisher=SBMLTeam
AppPublisherURL=http://www.sbml.org
AppSupportURL=http://www.sbml.org
AppUpdatesURL=http://www.sbml.org


DefaultDirName={pf}\SBML\SBMLToolbox-3.1.2
DefaultGroupName=SBMLToolbox
DisableProgramGroupPage=yes
OutputDir=..\win32_installer\Output
OutputBaseFilename=SBMLToolbox-3.1.2-setup-win32
WizardSmallImageFile=sbmltoolbox-installer-mini-logo.bmp
WizardImageFile=sbmltoolbox-installer-graphic.bmp
UsePreviousAppDir=no


[Files]
Source: "C:\SBMLToolbox\win32_installer\SBMLToolbox\*"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\SBMLToolbox\win32_installer\SBMLToolbox\toolbox\*"; DestDir: "{app}\toolbox"; Flags: ignoreversion recursesubdirs
Source: "C:\SBMLToolbox\win32_installer\SBMLToolbox\docs\*"; DestDir: "{app}\docs"; Flags: ignoreversion recursesubdirs
Source: "C:\rel-4-0-0\win32\installer\Output\libsbml-4.0.1-win-libxml2-vc80.exe"; DestDir: "{app}\temp"; Flags: ignoreversion; Check: GetLibSBML;
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Registry]
Root: HKCU; Subkey: Software\SBML; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: Software\SBML\SBMLToolbox; Flags: uninsdeletekey
Root: HKLM; Subkey: Software\SBML; Flags: uninsdeletekeyifempty
Root: HKLM; Subkey: Software\SBML\SBMLToolbox; Flags: uninsdeletekey
Root: HKLM; Subkey: Software\SBML\SBMLToolbox; ValueType: string; ValueName: Version; ValueData: 3.1.2
Root: HKLM; Subkey: Software\SBML\SBMLToolbox; ValueType: string; ValueName: InstallPath; ValueData: {app}

[Code]
{global variables}
var
  MatlabExists : Boolean;
  MLRoot : String;
  URLLabel: TNewStaticText;
  AboutButton, CancelButton: TButton;
  libsbmlPage: TInputOptionWizardPage;
  ToolboxExists, LibsbmlNotFound : Boolean;
  LibsbmlVersion, ToolboxVersion: String;
  LaterLibsbmlVers, LaterToolboxVers : Integer;


{functions to activate buttons and url on screen}
procedure AboutButtonOnClick(Sender: TObject);
begin

{*********************************************************************************************************
 The text for this message box is what the user will see if they click the About button during installation

 Feel free to alter it to taste but beware it must all be on one line.

  Note: it includes a version number
**********************************************************************************************************}
  MsgBox('This setup installs the Windows release of SBMLToolbox 3.1.2. This requires libSBML 4.0.1. This installer will allow you to install libSBML if it is not already present.', mbInformation, mb_Ok);
end;

procedure URLLabelOnClick(Sender: TObject);
var
  Dummy: Integer;
begin
  ShellExec('open', 'http://www.sbml.org', '', '', SW_SHOW, ewNoWait, Dummy);
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
begin
  { set flags}

  {look for matlab on the system}
  MLRoot := GetMatlabRoot('');
  if (MLRoot = '') then
    MatlabExists := False
  else
    MatlabExists := True;

  {look for a version no and check whether it is later than this}
  LibsbmlVersion := GetLibsbmlVersion();
  LaterLibsbmlVers := LaterVersion(LibsbmlVersion, '4.0.1');

  if LibsbmlVersion = '' then
    LibsbmlNotFound := True
  else
    LibsbmlNotFound := False;


  {look for previous version of SBMLToolbox}
  ToolboxExists := DoesToolboxExist();

  {look for a version no and check whether it is later than this}
  ToolboxVersion := GetToolboxVersion();
  LaterToolboxVers := LaterVersion(ToolboxVersion, '3.1.2');

  if not MatlabExists then begin
    Result := MsgBox('MATLAB cannot be located on this system.' #13 'The SBMLToolbox requires MATLAB.' #13#13 'Do you want to continue?', mbConfirmation, MB_YESNO) = idYes;
  end else begin
    Result := True;
  end;
end;

procedure InitializeWizard;
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

  {libsbml :  install }
  libsbmlPage := CreateInputOptionPage(wpSelectDir,
    'SBMLToolbox requires libsbml-4.0.1', '', '', True, False);
  libsbmlPage.Add('Install libSBML-4.0.1');
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  { Skip pages that shouldn't be shown }
  if PageID = libsbmlPage.ID then begin
    if LibsbmlNotFound then
       Result := False
    else if LaterLibsbmlVers < 0 then
      Result := False
    else
      Result := True;

  end else begin
    Result := False;
  end;
end;

function NextButtonClick(CurPageID: Integer): Boolean;

begin
  { Validate certain pages before allowing the user to proceed }
  if CurPageID = wpWelcome then begin
    if (ToolboxExists) then begin
      if (LaterToolboxVers = 0) then begin
        MsgBox('This version of SBMLToolbox has already been installed on the system', mbInformation, mb_Ok);
      end else if (LaterToolboxVers = 1) then begin
        MsgBox('A later version of SBMLToolbox has already been installed on the system', mbInformation, mb_Ok);
      end else begin
        MsgBox('An earlier version of SBMLToolbox has already been installed on the system. Files may be overwritten.', mbInformation, mb_Ok);
      end;
    end;
    Result := True;
  end else begin
    Result := True;
  end;
end;

function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
  S: String;
begin
  { Fill the 'Ready Memo' with the normal settings and the custom settings }
  S := '';
  S := S + MemoDirInfo + NewLine;
  S := S + NewLine;



  Result := S;
end;


{ function to return flag as to whether to install libsbml}
function GetLibSBML() : Boolean;
begin
  Result := libSBMLPage.Values[0]
end;

[Run]

Filename: "{app}\temp\libSBML-4.0.1-win-libxml2-vc80.exe"; flags: nowait; Check: GetLibSBML;

