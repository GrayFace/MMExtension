unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RSEdit, RSMemo, RSQ, RSSysUtils, RSStrUtils, Types, Math;

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

implementation

{$R *.dfm}

const
  InputStart = '> ';
  TabSize: DWORD = 8;

var
  DlgResult, OldResult, Answer: string;
  AnswerSelPos: int;
  DlgW: int = 620;
  DlgH: int = 460;
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
begin
  if Form1 = nil then
  begin
    Application.Handle:= parentWnd;
    Application.CreateForm(TForm1, Form1);
    Form1.Width:= DlgW;
    Form1.Height:= DlgH;
    CalcCharsInLine;
    Form1.RSMemo1.Perform(EM_SETTABSTOPS, 1, int(@TabSize));
    //TForm((@Application.MainForm)^):= Form1;
    //Form1.ParentWindow:= parentWnd;
  end;
  Result:= Form1;
end;

function DebugDialog(parentWnd: HWND; question: PChar; topmost: BOOL): PChar; stdcall;

  procedure HideForm;
  begin
    EnableWindow(parentWnd, true);
    SetForegroundWindow(parentWnd);
    if Form1 <> nil then
      Form1.Hide;
  end;

var
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
            w:= Right - Left;
            h:= Bottom - Top;
            windows.ClientToScreen(parentWnd, pt);
          end
        else
        begin
          w:= Screen.Width;
          h:= Screen.Height;
        end;
        Left:= (w - Width) div 2 + pt.X;
        Top:= (h - Height) div 2 + pt.Y;
        w:= Screen.Width;
        h:= Screen.Height;
        if Left + Width > w then
          Left:= w - Width;
        if Top + Height > h then
          Top:= h - Height;
        if Left < 0 then
          Left:= 0;
        if Top < 0 then
          Top:= 0;
      end;
      SetForegroundWindow(Handle);

      if topmost then
      begin
        BorderIcons:= [biSystemMenu];
        //topmost:= HWND_NOTOPMOST;
      end else
      begin
        BorderIcons:= [biMaximize, biSystemMenu];
        //topmost:= HWND_TOPMOST;
      end;

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
    EnableWindow(parentWnd, false);
    Running:= true;
    Application.Run;
    Running:= false;
    PBoolean(@Application.Terminated)^:= false;
    EnableWindow(parentWnd, true);
    if IsIconic(parentWnd) then
      SendMessage(parentWnd, WM_SYSCOMMAND, SC_RESTORE, 0);
    SetForegroundWindow(parentWnd);
    if Form1.FWasDeactivated then
      SendMessage(parentWnd, WM_ACTIVATEAPP, 1, 0);
    if DlgResult = '' then
      HideForm;
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

exports
  DebugDialog,
  DebugDialogResize,
  DebugDialogCharsInLine,
  DebugDialogAnswer,
  DebugDialogBranch;
end.
