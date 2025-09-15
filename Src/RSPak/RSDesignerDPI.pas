unit RSDesignerDPI;

{ *********************************************************************** }
{                                                                         }
{ RSPak                                    Copyright (c) Rozhenko Sergey  }
{ http://sites.google.com/site/sergroj/                                   }
{ sergroj@mail.ru                                                         }
{                                                                         }
{ See copyright notice at the end of RSSysUtils.pas file (MIT license).   }
{                                                                         }
{ *********************************************************************** )

 Allows you to set design-time DPI for a form. Works like magic :)
 Has no effect if Form.Scaled = false.
 Tested in Delphi 2007.

{ *********************************************************************** }
{$I RSPak.inc}

interface

{$IFDEF LINUX}
uses Messages, Windows, SysUtils, Classes, Forms, Consts, WinUtils;
{$ENDIF}
{$IFDEF MSWINDOWS}
uses Messages, Windows, SysUtils, Forms, Classes, Consts;
{$ENDIF}

// Based on TRSTimer
type
  TRSDesignerDPI = class(TComponent)
  private
    procedure SetDPI(const Value: Integer);
  protected
    FDPI, FBackup: Integer;
    FInterval: Cardinal;
    FHandle: HWND;
    FTimer: uint;
    FObjectInstance: Pointer;
    procedure SetInterval(Value: Cardinal);
    procedure Timer;
    procedure WndProc(var Msg: TMessage);
    procedure UpdateTimer;
    property Interval: Cardinal read FInterval write SetInterval;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DPI: Integer read FDPI write SetDPI;
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RSPak', [TRSDesignerDPI]);
end;

constructor TRSDesignerDPI.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDPI:= Screen.PixelsPerInch;
end;

destructor TRSDesignerDPI.Destroy;
begin
  Interval:= 0;
  FreeObjectInstance(FObjectInstance);
  inherited Destroy;
end;

procedure TRSDesignerDPI.WndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_TIMER then
      try
        Timer;
      except
        Application.HandleException(Self);
      end
    else
      Result:= DefWindowProc(FHandle, Msg, wParam, lParam);
end;

procedure TRSDesignerDPI.UpdateTimer;
const
  FUseWindow = true;
var
  Active, IsActive: Boolean;
begin
  Active:= (FInterval <> 0);
  IsActive:= not Active;

  if IsActive then
  begin
    KillTimer(FHandle, FTimer);
    IsActive:=false;
  end;

  if Active then
  begin
    if FUseWindow and (FHandle = 0) then
      FHandle:= AllocateHWnd(WndProc);

    if FHandle<>0 then
    begin
      IsActive:= SetTimer(FHandle, 1, FInterval, nil) <> 0;
      FTimer:= 1;
    end else
    begin
      if FObjectInstance = nil then
        FObjectInstance:= MakeObjectInstance(WndProc);
      FTimer:= SetTimer(0, 1, FInterval, FObjectInstance);
      IsActive:= FTimer<>0;
    end
  end;

  if not IsActive and (FHandle<>0) then
  begin
    DeallocateHWnd(FHandle);
    FHandle:= 0;
  end;

  if Active<>IsActive then
  begin
    FInterval:= 0;
    raise EOutOfResources.Create(SNoTimers);
  end;
end;

procedure TRSDesignerDPI.SetDPI(const Value: Integer);
begin
  FDPI:= Value;
  if ComponentState*[csReading, csDesigning] <> [csReading, csDesigning] then  exit;
  if Interval = 0 then
    FBackup:= Screen.PixelsPerInch;
  PInteger(@Screen.PixelsPerInch)^:= Value;
  Interval:= 1;
end;

procedure TRSDesignerDPI.SetInterval(Value: Cardinal);
begin
  if Value = FInterval then  exit;
  FInterval := Value;
  UpdateTimer;
end;

procedure TRSDesignerDPI.Timer;
begin
  PInteger(@Screen.PixelsPerInch)^:= FBackup;
  Interval:= 0;
end;

end.
