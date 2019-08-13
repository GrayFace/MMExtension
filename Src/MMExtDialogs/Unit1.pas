unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RSEdit, RSMemo, RSQ, RSSysUtils, RSStrUtils, Types, Math,
  MultiMon, RSGraphics;

{TODO: problems in MM7-8 in full screen}

type
  TForm1 = class(TForm)
    RSMemo1: TRSMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RSMemo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RSMemo1WndProc(Sender: TObject; var m: TMessage;
      var Handled: Boolean; const NextWndProc: TWndMethod);
    procedure RSMemo1KeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    FWasDeactivated: Boolean;
    FMomoPos: int;
    FInUndo: Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMActivateApp(var Msg:TWMActivateApp); message WM_ActivateApp;
    procedure WMSysCommand(var m: TWMSysCommand); message WM_SysCommand;
    procedure AcceptResult;
    procedure CancelInput;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function DebugDialog(parentWnd: HWND; question: PChar; topmost: BOOL): PChar; stdcall;
procedure DebugDialogAnswer(text: PChar; pos: int4); stdcall;
procedure DebugDialogResize(w, h: int); stdcall;
function DebugDialogCharsInLine(parentWnd: HWND): int; stdcall;
procedure DebugDialogBranch(p: PChar); stdcall;
procedure DebugDialogCaption(p: PChar); stdcall;
function DebugDialogLastResult(p: PChar): PChar; stdcall;

implementation

{$R *.dfm}

const
  InputStart = '> ';
  TabSize: DWORD = 8;

var
  DlgResult, OldResult, Answer: string;
  AnswerSelPos: int;
  DlgW: int = 0;
  DlgH: int = 0;
  DlgCaption: string = 'MMExtension Debug Console';
  CharsInLine: int;
  Running: Boolean;

procedure CalcCharsInLine;
begin
  with Form1.RSMemo1 do
  begin
    while Lines.Count <= 1 do
      Text:= Text + '------';
    CharsInLine:= length(Lines[0]);
    Clear;
  end;
end;

function NeedForm(parentWnd: HWND): TForm1;
var
  r: TRect;
  bo: int;
begin
  if Form1 = nil then
  begin
    if parentWnd <> 0 then
      Application.Handle:= parentWnd
    else
      Application.Initialize;
    Application.CreateForm(TForm1, Form1);
    if (DlgW = 0) and (parentWnd <> 0) then
    begin
      GetClientRect(parentWnd, r);
      MapWindowPoints(parentWnd, 0, r, 2);
      IntersectRect(r, r, Screen.MonitorFromWindow(parentWnd).WorkareaRect);
      OffsetRect(r, -r.Left, -r.Top);
      bo:= max(20, min(r.Right, r.Bottom) div 25);
      DlgW:= r.Right - bo;
      DlgH:= r.Bottom - bo;
    end;
    if DlgW > 0 then
      Form1.Width:= DlgW;
    if DlgH > 0 then
      Form1.Height:= DlgH;
    Form1.Caption:= DlgCaption;
    CalcCharsInLine;
    Form1.RSMemo1.Perform(EM_SETTABSTOPS, 1, int(@TabSize));
  end;
  Result:= Form1;
end;

function DebugDialog(parentWnd: HWND; question: PChar; topmost: BOOL): PChar; stdcall;

  procedure BackToApp;
  begin
    if parentWnd <> 0 then
    begin
      EnableWindow(parentWnd, true);
      if IsIconic(parentWnd) then
        SendMessage(parentWnd, WM_SYSCOMMAND, SC_RESTORE, 0);
      SetForegroundWindow(parentWnd);
      if Form1.FWasDeactivated then
        SendMessage(parentWnd, WM_ACTIVATEAPP, 1, 0);
    end;
  end;

  procedure HideForm;
  begin
    BackToApp;
    if Form1 <> nil then
      Form1.Hide;
  end;

var
  r: TRect;
  pt: TPoint;
  w, h: int;
  s: string;
begin
  try
    if question = nil then
    begin
      if Running then
        Form1.CancelInput;
      HideForm;
      Result:= '';
      exit;
    end;
    if Running then
    begin
      // write string prior to current input?
      Result:= '';
      exit;
    end;
    s:= RSStringReplace(question, [#10, #13#10], #13#10);
    if DlgResult <> '' then
      OldResult:= DlgResult;
    DlgResult:= '';
    with NeedForm(parentWnd) do
    begin
      FWasDeactivated:= false;
      if topmost then
        FormStyle:= fsStayOnTop
      else
        FormStyle:= fsNormal;
      if not Visible then
      begin
        pt.X:= 0;
        pt.Y:= 0;
        if (parentWnd <> 0) and IsWindowVisible(parentWnd) and not IsIconic(parentWnd) then
          with TRSWnd(parentWnd).ClientRect do
          begin
            r:= Screen.MonitorFromWindow(parentWnd).WorkareaRect;
            w:= Right - Left;
            h:= Bottom - Top;
            windows.ClientToScreen(parentWnd, pt);
          end
        else
        begin
          r:= Screen.MonitorFromWindow(Handle).WorkareaRect;
          w:= r.Right - r.Left;
          h:= r.Bottom - r.Top;
          pt:= r.TopLeft;
        end;
        //Screen.Monitors.
        Left:= (w - Width) div 2 + pt.X;
        Top:= (h - Height) div 2 + pt.Y;
        if Left + Width > r.Right then
          Left:= r.Right - Width;
        if Top + Height > r.Bottom then
          Top:= r.Bottom - Height;
        if Left < r.Left then
          Left:= r.Left;
        if Top < r.Top then
          Top:= r.Top;
      end;
      SetForegroundWindow(Handle);

      if topmost then
      begin
        BorderIcons:= [biSystemMenu];
      end else
        if parentWnd <> 0 then
          BorderIcons:= [biMaximize, biSystemMenu]
        else
          BorderIcons:= [biMaximize, biSystemMenu, biMinimize];

      //SetWindowPos(Handle, topmost, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE + SWP_NOACTIVATE);
      RSMemo1.SelStart:= MaxInt;
      RSMemo1.SelText:= s + InputStart;
      RSMemo1.SelStart:= MaxInt;
      FMomoPos:= RSMemo1.SelStart;
      RSMemo1.SelText:= Answer;
      Answer:= '';
      //RSMemo1.Perform(EM_SETTABSTOPS, 1, int(@TabSize));
      RSMemo1.Perform(WM_VSCROLL, SB_BOTTOM, 0);
      if AnswerSelPos <= 0 then
        RSMemo1.SelStart:= FMomoPos
      else
        RSMemo1.SelStart:= MaxInt;
      if AnswerSelPos = 0 then
        RSMemo1.SelLength:= MaxInt;
      PostMessage(RSMemo1.Handle, EM_SCROLLCARET, 0, 0);
    end;
    if parentWnd <> 0 then
      EnableWindow(parentWnd, false);
    Running:= true;
    Application.Run;
    Running:= false;
    PBoolean(@Application.Terminated)^:= false;
    if DlgResult = '' then
      HideForm
    else
      BackToApp;
    Result:= ptr(DlgResult);
  except
    RSShowException;
    Result:= '';
  end;
end;

procedure DebugDialogAnswer(text: PChar; pos: int4);
begin
  Answer:= RSStringReplace(text, #10, #13#10);
  AnswerSelPos:= pos;
end;

procedure DebugDialogResize(w, h: int); stdcall;
begin
  DlgW:= w;
  DlgH:= h;
end;

function DebugDialogCharsInLine(parentWnd: HWND): int; stdcall;
begin
  NeedForm(parentWnd);
  Result:= CharsInLine;
end;

procedure DebugDialogCaption(p: PChar); stdcall;
begin
  DlgCaption:= p;
end;

function DebugDialogLastResult(p: PChar): PChar; stdcall;
begin
  if p <> nil then
  begin
    DlgResult:= p;
    OldResult:= '';
    Result:= p;
    exit;
  end;
  Result:= ptr(DlgResult);
  if Result = nil then
    Result:= ptr(oldResult);
end;

procedure SaveBufferToBitmap(s: PChar; buf: ptr; w, h, bits: int); stdcall;
var
  b: TBitmap;
begin
  b:= TBitmap.Create;
  try
    case bits of
      32:   b.PixelFormat:= pf32bit;
      24:   b.PixelFormat:= pf24bit;
      16,0: b.PixelFormat:= pf16bit;
      15:   b.PixelFormat:= pf15bit;
      else  Assert(false);
    end;
    b.Width:= w;
    b.Height:= h;
    RSBufferToBitmap(buf, b);
    RSCreateDir(ExtractFilePath(s));
    b.SaveToFile(s);
  except
    RSShowException;
  end;
  b.Free;
end;


{ DebugDialogBranch }

type
  TDialogBranch = class
  public
    MemoText, DlgResult, OldResult: string;
  end;

var
  BranchList: TStringList;
  CurBranch: string;

function GetBranch(const s: string): TDialogBranch;
var
  i: int;
begin
  if BranchList = nil then
  begin
    BranchList:= TStringList.Create;
    BranchList.Sorted:= true;
  end;
  if not BranchList.Find(s, i) then
    i:= BranchList.AddObject(s, TDialogBranch.Create);
  Result:= TDialogBranch(BranchList.Objects[i]);
end;

procedure StoreBranch(b: TDialogBranch; store: Boolean);
begin
  if Form1 = nil then  exit;
  zSwap(DlgResult, b.DlgResult);
  zSwap(OldResult, b.OldResult);
  if not store then
  begin
    Form1.RSMemo1.Text:= b.MemoText;
    b.MemoText:= '';
  end else
    b.MemoText:= Form1.RSMemo1.Text;
end;

procedure DebugDialogBranch(p: PChar); stdcall;
var
  s: string;
begin
  s:= p;
  if s = CurBranch then  exit;
  StoreBranch(GetBranch(CurBranch), true);
  StoreBranch(GetBranch(s), false);
  CurBranch:= s;
end;

{ TForm1 }

procedure TForm1.AcceptResult;
begin
  PBoolean(@Application.Terminated)^:= true;
  RSMemo1.Perform(EM_SETSEL, FMomoPos, -1);
  DlgResult:= RSMemo1.SelText;
  RSMemo1.SelStart:= MaxInt;
  RSMemo1.SelText:= #13#10;
end;

procedure TForm1.CancelInput;
begin
  PBoolean(@Application.Terminated)^:= true;
  if RSMemo1.Perform(WM_GETTEXTLENGTH, 0, 0) <> FMomoPos then
  begin
    RSMemo1.Perform(EM_SETSEL, FMomoPos, -1);
    OldResult:= RSMemo1.SelText;
  end;
  RSMemo1.Perform(EM_SETSEL, FMomoPos - length(InputStart), -1);
  RSMemo1.SelText:= '';
end;

procedure TForm1.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WinClassName:='MMExtension Debug Console Form';
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CancelInput;
  Action:= caNone;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

procedure TForm1.RSMemo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not FInUndo then
    if (Key = VK_BACKSPACE) or (Key = VK_DELETE) and (GetKeyState(VK_SHIFT) < 0) then
      RSMemo1.ReadOnly:= RSMemo1.SelStart <= FMomoPos
    else
      RSMemo1.ReadOnly:= RSMemo1.SelStart < FMomoPos;
end;

procedure TForm1.RSMemo1KeyPress(Sender: TObject; var Key: Char);
var
  TextBuf: array[0..4095] of Char;
  s: string;
  p: PChar;
  i, j: int;
begin
  if FInUndo then
    exit;

  case Key of
    #10: // Ctrl + Enter
    begin
      Key:= #0;
      AcceptResult;
    end;
    #13: // Enter
    begin
      j:= RSMemo1.Perform(EM_LINEFROMCHAR, -1, 0);
      if (j >= 0) and (j < RSMemo1.Lines.Count) then
      begin
        PWord(@TextBuf)^:= SizeOf(TextBuf) - 1;
        TextBuf[RSMemo1.Perform(EM_GETLINE, j, int(@TextBuf))]:= #0;
        j:= RSMemo1.Perform(EM_LINEINDEX, j, 0);
        p:= @TextBuf;
        if (j < FMomoPos) then
        begin
          inc(p, 2);
          inc(j, 2);
        end;
        j:= RSMemo1.SelStart - j;
        i:= 0;
        while (i < j) and ((p + i)^ in [#9, ' ']) do  inc(i);
        if i = 0 then
          exit;
        SetString(s, p, i);
        s:= #13#10 + s;
        RSMemo1.Perform(EM_REPLACESEL, 1, int(s));
        Key:= #0;
      end;
    end;
    #5: // Ctrl + E
    begin
      Key:= #0;
      RSMemo1.Perform(EM_SETSEL, FMomoPos, -1);
      RSMemo1.Perform(EM_REPLACESEL, 1, int(PChar(OldResult)));
      RSMemo1.SelStart:= MaxInt;
    end;
    #1: // Ctrl+A
      if RSMemo1.SelStart >= FMomoPos then
      begin
        RSMemo1.Perform(EM_SETSEL, FMomoPos, -1);
        Key:=#0;
      end;
    #27:
      Key:= #0;
    chr(VK_BACKSPACE):
      RSMemo1.ReadOnly:= RSMemo1.SelStart <= FMomoPos;
    else
      RSMemo1.ReadOnly:= RSMemo1.SelStart < FMomoPos;
  end;
end;

procedure TForm1.RSMemo1WndProc(Sender: TObject; var m: TMessage;
  var Handled: Boolean; const NextWndProc: TWndMethod);
var
  i, j: int;
begin
  case m.Msg of
    WM_PASTE, WM_CUT:
      RSMemo1.ReadOnly:= RSMemo1.SelStart < FMomoPos;
    WM_KEYDOWN:
      if TWMKey(m).CharCode = VK_HOME then
      begin
        NextWndProc(m);
        Handled:= true;
        RSMemo1.GetSelection(i, j);
        if j = FMomoPos - length(InputStart) then
          if i = j then
            RSMemo1.SelStart:= FMomoPos
          else if i >= FMomoPos then
            RSMemo1.SetSelection(i, FMomoPos);
      end;
    WM_UNDO:
    begin
      RSMemo1.ReadOnly:= false;
      FInUndo:= true;
      NextWndProc(m);
      Handled:= true;
      FInUndo:= false;
    end;
  end;
end;

{procedure TForm1.WMActivate(var Msg: TWMActivate);
begin
  if (Msg.Active = WA_INACTIVE) and Visible and not (fsShowing in FormState) then
  begin
    BorderIcons:= [biMaximize, biSystemMenu];
    SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE + SWP_NOACTIVATE);
  end;
  inherited;
end;}


procedure TForm1.WMActivateApp(var Msg: TWMActivateApp);
begin
  if Visible and not Msg.Active then
    FWasDeactivated:= true;
  inherited;
end;

procedure TForm1.WMSysCommand(var m: TWMSysCommand);
begin
  // no idea why this problem occurs
  if (m.CmdType and $fff0 = SC_MINIMIZE) and (Application.MainForm = self) then
    DefWindowProc(Handle, WM_SYSCOMMAND, TMessage(m).WParam, TMessage(m).LParam)
  else
    inherited;
end;

exports
  DebugDialog,
  DebugDialogResize,
  DebugDialogCharsInLine,
  DebugDialogAnswer,
  DebugDialogBranch,
  DebugDialogCaption,
  DebugDialogLastResult,
  SaveBufferToBitmap;
  
end.
