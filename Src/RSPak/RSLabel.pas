unit RSLabel;

{ *********************************************************************** }
{                                                                         }
{ RSPak                                    Copyright (c) Rozhenko Sergey  }
{ http://sites.google.com/site/sergroj/                                   }
{ sergroj@mail.ru                                                         }
{                                                                         }
{ See copyright notice at the end of RSSysUtils.pas file (MIT license).   }
{                                                                         }
{ *********************************************************************** )

 IndentVertical    Adds spece before or after the text according to Layout.
  Default value mekes it position on one line with edit's text.
  Also, you can place it right above an edit, set Layout to tlBottom and the
  spece between it and the edit would be the same as of TLabeledEdit.

 IndentHorizontal  Adds space on the right side if Alignment = taRightJustify.
  This behavior of IndentHorizontal may seem wierd, but that's when it's needed.
  The default space is also similar to one in TLabeledEdit.

{ *********************************************************************** }
{$I RSPak.inc}

// This Indent stuff was useful in Delphi 7, but is bad in Delphi 2006,
// because labels are aligned with edits automatically.

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, RSCommon, RSQ;

{$I RSControlImport.inc}

type
  TRSLabel = class(TLabel)
  private
    FProps: TRSControlProps;
    procedure SetIndentHorizontal(v: int);
    procedure SetDesignTimeIndent(v: Boolean);
    procedure SetIndentBottom(v: int);
    procedure SetIndentLeft(v: int);
    procedure SetIndentRight(v: int);
    procedure SetIndentTop(v: int);
    procedure SetIndent(var Indent: int; v: int);
  protected
    FIndentTop: int;
    FIndentBottom: int;
    FIndentLeft: int;
    FIndentRight: int;
    FDesignTimeIndent: Boolean;
    procedure ApplyIndentToBounds(TurnOn: Boolean);
    procedure ChangeRect(var r:TRect; Mul:int);
    procedure ChangeRectH(var r:TRect; Mul:int);
    procedure ChangeRectV(var r:TRect; Mul:int);
    procedure DoDrawText(var Rect: TRect; Flags: Longint); override;
    procedure ReadState(Reader: TReader); override;
    procedure TranslateWndProc(var Msg: TMessage);
    procedure WndProc(var Msg: TMessage); override;
  public
    constructor Create(AOwner:TComponent); override;
    property MouseInside: Boolean read FProps.MouseIn;
  published
    property OnCanResize;
{$IFNDEF D7} // They already exist in TLabel since some version
    property OnMouseEnter: TNotifyEvent read FProps.OnMouseEnter write FProps.OnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FProps.OnMouseLeave write FProps.OnMouseLeave;
{$ENDIF}
    property IndentTop: int read FIndentTop write SetIndentTop default 3;
    property IndentBottom: int read FIndentBottom write SetIndentBottom default 4;
    property IndentLeft: int read FIndentLeft write SetIndentLeft default 0;
    property IndentRight: int read FIndentRight write SetIndentRight default 4;
    // these 2 are for backward compatibility
    property IndentVertical: int read FIndentTop write SetIndentTop stored false;
    property IndentHorizontal: int read FIndentRight write SetIndentHorizontal stored false;
    property DesignTimeIndent: Boolean read FDesignTimeIndent write SetDesignTimeIndent default true;
    property OnResize;
    property OnWndProc: TRSWndProcEvent read FProps.OnWndProc write FProps.OnWndProc;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RSPak', [TRSLabel]);
end;

{
********************************** TRSLabel ***********************************
}

procedure TRSLabel.ApplyIndentToBounds(TurnOn: Boolean);
const
  IndentMul: array[Boolean] of int = (-1, 1);
var
  r: TRect;
begin
  r:= BoundsRect;
  ChangeRect(r, IndentMul[TurnOn]);
  BoundsRect:= r;
  AdjustBounds;
end;

procedure TRSLabel.ChangeRect(var r:TRect; Mul:int);
begin
  ChangeRectH(r, Mul);
  ChangeRectV(r, Mul);
end;

procedure TRSLabel.ChangeRectH(var r: TRect; Mul: int);
begin
  if Alignment = taRightJustify then
    inc(r.Right, Mul*FIndentRight)
  else if Alignment = taLeftJustify then
    dec(r.Left, Mul*FIndentLeft);
end;

procedure TRSLabel.ChangeRectV(var r: TRect; Mul: int);
begin
  if Layout=tlTop then
    dec(r.Top, Mul*FIndentTop)
  else if Layout=tlBottom then
    inc(r.Bottom, Mul*FIndentBottom);
end;

constructor TRSLabel.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  WindowProc:= TranslateWndProc;
  FIndentTop:= 3;
  FIndentRight:= 4;
  FIndentBottom:= 4;
  // I don't know when text alignment guidelines appeared, D8 is an educated guess  
  FDesignTimeIndent:= {$IFDEF D8}false{$ELSE}true{$ENDIF};
  if DesignTimeIndent or not (csDesigning in ComponentState) then
    AdjustBounds;
end;

procedure TRSLabel.TranslateWndProc(var Msg: TMessage);
var
  b: Boolean;
begin
  if assigned(FProps.OnWndProc) then
  begin
    b:=false;
    FProps.OnWndProc(Self, Msg, b, WndProc);
    if b then exit;
  end;
  WndProc(Msg);
end;

procedure TRSLabel.WndProc(var Msg: TMessage);
begin
  RSProcessProps(self, Msg, FProps);
  inherited;
end;

{$W-}
procedure TRSLabel.DoDrawText(var Rect: TRect; Flags: Longint);
begin
  if DesignTimeIndent or not (csDesigning in ComponentState) then
  begin
    ChangeRect(Rect, -1);
    inherited;
    ChangeRect(Rect, 1);
  end else
    inherited;
end;

procedure TRSLabel.ReadState(Reader: TReader);
begin
  FDesignTimeIndent:= true;
  inherited;
  if DesignTimeIndent or (csDesigning in ComponentState) then  exit;
  ApplyIndentToBounds(true);
end;

procedure TRSLabel.SetDesignTimeIndent(v: Boolean);
begin
  if FDesignTimeIndent = v then exit;
  FDesignTimeIndent:= v;
  if ComponentState*[csReading, csDesigning] = [csDesigning] then
    ApplyIndentToBounds(v)
end;

procedure TRSLabel.SetIndent(var Indent: int; v: int);
begin
  if Indent = v then  exit;
  Indent:= v;
  if DesignTimeIndent or not (csDesigning in ComponentState) then
    AdjustBounds;
end;

procedure TRSLabel.SetIndentHorizontal(v: int);
begin
  IndentRight:= v;
  IndentBottom:= v;
end;

procedure TRSLabel.SetIndentBottom(v: int);
begin
  SetIndent(FIndentBottom, v);
end;

procedure TRSLabel.SetIndentLeft(v: int);
begin
  SetIndent(FIndentLeft, v);
end;

procedure TRSLabel.SetIndentRight(v: int);
begin
  SetIndent(FIndentRight, v);
end;

procedure TRSLabel.SetIndentTop(v: int);
begin
  SetIndent(FIndentTop, v);
end;

end.
