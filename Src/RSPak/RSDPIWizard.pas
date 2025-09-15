unit RSDPIWizard;

{ *********************************************************************** }
{                                                                         }
{ RSPak                                    Copyright (c) Rozhenko Sergey  }
{ http://sites.google.com/site/sergroj/                                   }
{ sergroj@mail.ru                                                         }
{                                                                         }
{ See copyright notice at the end of RSSysUtils.pas file (MIT license).   }
{                                                                         }
{ *********************************************************************** )

 Sets design time DPI to a desired value. Menu item appears in Help menu.
 By default it offers previous DPI value, so you can quickly switch between
  two favorite vlaues.
 The values are stored in an INI file next to the BPL.
 Tested in Delphi 2007.

{ *********************************************************************** }
{$I RSPak.inc}

interface

uses
  ToolsAPI, SysUtils, Windows, Messages, Classes, Forms, Dialogs, Menus, RSQ,
  IniFiles, RSSysUtils;

procedure Register;

implementation

type
  TRSDPIWizard = class(TNotifierObject, IOTAWizard, IOTAMenuWizard)
  public
    DPI, LastDPI: Integer;
    constructor Create;
    procedure DoIni(read: Boolean = false);
    procedure Apply;
    { IOTAWizard }
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
    { IOTAMenuWizard }
    function GetMenuText: string;
  end;

{ TRSDPIWizard }

procedure TRSDPIWizard.Apply;
begin
  if DPI < 96 then
    PInteger(@Screen.PixelsPerInch)^:= GetDeviceCaps(GetDC(0), LOGPIXELSY)
  else
    PInteger(@Screen.PixelsPerInch)^:= DPI;
end;

constructor TRSDPIWizard.Create;
begin
  inherited;
  DoIni(true);
  Apply;
end;

procedure TRSDPIWizard.Execute;
var
  s: string;
begin
  s:= IntToStr(LastDPI);
  if not InputQuery('Set DPI', 'Design time DPI (0 for system DPI):', s) then  exit;
  LastDPI:= DPI;
  DPI:= StrToIntDef(s, 0);
  DoIni;
  Apply;
end;

function TRSDPIWizard.GetIDString: string;
begin
  Result:= 'RSDPIWizard';
end;

function TRSDPIWizard.GetMenuText: string;
begin
  Result:= 'DPI = ' + IntToStr(PInteger(@Screen.PixelsPerInch)^);
end;

function TRSDPIWizard.GetName: string;
begin
  Result:= 'RSDPIWizard';
end;

function TRSDPIWizard.GetState: TWizardState;
begin
  Result:= [wsEnabled];
end;

procedure TRSDPIWizard.DoIni(read: Boolean);
var
  info: TMemoryBasicInformation;
  name: array[0..MAX_PATH] of Char;
begin
  VirtualQuery(@TRSDPIWizard.DoIni, info, sizeof(info));
  RSWin32Check(GetModuleFileName(THandle(info.AllocationBase), name, SizeOf(name)));
  with TIniFile.Create(ChangeFileExt(name, '.ini')) do
    try
      if read then
        DPI:= ReadInteger('Options', 'DPI', 0)
      else
        WriteInteger('Options', 'DPI', DPI);

      if read then
        LastDPI:= ReadInteger('Options', 'LastDPI', DPI)
      else
        WriteInteger('Options', 'LastDPI', LastDPI);
    finally
      Free;
    end;
end;

procedure Register;
begin
  RegisterPackageWizard(TRSDPIWizard.Create);
end;

end.
