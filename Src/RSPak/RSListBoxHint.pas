unit RSListBoxHint;

{ *********************************************************************** }
{                                                                         }
{ RSPak                                    Copyright (c) Rozhenko Sergey  }
{ http://sites.google.com/site/sergroj/                                   }
{ sergroj@mail.ru                                                         }
{                                                                         }
{ See copyright notice at the end of RSSysUtils.pas file (MIT license).   }
{                                                                         }
{ *********************************************************************** )

Used internally by RSComboBox and RSListBox

Special thanks to Igor Shevchenko for HSHintComboBox

{ *********************************************************************** }
{$I RSPak.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, RSQ, Graphics, RSSysUtils,
  CommCtrl, Forms, Math;

type
  PHWnd = ^HWnd;

  TRSCustomListBoxHint = class(THintWindow)
  protected
    FCompact: Boolean;
    procedure CreateParams(var Params:TCreateParams); override;
    procedure NCPaint(DC:HDC); override;
    procedure Paint; override;
  public
    procedure ActivateHint(Rect:TRect; const AHint:string); override;
    function CalcHintRect(MaxWidth: Integer; const AHint: string;
      AData: Pointer): TRect; override;
  end;

  TRSListBoxHints = class(TRSCustomListBoxHint)
  protected
    FLastIndex: int;
    FTimerID: int;
    function GetTextRight(const Text:string; r:TRect):int;
    procedure UpdateHint(const p:TPoint); overload;
    procedure DoHideHint;
    procedure WMTimer(var Msg: TWMTimer); message WM_TIMER;
  public
    ListHandle: HWND;
    Columns: int;
    OwnerFont: Boolean;
    constructor Create(AOwner: TComponent); override;
    procedure BeforeWndProc(var Msg:TMessage);
    procedure AfterWndProc(var Msg:TMessage);
    procedure UpdateHint; overload;
    procedure HideHint;
  end;

implementation

procedure TRSCustomListBoxHint.CreateParams(var Params:TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    Style:= Style and not CS_DROPSHADOW;
  with Params do
    ExStyle:= ExStyle or WS_EX_TOPMOST;
end;

procedure TRSCustomListBoxHint.NCPaint(DC:HDC);
begin
  with TBrush.Create do
  try
    Color:=clBlack;
    FrameRect(DC, Rect(0, 0, Width, Height), Handle);
  finally
    Free;
  end;
end;

procedure TRSCustomListBoxHint.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  if FCompact then
    inc(R.Left, 1)
  else
    inc(R.Left, 2);
  DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or
    DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly);
end;

procedure TRSCustomListBoxHint.ActivateHint(Rect:TRect; const AHint:string);
var
  a:TAnimateWindowProc;
begin
  Canvas.Font.Color:=Screen.HintFont.Color;
  dec(Rect.Bottom, 4); // Потом inherited ActivateHint делает inc на 4

  if not FCompact then
  begin
    dec(Rect.Left);
    inc(Rect.Right, 2);
  end else
    dec(Rect.Left, 2);

  dec(Rect.Top);
  inc(Rect.Bottom);

  a:=@AnimateWindowProc;
  @AnimateWindowProc:=nil;
  inherited ActivateHint(Rect, AHint);
  @AnimateWindowProc:=@a;
end;

function TRSCustomListBoxHint.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
begin
  Result:= inherited CalcHintRect(MaxWidth, AHint, AData);
  dec(Result.Right, 4);
  dec(Result.Bottom, 2);
end;

{
******************************* TRSListBoxHints ********************************
}

procedure TRSListBoxHints.BeforeWndProc(var Msg:TMessage);
begin
  case Msg.Msg of
    WM_MOUSEMOVE:
      with TWMMouseMove(Msg) do
        UpdateHint(Point(XPos, YPos));
    WM_SHOWWINDOW:
      if Msg.WParam = 0 then
        HideHint;
    CM_MOUSELEAVE:
      HideHint;
    CM_MOUSEENTER, WM_NCMOUSEMOVE:
      UpdateHint;
  end;
end;

constructor TRSListBoxHints.Create(AOwner: TComponent);
begin
  inherited;
  OwnerFont:= AOwner is TControl;
  FLastIndex:= -1;
  Color:= clInfoBk;
end;

procedure TRSListBoxHints.DoHideHint;
begin
  if FTimerID <> 0 then
    KillTimer(Handle, FTimerID);
  FTimerID:= 0;
  ReleaseHandle;
end;

procedure TRSListBoxHints.AfterWndProc(var Msg:TMessage);
begin
  case Msg.Msg of
    WM_VSCROLL, WM_MOUSEWHEEL:
      UpdateHint;
  end;
end;

procedure TRSListBoxHints.HideHint;
begin
  DoHideHint;
  FLastIndex:= -1;
end;

function GetItemText(h:hwnd; i:int):string;
begin
  SetLength(Result, SendMessage(h, LB_GETTEXTLEN, i, 0));
  SendMessage(h, LB_GETTEXT, i, int(Result));
end;

function TRSListBoxHints.GetTextRight(const Text:string; r:TRect):int;
var DC:HDC; old:HFONT;
begin
  DC:= GetDC(ListHandle);
  try
    if OwnerFont then
      old:= SelectObject(DC, TRSListBoxHints(Owner as TControl).Font.Handle)
    else
      old:= SelectObject(DC, Font.Handle);

    if Columns<>0 then
      inc(r.Left)
    else
      inc(r.Left, 2);
    DrawText(DC, ptr(Text), length(Text), r, DT_CALCRECT or DT_NOPREFIX);
    SelectObject(DC, old);
    Result:=r.Right;
  finally
    ReleaseDC(ListHandle, DC);
  end;
end;

procedure TRSListBoxHints.UpdateHint;
var p:TPoint;
begin
  if GetCursorPos(p) and Windows.ScreenToClient(ListHandle, p) then
    UpdateHint(p);
end;

procedure TRSListBoxHints.WMTimer(var Msg: TWMTimer);
begin
  inherited;
  if (Msg.TimerID = FTimerID) and not IsWindowVisible(ListHandle) then
    HideHint;
end;

procedure TRSListBoxHints.UpdateHint(const p:TPoint);
var
  i, dh: int; r, r1:TRect; Text:string;
begin
  Windows.GetClientRect(ListHandle, r);
  if PtInRect(r, p) then
  begin
    i:= SendMessage(ListHandle, LB_ITEMFROMPOINT, 0, MakeLParam(p.x, p.y));
    RSWin32Check(i<>LB_ERR);
    if i shr 16 <> 0 then
      i:=-1;
  end else
    i:=-1;

  if i=FLastIndex then exit;
  FLastIndex:=i;
  if i>=0 then
  begin
    Text:=GetItemText(ListHandle, i);
    RSWin32Check(SendMessage(ListHandle, LB_GETITEMRECT, i, int(@r))<>LB_ERR);
    if GetTextRight(Text, r) > r.Right then
    begin
      MapWindowPoints(ListHandle, 0, r, 2); // Client To Screen
      if OwnerFont then
        Canvas.Font:= TRSListBoxHints(Owner as TControl).Font
      else
        Canvas.Font:= Font;

       // Calculate Hint Window rect
      FCompact:= Columns<>0;
      r1:= CalcHintRect(Screen.Width, Text, nil);
      SetMax(r.Right, r.Left + r1.Right);
      dh:= max(r.Bottom, r.Top + r1.Bottom) - r.Bottom;
      dec(r.Top, (dh + 1) div 2);
      inc(r.Bottom, dh div 2);

      ActivateHint(r, Text);
      if FTimerID = 0 then
      begin
        FTimerID:= 1;
        RSWin32Check(SetTimer(Handle, FTimerID, 10, nil));
      end;
      exit; // Don't hide hint window
    end;
  end;
  DoHideHint;
end;

end.
