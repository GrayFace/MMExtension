unit RSCodeHook;

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
  Windows, RSSysUtils, RSQ, Math, SysUtils;

type
  TRSHookType = (RShtNop, RSht1, RSht2, RSht4, RShtCall, RShtJmp, RShtJmp6, RShtJmp2, RShtBStr, RShtStr);

  PRSHookInfo = ^TRSHookInfo;
  TRSHookInfo = record
    p: int;
    pref: Boolean;
    old: int;
    oldstr: string;
    backup: ptr;
    add: int;
    new: int;
    newp: ptr;
    newref: Boolean;
    newstr: string;
    t: TRSHookType;
    size: int;
    Querry: int;
  end;

procedure RSApplyHook(const Hook: TRSHookInfo);
procedure RSApplyHooks(const Hooks; Querry: int = 0);
function RSCheckHook(const hk:TRSHookInfo):Boolean;
function RSCheckHooks(const Hooks):Boolean; overload;
function RSCheckHooks(const Hooks; Querry: int):Boolean; overload;
function RSGetHookValue(const hk: TRSHookInfo):int;

implementation

function RSGetHookValue(const hk: TRSHookInfo):int;
var p: int;
begin
  p:= hk.p;
  case hk.t of
    RSht1:  Result:= pbyte(p)^;
    RSht2:  Result:= pword(p)^;
    RSht4:  Result:= pint(p)^;
    RShtCall, RShtJmp:
      Result:= pint(p+1)^ + p + 5;
    RShtJmp6:
      Result:= pint(p+2)^ + p + 6;
    RShtJmp2:
      Result:= pint1(p+1)^ + p + 2;
    else
      Result:= 0;
  end;
end;

procedure RSApplyHook(const Hook: TRSHookInfo);
var
  OldProtect: DWord;
  sz, sz0, new, i, p: int;
begin
  case Hook.t of
    RShtNop:  sz0:= 0;
    RSht1:    sz0:= 1;
    RSht2:    sz0:= 2;
    RSht4:    sz0:= 4;
    RShtJmp2: sz0:= 2;
    RShtJmp6: sz0:= 6;
    RShtBStr: sz0:= length(Hook.oldstr);
    RShtStr:  sz0:= length(Hook.oldstr) + 1;
    else      sz0:= 5;
  end;
  sz:= max(Hook.size, sz0);
  p:= Hook.p;
  if Hook.pref then  p:= pint(p)^;
  new:= int(Hook.newp);
  if new = 0 then  new:= Hook.new;
  if Hook.newref then  new:= pint(new)^;
  if Hook.add <> 0 then  new:= RSGetHookValue(Hook) + Hook.add;
  if Hook.backup <> nil then  pint(Hook.backup)^:= RSGetHookValue(Hook);

  VirtualProtect(ptr(p), sz, PAGE_EXECUTE_READWRITE, @OldProtect);
  case Hook.t of
    RSht1:    pbyte(p)^:= new;
    RSht2:    pword(p)^:= new;
    RSht4:    pint(p)^:= new;
    RShtJmp6: pint(p+2)^:= new - p - 6;
    RShtJmp2: pint1(p+1)^:= new - p - 2;
    RShtCall:
    begin
      pbyte(p)^:= $E8;
      pint(p+1)^:= new - p - 5;
    end;
    RShtJmp:
    begin
      pbyte(p)^:= $E9;
      pint(p+1)^:= new - p - 5;
    end;
    RShtBStr, RShtStr:
      CopyMemory(ptr(p), PChar(Hook.newstr), sz0);
  end;
  for i := sz0 to sz - 1 do
    pbyte(p+i)^:= $90;
  VirtualProtect(ptr(p), sz, OldProtect, @OldProtect);
end;

procedure RSApplyHooks(const Hooks; Querry: int = 0);
var
  hk: PRSHookInfo;
begin
  hk:= @Hooks;
  while hk.p <> 0 do
  begin
    if hk.Querry = Querry then
      RSApplyHook(hk^);
    inc(hk);
  end;
end;

function RSCheckHook(const hk:TRSHookInfo):Boolean;
begin
  Result:= true;
  if hk.old = 0 then
    if (hk.newp <> nil) or (hk.add <> 0) or not (hk.t in [RSht1, RSht2, RSht4, RShtBStr, RShtStr]) then
      exit;

  if hk.t in [RShtBStr, RShtStr] then
    Result:= CompareMem(ptr(hk.p), PChar(hk.oldstr), length(hk.oldstr) + IfThen(hk.t = RShtStr, 1, 0))
  else
    Result:= RSGetHookValue(hk) = hk.old;
end;

function RSCheckHooks(const Hooks):Boolean;
var
  hk: PRSHookInfo;
begin
  hk:= @Hooks;
  Result:= false;
  while hk.p <> 0 do
  begin
    if not RSCheckHook(hk^) then  exit;
    inc(hk);
  end;
  Result:= true;
end;

function RSCheckHooks(const Hooks; Querry: int):Boolean;
var
  hk: PRSHookInfo;
begin
  hk:= @Hooks;
  Result:= false;
  while hk.p <> 0 do
  begin
    if (hk.Querry = Querry) and not RSCheckHook(hk^) then  exit;
    inc(hk);
  end;
  Result:= true;
end;

end.
