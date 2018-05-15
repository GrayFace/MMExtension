unit Hooks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, RSQ, RSSysUtils, RSCodeHook,
  Math;

implementation

type
  TGroundSelInfo = packed record
    SelBmp: int4;
    Selected: array[0..128*128-1] of Boolean;
  end;

var
  SelInfo: TGroundSelInfo;
  StdProc1, StdProc2: int;

procedure GroundHook1;
asm
  mov eax, [esp + 8]
  shl eax, 7
  add eax, [esp + 4]
  lea edx, SelInfo.Selected
  cmp byte ptr edx[eax], 0
  jz @std
  mov eax, SelInfo.SelBmp
  ret 8
@std:
  push StdProc1
end;

procedure GroundHook2;
asm
  mov eax, [esp + 8]
  shl eax, 7
  add eax, [esp + 4]
  lea edx, SelInfo.Selected
  cmp byte ptr edx[eax], 0
  jz @std
  mov eax, SelInfo.SelBmp
  ret 8
@std:
  push StdProc2
end;

function SetHook(p: int; f: ptr): int;
var
  hk: TRSHookInfo;
begin
  FillChar(hk, SizeOf(hk), 0);
  hk.p:= p;
  hk.t:= RShtCall;
  hk.newp:= f;
  Result:= RSGetHookValue(hk);
  RSApplyHook(hk);
end;

function HookGroundBitmap(p1, p2: int): ptr; stdcall;
begin
  StdProc1:= SetHook(p1, @GroundHook1);
  if p2 <> 0 then
    StdProc2:= SetHook(p2, @GroundHook2);
  Result:= @SelInfo;
end;


exports
  HookGroundBitmap;
end.
