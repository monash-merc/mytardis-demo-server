;MyTardis InnoSetup script
;Change OutputDir to suit your build environment

#define MyTardisAppName "MyTardis Demo Server"
#define MyTardisRunServer "MyTardisDemoServer.bat"
#define MyTardisCommandPrompt "MyTardisCommandPrompt.bat"
#define MyTardisVersion "d82f585c35c187cac0110adc13d29ff1a963dab2"

[Setup]
AppName={#MyTardisAppName}
AppVersion={#MyTardisVersion}
DefaultDirName={sd}\MyTardisDemoServer
DefaultGroupName={#MyTardisAppName}
UninstallDisplayIcon={app}\{#MyTardisRunServer}
Compression=lzma2
SolidCompression=yes
OutputDir=.

[Types]
Name: "full"; Description: "Full installation"
Name: "compact"; Description: "Compact installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "mytardis"; Description: "MyTardis"; Types: full compact custom; Flags: fixed
Name: "docs"; Description: "Documentation"; Types: full
Name: "git"; Description: "Git history"; Types: full

[Files]
Source: "*"; Excludes: "*.pyc,.git,docs,user_guide,setup.exe,MyTardisDemoServer*.exe"; DestDir: "{app}"; Flags: recursesubdirs ignoreversion; Components: mytardis

Source: "{#MyTardisVersion}\docs\*"; DestDir: "{app}\{#MyTardisVersion}\docs"; Flags: recursesubdirs ignoreversion; Components: docs
Source: "{#MyTardisVersion}\tardis\tardis_portal\static\user_guide\*"; DestDir: "{app}\{#MyTardisVersion}\tardis\tardis_portal\static\user_guide"; Flags: recursesubdirs ignoreversion; Components: docs
Source: "{#MyTardisVersion}\static\user_guide\*"; DestDir: "{app}\{#MyTardisVersion}\static\user_guide"; Flags: recursesubdirs ignoreversion; Components: docs
Source: "{#MyTardisVersion}\.git\*"; DestDir: "{app}\{#MyTardisVersion}\.git"; Flags: recursesubdirs ignoreversion; Components: git

[Dirs]
Name: "{app}\{#MyTardisVersion}"; Permissions: "users-full"

[Icons]
Name: "{group}\{#MyTardisAppName}"; Filename: "{app}\{#MyTardisRunServer}"; WorkingDir: "{app}"; IconFilename: "{app}\MyTardis.ico"
Name: "{group}\{#MyTardisCommandPrompt}"; Filename: "{app}\{#MyTardisCommandPrompt}"; WorkingDir: "{app}"; IconFilename: "{win}\system32\cmd.exe"
Name: "{group}\{cm:UninstallProgram,{#MyTardisAppName}}"; Filename: "{uninstallexe}"

[Code]
function CreateBatch(): boolean;
var
  fileName : string;
  lines : TArrayOfString;
begin
  Result := true;
  fileName := ExpandConstant('{app}\MyTardisCommandPrompt.bat');
  SetArrayLength(lines, 4);
  lines[0] := '@echo off';
  lines[1] := ExpandConstant('set PATH={app}\Python27;%PATH%');
  lines[2] := ExpandConstant('set PATH={app}\Python27\Scripts;%PATH%');
  lines[3] := 'start "%windir%\system32\cmd.exe"';
  Result := SaveStringsToFile(filename, lines, False);
  exit;
end;
 
procedure CurStepChanged(CurStep: TSetupStep);
begin
  if  CurStep=ssPostInstall then
    begin
         CreateBatch();
    end
end;
