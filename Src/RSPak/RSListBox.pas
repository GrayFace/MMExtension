unit RSListBox;

{ *********************************************************************** }
{                                                                         }
{ RSPak                                    Copyright (c) Rozhenko Sergey  }
{ http://sites.google.com/site/sergroj/                                   }
{ sergroj@mail.ru                                                         }
{                                                                         }
{ See copyright notice at the end of RSSysUtils.pas file (MIT license).   }
{                                                                         }
{ *********************************************************************** }
{$I RSPak.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, RSCommon, RSQ,
  RSListBoxHint;

{$I RSWinControlImport.inc}

type
  TRSListBox = class(TListBox)
  private
    FOnCreateParams: TRSCreateParamsEvent;
    FProps: TRSWinControlProps;

    FAutoHint: Boolean;
    procedure SetAutoHint(v:Boolean);
  protected
    FHintMan: TRSListBoxHints;
    FScaleItemHeight: Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure TranslateWndProc(var Msg: TMessage);
    procedure WndProc(var Msg: TMessage); override;
    procedure ChangeScale(M, D: Integer); override;
  public
    constructor Create(AOwner:TComponent); override;
  published
    property AutoHint: Boolean read FAutoHint write SetAutoHint default false;
    property ScaleItemHeight: Boolean read FScaleItemHeight write FScaleItemHeight default true;
    property BevelWidth;
    property OnCanResize;
    property OnDblClick;
    property OnResize;
    {$I RSWinControlProps.inc}
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RSPak', [TRSListBox]);
end;

{
********************************** TRSListBox ***********************************
}
procedure TRSListBox.ChangeScale(M, D: Integer);
begin
  inherited;
  if FScaleItemHeight then
    ItemHeight:= MulDiv(ItemHeight, M, D);
end;

constructor TRSListBox.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  WindowProc:= TranslateWndProc;
  FHintMan:= TRSListBoxHints.Create(self);
  ItemHeight:= 13;
  FScaleItemHeight:= true;
end;

procedure TRSListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if Assigned(FOnCreateParams) then FOnCreateParams(self, Params);
end;

procedure TRSListBox.TranslateWndProc(var Msg: TMessage);
var b:Boolean;
begin
  if assigned(FProps.OnWndProc) then
  begin
    b:=false;
    FProps.OnWndProc(Self, Msg, b, WndProc);
    if b then exit;
  end;
  WndProc(Msg);
end;

procedure TRSListBox.WndProc(var Msg: TMessage);
begin
  RSProcessProps(self, Msg, FProps);

  if AutoHint and HandleAllocated then
  begin
    FHintMan.ListHandle:= Handle;
    FHintMan.Columns:= Columns;
    FHintMan.BeforeWndProc(Msg);
    inherited;
    FHintMan.AfterWndProc(Msg);
  end else
    inherited;
end;

procedure TRSListBox.SetAutoHint(v:Boolean);
begin
  if FAutoHint= v then exit;
  FAutoHint:= v;
  if v then
    FHintMan.UpdateHint
  else
    FHintMan.HideHint;
end;

end.
