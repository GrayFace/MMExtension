unit RSGraphics;

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

uses Windows, Classes, SysUtils, Graphics, Math, RSQ, RSSysUtils, GraphUtil;

type
  TRSFloatPoint = record
    X, Y: Double;
  end;
  PRSFloatPoint = ^TRSFloatPoint;

  TRSXForm = {$IFDEF D2006}record{$ELSE}object{$ENDIF}
    eM11: Double;
    eM12: Double;
    eM21: Double;
    eM22: Double;
    function TryInverse:boolean; overload;
    function TryInverse(var dest:TRSXForm):boolean; overload;
    procedure Inverse; overload;
    procedure Inverse(var dest:TRSXForm); overload;
    procedure SetE;
    // rotation is clockwise in images, counter-clockwise in math
    procedure SetRotate(const angle: Double);
    procedure SetScale(const x,y: Double);
    procedure SetTransform(O1,X1,Y1,O2,X2,Y2: TPoint); overload;
    procedure SetTransform(O1,X1,Y1,O2,X2,Y2: TRSFloatPoint); overload;
    procedure Rotate(const angle: Double);
    procedure Scale(const x,y: Double);
    function Mul(const v:TRSXForm):TRSXForm;
  end;
  PRSXForm = ^TRSXForm;

  TRSAreaTransform = {$IFDEF D2006}record{$ELSE}object{$ENDIF}
    Form: TRSXForm;
    Lo, Hi: TRSFloatPoint;
    function GetDestWidth: int;
    function GetDestHeight: int;
    function MapSourcePoint(x, y: ext): TRSFloatPoint;
    function MapSourcePixel(x, y: int): TPoint;
    procedure IncludeSourcePoint(x, y: ext);
    procedure IncludeSourceRect(r: TRect);
    procedure SetSourceRect(r: TRect);
    procedure SetEmpty;
    procedure CenterInDest(w, h: ext); overload;
    procedure CenterInDest; overload;
  end;
  PRSAreaTransform = ^TRSAreaTransform;

  TRSTransformProc = function(p: TPoint; Source, Dest: TBitmap): TPoint of object;
  TRSSmoothTransformProc = function(p: TPoint; Source, Dest: TBitmap): TRSFloatPoint of object;
  TRSTransformEnhanceProc = function(Src, Dest: TBitmap; const ClipRect: TRect;
    Proc: TRSSmoothTransformProc): TRSSmoothTransformProc of object;

  TRSEnhancedTransform = {$IFDEF D2006}record{$ELSE}object{$ENDIF}
    Width, Height: int;
    Points: array of TRSFloatPoint;
    function Init(BmpSrc, BmpDest: TBitmap; const sr: TRect; Proc: TRSSmoothTransformProc;
       ISigma: ext = 1.9; MidShift: ext = 0.5; MainShift: ext = 1): TRSSmoothTransformProc;
    function Get: TRSSmoothTransformProc;
  end;
  PRSEnhancedTransform = ^TRSEnhancedTransform;

  TRSTransformEnhancer = {$IFDEF D2006}record{$ELSE}object{$ENDIF}
    Enhanced: TRSEnhancedTransform;
    ISigma, MidShift, MainShift: Double;
    Reuse: Boolean;
    function Get: TRSTransformEnhanceProc;
  end;
  PRSTransformEnhancer = ^TRSTransformEnhancer;

  TRSHLS = record
    Hue: Byte; // Hue
    Lum: Byte; // Luminance
    Sat: Byte; // Saturation
    Reserved: Byte;
  end;
  PRSHLS = ^TRSHLS;

function RSExcludeClipRect(DC:HDC; Rect:TRect):Integer; stdcall; external gdi32 name 'ExcludeClipRect';

function RSLoadPic(const Path:string; APixelFormat:TPixelFormat=pfCustom;
                   Pic:TBitmap=nil):TBitmap;

 // Fixes Delphi bugs with bitmaps
function RSLoadBitmap(Stream:TStream; Bmp:TBitmap = nil):TBitmap; overload;
function RSLoadBitmap(const FileName:string; Bmp:TBitmap = nil):TBitmap; overload;

 // Taken from QPix, made by Boris Novgorodov and Alexey Radionov
function RSGetPixelFormat(b:TBitmap):TPixelFormat;

procedure RSBufferToBitmap(Buf:ptr; Bitmap:TBitmap; const r:TRect); overload;
procedure RSBufferToBitmap(Buf:ptr; Bitmap:TBitmap); overload;
procedure RSBitmapToBuffer(Buf:ptr; Bitmap:TBitmap; const r:TRect); overload;
procedure RSBitmapToBuffer(Buf:ptr; Bitmap:TBitmap); overload;

function rsRGBtoHLS(c:TColor):TRSHLS;
function rsHLStoRGB(const HLS:TRSHLS):TColor;
function RSAdjustLum(c:TColor; ChangeBy:smallint):TColor;
function RSGetIntensity(c:TColor):integer;
function RSAdjustIntensity(c:TColor; ChangeBy:smallInt):TColor;

function RSSwapColor(c:TColor):TColor;

function RSMixColors(Color1, Color2:integer; Weight1:DWord):TColor; overload;
function RSMixColorsRGB(Color1, Color2:integer; Weight1:DWord):TColor; overload;
function RSMixColorsRGBNorm(Color1, Color2:integer;
                            Weight1:DWord):TColor; overload; deprecated;
function RSMixColorsNorm(Color1, Color2:TColor;
                         Weight1:DWord):TColor; overload; deprecated;
function RSMixColorsRGB(Color1, Color2:integer;
                        Weight1, Weight2:DWord):TColor; overload;
function RSMixColors(Color1, Color2:TColor;
                     Weight1, Weight2:DWord):TColor; overload;
function RSMixColorsRGB(const Colors:array of integer;
                        const Weights:array of DWord):TColor; overload;
function RSMixColors(const Colors:array of TColor;
                     const Weights:array of DWord):TColor; overload;
function RSMixColorsRGB(Colors:Pointer; Weights:Pointer;
                        length:DWord):TColor; overload;
function RSMixColorsRGB(Colors:Pointer; step:Integer; Weights:Pointer;
                        length:DWord):TColor; overload;
function RSMixColors(Colors:Pointer; Weights:Pointer;
                     length:DWord):TColor; overload;
function RSMixColorsRGBNorm(Colors:Pointer;
                            Weights:Pointer; length:DWord):TColor; overload;
function RSMixColorsRGBNorm(Colors:Pointer; step:Integer;
                            Weights:Pointer; length:DWord):TColor; overload;
function RSMixColorsNorm(Colors:Pointer;
                         Weights:Pointer; length:DWord):TColor; overload;
function RSMixColorsRGBNorm(const Colors:array of integer;
                            const Weights:array of DWord):TColor; overload;
function RSMixColorsNorm(const Colors:array of TColor;
                         const Weights:array of DWord):TColor; overload;
procedure RSMixPicColor32(MixTo,MixPic:Tbitmap; Color:TColor;
                          Weight1,Weight2:DWord);
procedure RSMixPics(MixTo, Mix1, Mix2:Tbitmap; Weight1,Weight2:DWord);

function RSGrayscale(Bmp:TBitmap; Dest:TBitmap=nil):TBitmap;
//procedure RSGrayscale(Bmp:TBitmap);
procedure RSGrayscaleSpec(Bmp:TBitmap; Light, Dark:TColor);

procedure RSDrawMonoBmp(ACanvas:TCanvas; Bmp:TBitmap; Color:TColor; x, y:int);
procedure RSDrawMask(ACanvas:TCanvas; Bmp:TBitmap; Color:TColor; x, y:int);
procedure RSDrawDisabled(ACanvas:TCanvas; Bmp:TBitmap; Color:TColor; x, y:int);

 // Tpansparency between 0 and 255
procedure RSTransparentRandom(Bmp:TBitmap; TransparentColor:TColor; Tpansparency:Byte); overload;
 // Tpansparency is grayscale bitmap made using RSGrayscale
procedure RSTransparentRandom(Bmp:TBitmap; TransparentColor:TColor; Tpansparency:TBitmap); overload;
procedure RSTransparentFixed(Bmp:TBitmap; TransparentColor:TColor; Step:int=1);

procedure RSChangeGrayPic(Bmp:TBitmap; Add:int); overload;

procedure RSGradientV(c:TCanvas; const Rect:TRect; UpCl,DnCl:TColor);
procedure RSGradientH(c:TCanvas; const Rect:TRect; LeftCl,RightCl:TColor);
procedure RSGradientV32(bmp:TBitmap; Rect:TRect; UpCl,DnCl:TColor); deprecated;
procedure RSGradientH32(bmp:TBitmap; Rect:TRect; LeftCl,RightCl:TColor); deprecated;

const RSsr90=1; RSsr180=2; RSsr270=3; RSsrHFlip=4;
      RSsrVFlip=4+RSsr180;

function RSSimpleRotate32(Source:TBitmap; r:TRect; RSsrValue:integer):TBitmap; overload;
function RSSimpleRotate32(Source:TBitmap; RSsrValue:integer):TBitmap; overload;

type
  TRSFourIntArray = array[0..3] of Integer;
  TRSTransformColorProc = procedure(var per, col: TRSFourIntArray;
    AllP: Integer; a: PLongint) of object;

// Bylinear
function RSTransformSmoothProc: TRSTransformColorProc;
// Finds the color closest to bylinear among the 4 colors, then mixes in bylinear color with Mix parameter
function RSTransformSmartProc(Mix: Integer = 0): TRSTransformColorProc;
// Mixes nearest neighbour with bylinear color with Mix parameter (0 - full nearest, 255 - full bylinear)
function RSTransformSmartProc2(Mix: Integer = 0): TRSTransformColorProc;


function RSXForm(scale: ext = 1): TRSXForm; overload;
function RSXForm(scaleX, scaleY: ext; rotate: ext = 0): TRSXForm; overload;

function RSTransformEnhancer(ISigma: Double = 1.9; MidShift: Double = 0.5;
   MainShift: Double = 1): TRSTransformEnhancer;

function RSPrepareTransform32(var Area: TRSAreaTransform;
   var wd, hd: int; ACenterInDest: Boolean = true): TRSSmoothTransformProc;

function RSTransform32(Source: TBitmap; Area: TRSAreaTransform;
           NoCl: TColor; PreserveNoCl: Boolean; sr: TRect;
           ColorProc: TRSTransformColorProc = nil;
           CenterInDest: Boolean = true;
           Enhance: TRSTransformEnhanceProc = nil): TBitmap; overload;
function RSTransform32(Source: TBitmap; const Area: TRSAreaTransform;
           NoCl: TColor; PreserveNoCl: Boolean;
           ColorProc: TRSTransformColorProc = nil;
           CenterInDest: Boolean = true;
           Enhance: TRSTransformEnhanceProc = nil): TBitmap; overload;
function RSTransform32(Source:TBitmap; const XForm: TRSXForm;
           NoCl:TColor; PreserveNoCl:Boolean; sr:TRect; CutRect:boolean;
           ColorProc:TRSTransformColorProc = nil;
           Enhance: TRSTransformEnhanceProc = nil):TBitmap; overload;
function RSTransform32(Source:TBitmap; const XForm: TRSXForm;
           NoCl:TColor; PreserveNoCl:Boolean;
           ColorProc: TRSTransformColorProc = nil;
           Enhance: TRSTransformEnhanceProc = nil): TBitmap; overload;

function RSAnyTransform32(Source:TBitmap; proc:TRSTransformProc;
           Width, Height:integer; NoCl:TColor; ClipRect:TRect):TBitmap; overload;
function RSAnyTransform32(Source:TBitmap; proc:TRSTransformProc;
           Width, Height:integer; NoCl:TColor):TBitmap; overload;

function RSAnyTransform32(Source:TBitmap; proc:TRSSmoothTransformProc;
           Width, Height:integer; NoCl:TColor; PreserveNoCl:Boolean;
           ClipRect:TRect; ColorProc: TRSTransformColorProc = nil;
           Enhance: TRSTransformEnhanceProc = nil):TBitmap; overload;
function RSAnyTransform32(Source:TBitmap; proc:TRSSmoothTransformProc;
           Width, Height:integer; NoCl:TColor; PreserveNoCl:Boolean;
           ColorProc: TRSTransformColorProc = nil;
           Enhance: TRSTransformEnhanceProc = nil):TBitmap; overload;

type
  TRSVectorGlyphLine = array[0..3] of Double; // TopX, Top, BottomX, Bottom
           
// Lines must be ordered from left to right. Horizontal lines are ignored.
procedure RSDrawVectorGlyph(Canvas: TCanvas; const lines: array of TRSVectorGlyphLine;
   AX, AY: ext; ScaleX: ext = 1; ScaleY: ext = Infinity);

{
type TRSBlendProc = function(Ratio, Pos, Param:integer):real;

function RSBlendProcSimple(Ratio, Pos, Param:integer):real;

function RSBlendProcGauss(Ratio, Pos, Param:integer):real;

function RSBlend(Source, Dest:TBitmap; XRatio:integer;
           YRatio:integer=-1; BlendProc:TRSBlendProc=nil;
           ProcParam:integer=3):Boolean;
}

resourcestring
  SRSZeroDet = 'The determinant is zero';

implementation

const
  Delta = 1e-8;

function Point(X, Y: Integer): TPoint; {$IFDEF D2005}inline;{$ENDIF}
begin
  Result.X := X;
  Result.Y := Y;
end;

{ TRSXForm }

function TRSXForm.TryInverse:boolean;
var d,x:Extended;
begin
  d:=eM11*eM22-eM21*eM12;
  Result:=d<>0;
  if not result then exit;
  d:=1/d;
  x:=d*eM11;
  eM11:=d*eM22;
  eM22:=x;
  d:=-d;
  eM12:=d*eM12;
  eM21:=d*eM21;
end;

function TRSXForm.TryInverse(var dest:TRSXForm):boolean;
var d:Extended;
begin
  d:=eM11*eM22-eM21*eM12;
  Result:=d<>0;
  if not result then exit;
  d:=1/d;
  dest.eM11:=d*eM22;
  dest.eM22:=d*eM11;
  d:=-d;
  dest.eM12:=d*eM12;
  dest.eM21:=d*eM21;
end;

procedure TRSXForm.Inverse;
var d,x:Extended;
begin
  d:=eM11*eM22-eM21*eM12;
  if d=0 then raise Exception.Create(SRSZeroDet);
  d:=1/d;
  x:=d*eM11;
  eM11:=eM22*d;
  eM22:=x;
  d:=-d;
  eM12:=d*eM12;
  eM21:=d*eM21;
end;

procedure TRSXForm.Inverse(var dest:TRSXForm);
var d:Extended;
begin
  d:=eM11*eM22-eM21*eM12;
  if d=0 then raise Exception.Create(SRSZeroDet);
  d:=1/d;
  dest.eM11:=d*eM22;
  dest.eM22:=d*eM11;
  d:=-d;
  dest.eM12:=d*eM12;
  dest.eM21:=d*eM21;
end;

procedure TRSXForm.SetE;
begin
  eM11:=1;
  eM22:=1;
  eM12:=0;
  eM21:=0;
end;

procedure TRSXForm.SetRotate(const angle: Double);
begin
  eM11:= cos(angle);
  eM22:= eM11;
  eM21:= sin(angle);
  eM12:= -eM21;
end;

procedure TRSXForm.SetScale(const x,y: Double);
begin
  eM11:=x;
  eM12:=0;
  eM21:=0;
  eM22:=y;
end;

procedure TRSXForm.SetTransform(O1, X1, Y1, O2, X2, Y2: TRSFloatPoint);
var
  a1, a2:TRSXForm;
begin
  with a1 do
  begin
    eM11:=x1.X-o1.X;
    eM21:=o1.Y-x1.Y;
    eM12:=y1.X-o1.X;
    eM22:=o1.Y-y1.Y;
  end;
  with a2 do
  begin
    eM11:=x2.X-o2.X;
    eM21:=o2.Y-x2.Y;
    eM12:=y2.X-o2.X;
    eM22:=o2.Y-y2.Y;
  end;
  a1.Inverse;
  self:=a1.Mul(a2);
end;

procedure TRSXForm.SetTransform(O1,X1,Y1,O2,X2,Y2:TPoint);
var
  a1, a2:TRSXForm;
begin
  with a1 do
  begin
    eM11:=x1.X-o1.X;
    eM21:=o1.Y-x1.Y;
    eM12:=y1.X-o1.X;
    eM22:=o1.Y-y1.Y;
  end;
  with a2 do
  begin
    eM11:=x2.X-o2.X;
    eM21:=o2.Y-x2.Y;
    eM12:=y2.X-o2.X;
    eM22:=o2.Y-y2.Y;
  end;
  a1.Inverse;
//  self:=a2.Mul(a1);
  self:=a1.Mul(a2);
end;

procedure TRSXForm.Rotate(const angle: Double);
var a:TRSXForm;
begin
  a.SetRotate(angle);
  self:= a.Mul(self);
end;

procedure TRSXForm.Scale(const x,y: Double);
begin
  eM11:= eM11*x;
  eM12:= eM12*x;
  eM21:= eM21*y;
  eM22:= eM22*y;
end;

function TRSXForm.Mul(const v:TRSXForm):TRSXForm;
begin
  Result.eM11:= eM11*v.eM11+eM12*v.eM21;
  Result.eM12:= eM11*v.eM12+eM12*v.eM22;
  Result.eM21:= eM21*v.eM11+eM22*v.eM21;
  Result.eM22:= eM21*v.eM12+eM22*v.eM22;
end;

{ TRSAreaTransform }

procedure TRSAreaTransform.CenterInDest(w, h: ext);
var
  v: ext;
begin
  v:= (Hi.X - Lo.X - w)/2;
  Lo.X:= Lo.X + v;
  Hi.X:= Hi.X - v;
  v:= (Hi.Y - Lo.Y - h)/2;
  Lo.Y:= Lo.Y + v;
  Hi.Y:= Hi.Y - v;
end;

procedure TRSAreaTransform.CenterInDest;
begin
  CenterInDest(GetDestWidth, GetDestHeight);
end;

function TRSAreaTransform.GetDestHeight: int;
begin
  Result:= Ceil(Hi.Y - Lo.Y - Delta);
end;

function TRSAreaTransform.GetDestWidth: int;
begin
  Result:= Ceil(Hi.X - Lo.X - Delta);
end;

procedure TRSAreaTransform.IncludeSourcePoint(x, y: ext);
var
  v: ext;
begin
  v:= x*Form.eM11 + y*Form.eM12;
  SetMin(Lo.X, v);
  SetMax(Hi.X, v);
  v:= x*Form.eM21 + y*Form.eM22;
  SetMin(Lo.Y, v);
  SetMax(Hi.Y, v);
end;

procedure TRSAreaTransform.IncludeSourceRect(r: TRect);
begin
  IncludeSourcePoint(r.Left, r.Top);
  IncludeSourcePoint(r.Left, r.Bottom);
  IncludeSourcePoint(r.Right, r.Top);
  IncludeSourcePoint(r.Right, r.Bottom);
end;

function TRSAreaTransform.MapSourcePixel(x, y: int): TPoint;
begin
  Result.X:= Floor((x + 0.5)*Form.eM11 + (y + 0.5)*Form.eM12 - Lo.X - Delta);
  Result.Y:= Floor((x + 0.5)*Form.eM21 + (y + 0.5)*Form.eM22 - Lo.Y - Delta);
end;

function TRSAreaTransform.MapSourcePoint(x, y: ext): TRSFloatPoint;
begin
  Result.X:= x*Form.eM11 + y*Form.eM12 - Lo.X;
  Result.Y:= x*Form.eM21 + y*Form.eM22 - Lo.Y;
end;

procedure TRSAreaTransform.SetEmpty;
begin
  Lo.X:= Infinity;
  Lo.Y:= Infinity;
  Hi.X:= -Infinity;
  Hi.Y:= -Infinity;
end;

procedure TRSAreaTransform.SetSourceRect(r: TRect);
begin
  SetEmpty;
  IncludeSourceRect(r);
end;

{ TRSEnhancedTransform }

// errf approximation with precision 1.5E-7
// http://kaktusenok.blogspot.ru/2011/09/erf-cc.html
function errf(x: ext): ext;
var
  y: ext;
begin
  y:= 1.0 / ( 1.0 + 0.3275911 * abs(x));
  Result:= 1 - (((((
        + 1.061405429  * y
        - 1.453152027) * y
        + 1.421413741) * y
        - 0.284496736) * y
        + 0.254829592) * y)
        * exp (-x * x);
  if x < 0 then
    Result:= -Result;
end;

function ResampleCoreInt(mid, x1, x2, scale, isigma: ext): ext;
begin
  x1:= (x1 - mid)*scale;
  x2:= (x2 - mid)*scale;
  // domain from -1 to +1
  // Let's use gaussian with sigma = 2 at x = 1 (so sigma = 1/2)
  // Graph: https://www.graphsketch.com/?eqn1_color=1&eqn1_eqn=8*(exp(-(2.0*x)%5E2)%20-%20exp(-(2.0)%5E2))%2F(exp(-(2.0*x)%5E2)%2Bexp(-(2.0*(x-1))%5E2)%20-%20exp(-(2.0)%5E2)*2)%2B0.5&eqn2_color=2&eqn2_eqn=&eqn3_color=3&eqn3_eqn=&eqn4_color=4&eqn4_eqn=&eqn5_color=5&eqn5_eqn=&eqn6_color=6&eqn6_eqn=&x_min=-0.5&x_max=1.5&y_min=0.5&y_max=8.5&x_tick=0.2&y_tick=1&x_label_freq=5&y_label_freq=1&do_grid=0&do_grid=1&bold_labeled_lines=0&bold_labeled_lines=1&line_width=4&image_w=850&image_h=525
  // x5 resample check: https://www.graphsketch.com/parametric.php?mode=para&eqn1_color=1&eqn1_x=t*6%2F5&eqn1_y=8*%28exp%28-%282.0*t%29%5E2%29+-+exp%28-%282.0%29%5E2%29%29%2F%28exp%28-%282.0*t%29%5E2%29%2Bexp%28-%282.0*%28t-1%29%29%5E2%29+-+exp%28-%282.0%29%5E2%29*2%29%2B0.5&eqn2_color=2&eqn2_x=&eqn2_y=&eqn3_color=3&eqn3_x=&eqn3_y=&x_min=-0.5&x_max=1.5&y_min=0.5&y_max=8.5&t_min=0&t_max=1&x_tick=0.2&y_tick=1&x_label_freq=6&y_label_freq=1&do_grid=0&do_grid=1&bold_labeled_lines=0&bold_labeled_lines=1&line_width=4&image_w=850&image_h=525
  Result:= errf(x2*isigma) - errf(x1*isigma) - (x2 - x1)*exp(-isigma*isigma);
end;

type
  TRSEnhancedTransformProc = class
    function Proc(p: TPoint; Source, Dest: TBitmap): TRSFloatPoint;
  end;

{ TRSEnhancedTransformProc }

function TRSEnhancedTransformProc.Proc(p: TPoint; Source,
  Dest: TBitmap): TRSFloatPoint;
begin
  with PRSEnhancedTransform(self)^ do
    Result:= Points[p.Y*Width + p.X];
end;

function TRSEnhancedTransform.Get: TRSSmoothTransformProc;
begin
  Result:= TRSEnhancedTransformProc(@self).Proc;
end;

function TRSEnhancedTransform.Init(BmpSrc, BmpDest: TBitmap; const sr: TRect;
  Proc: TRSSmoothTransformProc; ISigma, MidShift, MainShift: ext): TRSSmoothTransformProc;
type
  PSrcRec = ^TSrcRec;
  PDestRec = ^TDestRec;
  TSrcRec = record
    SrcX, SrcY: int;
    DestRec: PDestRec;
    Weight: Double;
  end;
  TDestRec = record
    Mapped: TRSFloatPoint;
    rec: PSrcRec;
  end;
  
var
  SrcInfo: array of TSrcRec;
  DestInfo: array of TDestRec;
  SrcW: int;
  MidPoints: array[0..1, 0..1] of TRSFloatPoint; // indexed as (X,Y)
  EmpMul, EmpBase: ext;

  // The point is between 4 pixels. We shift center of each pixel towards
  // its main point, then project back to source coordinates.
  // This turns a simple (0,0)-(1,0)-(0,1)-(1,1) square into a quadrilateral.
  // X and Y of each point get changed by up to 0.5, so it's not concave.
  procedure Quadrilateral(src: PSrcRec; dx, dy: int; main: Boolean);
  var
    x, y, shift: ext;
    ix, iy: int;
  begin
//    Assert(abs(dx) <= 1);
//    Assert(abs(dy) <= 1);
    for iy:= 0 to 1 do
    begin
      for ix:= 0 to 1 do
      begin
        x:= ix;
        y:= iy;
//        if UintPtr(src) > UintPtr(@SrcInfo[high(SrcInfo)]) then
//          zD;
//        Assert(UintPtr(src) >= UintPtr(@SrcInfo[0]));
//        Assert(UintPtr(src) <= UintPtr(@SrcInfo[high(SrcInfo)]));
//        Assert(UintPtr(@DestInfo[src^.DestP.Y*Width + src^.DestP.X]) >= UintPtr(@DestInfo[0]));
//        Assert(UintPtr(@DestInfo[src^.DestP.Y*Width + src^.DestP.X]) <= UintPtr(@DestInfo[high(DestInfo)]));
        if src^.Weight > 0 then // needs shifting
          with src^, DestRec^ do
          begin
            shift:= MidShift;
            if main and (x = 0) and (y = 0) then
              shift:= MainShift;
            x:= x + shift*(Mapped.X - SrcX)*dx;
            y:= y + shift*(Mapped.Y - SrcY)*dy;
          end;
        MidPoints[ix, iy].X:= x;
        MidPoints[ix, iy].Y:= y;
        inc(src, dx);
      end;
      inc(src, dy*SrcW - dx*2);
    end;
  end;

  procedure FindCoordinatesInQuadrilateral(var x, y: ext);
  var
    a1, a2: ext;
  begin
    // - First, straighten vertical lines:

    // Find dx/dy of vertical lines
    a1:= MidPoints[0,1].Y - MidPoints[0,0].Y;
    if a1 <> 0 then
      a1:= (MidPoints[0,1].X - MidPoints[0,0].X)/a1;

    a2:= MidPoints[1,1].Y - MidPoints[1,0].Y;
    if a2 <> 0 then
      a2:= (MidPoints[1,1].X - MidPoints[1,0].X)/a2;

    // Find left and right line intersections with Y = y
    a1:= a1*(y - MidPoints[0,0].Y) + MidPoints[0,0].X;
    a2:= a2*(y - MidPoints[1,0].Y) + MidPoints[1,0].X;

    // Find where X = x lies within it
    if a1 <> a2 then
      x:= (x - a1)/(a2 - a1)
    else
      x:= 0;

    // - After this we arrive at trapezoid (0,?)-(1,?)-(0,?)-(1,?).
    // - Now we streighten horizontal lines:

    // Find dy/dx of horizontal lines
    a1:= MidPoints[1,0].Y - MidPoints[0,0].Y;
    a2:= MidPoints[1,1].Y - MidPoints[0,1].Y;

    // Find top and bottom line intersections with X = x
    a1:= a1*x + MidPoints[0,0].Y;
    a2:= a2*x + MidPoints[0,1].Y;

    // Find where Y = y lies within it
    if a1 <> a2 then
      y:= (y - a1)/(a2 - a1)
    else
      y:= 0;

    SetMax(x, 0);
    SetMax(y, 0);
  end;

  function Emphasize(x: ext): ext;
  var
    x2: ext;
  begin
    Result:= x;
    if ISigma <= 0 then  exit;
    // use normalized sum of 2 gaussians at X = 0 and X = 1 
    x2:= 1 - x;
    x:= Exp(EmpMul*x*x) - EmpBase;
    x2:= Exp(EmpMul*x2*x2) - EmpBase;
    Result:= x2/(x + x2);
  end;

var
  p: TPoint;
  dest: ^TDestRec;
  src: PSrcRec;
  v, fx, fy: ext;
  x, y, i, sx, sy, dx, dy: int;
begin
  Width:= BmpDest.Width;
  Height:= BmpDest.Height;
  SetLength(Points, Width*Height);
  SetLength(DestInfo, Width*Height);
  SrcW:= sr.Right - sr.Left;
  SetLength(SrcInfo, SrcW*(sr.Bottom - sr.Top));
  EmpMul:= -ISigma*ISigma/2;
  EmpBase:= Exp(EmpMul);

  // get all base points, find best match for each source pixel
  i:= -1;
  for y:= 0 to Height - 1 do
  begin
    p.Y:= y;
    for x:= 0 to Width - 1 do
    begin
      p.X:= x;
      inc(i);
      with DestInfo[i] do
      begin
        Mapped:= Proc(p, BmpSrc, BmpDest);
        sx:= Round(Mapped.X);
        if (sx < sr.Left) or (sx >= sr.Right) then  continue;
        sy:= Round(Mapped.Y);
        if (sy < sr.Top) or (sy >= sr.Bottom) then  continue;
        v:= (1 - abs(Mapped.X - sx))*(1 - abs(Mapped.Y - sy));
        rec:= @SrcInfo[(sy - sr.Top)*SrcW + sx - sr.Left];
        with rec^ do
        begin
          if v <= Weight then  continue;
          Weight:= v;
          DestRec:= @DestInfo[i];
          SrcX:= sx;
          SrcY:= sy;
        end;
      end;
    end;
  end;

  // find new points
  i:= -1;
  for y:= 0 to Height - 1 do
  begin
    for x:= 0 to Width - 1 do
    begin
      inc(i);
      with DestInfo[i] do
      begin
        src:= rec;
        if src = nil then
        begin
          Points[i].X:= Mapped.X;
          Points[i].Y:= Mapped.Y;
          continue;
        end;
        sx:= src.SrcX;
        sy:= src.SrcY;
        // main point? Keep its full original color
        if (src.DestRec = @DestInfo[i]) and (MainShift = 1) then
        begin
          Points[i].X:= sx;
          Points[i].Y:= sy;
          continue;
        end;
        fx:= abs(Mapped.X - sx);
        fy:= abs(Mapped.Y - sy);
        dx:= Sign(Mapped.X - sx);
        dy:= Sign(Mapped.Y - sy);
        Quadrilateral(src, IntoRange(dx, sr.Left - sx, sr.Right - sx - 1),
                           IntoRange(dy, sr.Top - sy, sr.Bottom - sy - 1),
                           src.DestRec = @DestInfo[i]);
        FindCoordinatesInQuadrilateral(fx, fy);
        Points[i].X:= sx + Emphasize(fx)*dx;
        Points[i].Y:= sy + Emphasize(fy)*dy;
      end;
    end;
  end;
  Result:= Get();
end;


type
  TRSTransformEnhancerGet = class
  public
    function Enhance(Src, Dest: TBitmap; const ClipRect: TRect;
       Proc: TRSSmoothTransformProc): TRSSmoothTransformProc;
  end;

{ TRSTransformEnhancerGet }

function TRSTransformEnhancerGet.Enhance(Src, Dest: TBitmap;
  const ClipRect: TRect; Proc: TRSSmoothTransformProc): TRSSmoothTransformProc;
begin
  with PRSTransformEnhancer(self)^, Enhanced do
  begin
    if Reuse and (Width = Dest.Width) and (Height = Dest.Height) then
      Result:= Enhanced.Get()
    else
      Result:= Enhanced.Init(Src, Dest, ClipRect, Proc, ISigma, MidShift, MainShift);
  end;
end;

{ TRSTransformEnhancer }

function TRSTransformEnhancer.Get: TRSTransformEnhanceProc;
begin
  Result:= TRSTransformEnhancerGet(@self).Enhance;
end;


{ functions }

function RSLoadPic(const Path:string; APixelFormat:TPixelFormat=pfCustom; Pic:TBitmap=nil):TBitmap;
var p:TPicture;
begin
  p:= nil;
  try
    if not SameText(ExtractFileExt(Path), '.bmp') then
    begin
      p:= TPicture.Create;
      p.LoadFromFile(Path);
      if Pic=nil then
        Result:=TBitmap.Create
      else
        Result:=Pic;
    end else
      Result:= RSLoadBitmap(Path, Pic);

    with Result do
      try
        if p<>nil then
        begin
          Assign(p.Graphic);
          {Width:= p.Width;
          Height:= p.Height;
          Canvas.Draw(0, 0, p.Graphic);}
        end;
        HandleType:= bmDIB;
        if APixelFormat <> pfCustom then
          PixelFormat:= APixelFormat;
      except
        if Pic = nil then
          Free;
        raise;
      end;
  finally
    p.Free;
  end;
end;


// mosaic!
{function SqDifference(cl1,cl2:int):int;
begin
  Result:= (sqr(cl1 and $ff - cl2 and $ff)*213 +
           sqr((cl1 and $ff00 - cl2 and $ff00) shr 8)*715 +
           sqr((cl1 and $ff0000 - cl2 and $ff0000) shr 16)*72) shr 8;
end;}

{function SqDifference(cl1,cl2:int):int;
begin
  Result:= sqr(cl1 and $ff - cl2 and $ff)*213 +
           sqr((cl1 and $ff00 - cl2 and $ff00) div $100)*715 +
           sqr((cl1 and $ff0000 - cl2 and $ff0000) div $10000)*72;
end;}

function SqDifference(cl1,cl2:int):int;
begin
  Result:= abs(cl1 and $ff - cl2 and $ff)*299*$100 +
           abs(cl1 and $ff00 - cl2 and $ff00)*587 +
           abs(cl1 and $ff0000 - cl2 and $ff0000)*114 shr 8;
end;


type
  PBitmapHeader = ^TBitmapHeader;
  TBitmapHeader = record
    BF: TBitmapFileHeader;
    Info: TBitmapInfoHeader;
  end;

// assumes TBitmapHeader is already read
procedure ReadRLE(a: TMemoryStream; Stream:TStream);
var
  p, pline, p0, p1, buf, buf0, buf1: PChar;
  sz, w, wh, n, m: int;
begin
  with PBitmapHeader(a.Memory)^ do
  begin
    w:= (Info.biWidth + 3) and not 3;
    wh:= w*abs(Info.biHeight);
    a.Size:= BF.bfOffBits + uint(wh);
  end;
  with PBitmapHeader(a.Memory)^ do
  begin
    Stream.Read((PChar(a.Memory) + SizeOf(TBitmapHeader))^, BF.bfOffBits - SizeOf(TBitmapHeader));
    sz:= BF.bfSize - BF.bfOffBits;
    GetMem(buf0, sz);
    try
      buf1:= buf0 + Stream.Read(buf0^, sz);
      Info.biCompression:= BI_RGB;
      Info.biSizeImage:= wh;
      BF.bfSize:= BF.bfOffBits + uint(wh);
      buf:= buf0;
      p:= PChar(a.Memory) + BF.bfOffBits;
      if Info.biHeight < 0 then  // not allowed by MSDN, but PhotoShop does this
      begin
        p:= p + wh - w;
        w:= -w;
        Info.biHeight:= -Info.biHeight;
      end;
      pline:= p;    // line start
      p0:= p;       // beginning
      p1:= p + wh;  // end
      FillMemory(p, wh, 0);
      while (buf + 1 < buf1) and (p <= p1) and (p >= p0) do
      begin
        n:= ord(buf^);
        m:= ord((buf + 1)^);
        inc(buf, 2);
        if n <> 0 then  // repeat n times
        begin
          FillMemory(p, min(n, p1 - p), m);
        end else
          case m of
            0: // end of line
            begin
              inc(pline, w);
              n:= pline - p;
            end;
            1: // end of bitmap
              break;
            2: // offset X, Y
            begin
              if buf + 1 >= buf1 then
                break;
              m:= ord((buf + 1)^)*w;
              n:= ord(buf^) + m;
              inc(pline, m);
              inc(buf, 2);
            end;
            // copy n bytes
            else begin
              n:= m;
              CopyMemory(p, buf, min(n, min(p1 - p, buf1 - buf)));
              inc(buf, (n + 1) and not 1);  // word boundary
            end;
          end;
          
        inc(p, n);
      end;
    finally
      FreeMem(buf0, sz);
    end;
  end;
end;

// assumes TBitmapHeader is already read
procedure ReadNegative(a: TMemoryStream; Stream:TStream);
var
  p: PChar;
  i, w, wh: int;
begin
  with PBitmapHeader(a.Memory)^ do
  begin
    Info.biHeight:= -Info.biHeight;
    w:= ((Info.biBitCount * Info.biWidth + 31) and not 31) div 8;
    wh:= w*Info.biHeight;
    BF.bfSize:= BF.bfOffBits + uint(wh);
    Info.biSizeImage:= wh;
    a.Size:= BF.bfSize;
  end;
  with PBitmapHeader(a.Memory)^ do
  begin
    Stream.Read((PChar(a.Memory) + SizeOf(TBitmapHeader))^, BF.bfOffBits - SizeOf(TBitmapHeader));
    p:= PChar(a.Memory) + BF.bfOffBits;
    for i := Info.biHeight - 1 downto 0 do
      Stream.ReadBuffer((p + w*i)^, w);
  end;
end;

 // Solves these issues (present in D2006):
 // 1) RLE8 bitmaps support is broken in TBitmap.LoadFromStream
 //    e.g. bitmaps saved in PhotoShop have black pixels on the right of each line
 //    (RLE4 may be broken as well, but who cares)
 // 2) ScanLine[] returns scanlines in reverse order for bitmaps with Height < 0.
 //    Dormant() flips such bitmaps vertically.
 // 3) Some incorrectly made bitmaps are loaded by graphical editors,
 //    but not loaded correctly by Delphi.
 // Not yet fixed: bfOffBits ignored
function RSLoadBitmap(Stream:TStream; Bmp:TBitmap = nil):TBitmap; overload;
const
  sz = SizeOf(TBitmapHeader);
var
  a: TStream;
  i, comp: int;
begin
  Result:= nil;
  a:= TMemoryStream.Create;
  try
    a.Size:= sz;
    i:= Stream.Read(TMemoryStream(a).Memory^, sz);
    with PBitmapHeader(TMemoryStream(a).Memory)^, Info do
      if (i = sz) and (biSize >= 40) then
      begin
        comp:= biCompression;
        {if BF.bfOffBits - biSize <> sz then
        begin
          if biSize <> 40 then
          begin
            inc(i, int(biSize) - 40);
            a.Size:= i;
            Stream.Read((PChar(TMemoryStream(a).Memory) + sz)^, i - sz);
          end;
          Stream.Seek(int64(BF.bfOffBits) - biSize + 40 - sz, soCurrent);
        end;
        BF.bfOffBits:= i;}
      end else
      begin
        comp:= 100;
        a.Size:= i;
      end;

    with PBitmapHeader(TMemoryStream(a).Memory)^, Info do
    begin
      if (comp in [BI_RGB, BI_BITFIELDS]) and (biHeight < 0) then
        ReadNegative(TMemoryStream(a), Stream)
      else if (comp = BI_RLE8) and (biBitCount = 8) then
        ReadRLE(TMemoryStream(a), Stream)
      else begin
        if comp in [BI_RGB, BI_BITFIELDS] then
          biSizeImage:= biHeight*(((biBitCount * biWidth + 31) and not 31) div 8);
        a:= TRSReplaceStream.Create(Stream, a, false, true, Stream.Position - i);
        a.Seek(int64(-i), soFromCurrent);
      end;
    end;
    Result:= Bmp;
    if Result = nil then
      Result:= TBitmap.Create;
    Result.LoadFromStream(a);
    Bmp:= Result; // Make Bmp not nil
  finally
    a.Free;
    if Bmp = nil then
      Result.Free;
  end;
end;

function RSLoadBitmap(const FileName:string; Bmp:TBitmap = nil):TBitmap; overload;
var Stream:TStream;
begin
  Stream:= TFileStream.Create(FileName, fmOpenRead);
  try
    Result:= RSLoadBitmap(Stream, Bmp);
  finally
    Stream.Free;
  end;
end;

 // Taken from QPix, made by Boris Novgorodov and Alexey Radionov
function RSGetPixelFormat(b:TBitmap):TPixelFormat;
var
  DS: TDibSection;
begin
  Result:= b.PixelFormat;
  if (Result<>pfCustom) or (b.HandleType = bmDDB) or
     (GetObject(b.Handle, SizeOf(DS), @DS) = 0) then  exit;
  with DS, dsBmih do
    case biBitCount of
      16:
        case biCompression of
          BI_RGB:
            Result:=pf15bit;
          BI_BITFIELDS:
          begin
            if dsBitFields[1] = $7E0 then
              Result:=pf16bit;
            if dsBitFields[1] = $3E0 then
              Result:=pf15bit;
          end;
        end;
      32:
        case biCompression of
          BI_RGB:
            Result:=pf32bit;
          BI_BITFIELDS:
            if dsBitFields[0] = $FF0000 then
              Result:=pf32bit;
        end;
    end;
end;

procedure DoBufBitmap(Buf:ptr; Bitmap:TBitmap; r:TRect; ToBuf:boolean);
var p:PByte; i,dy,w,w1,h:int;
begin
  w:=Bitmap.Width;
  h:=Bitmap.Height;
  if (w=0) or (h=0) or
     (r.Left>=w) or (r.Top>=h) or (r.Right<=0) or (r.Bottom<=0) then  exit;

  case RSGetPixelFormat(Bitmap) of
    pf8bit:  i:=1;
    pf24bit:  i:=3;
    pf32bit:  i:=4;
    pf15bit, pf16bit:  i:=2;
    else
    begin
      Assert(false);
      exit;
    end;
  end;
  w1:= (r.Right - r.Left)*i;

   // A part of frame may be outside the picture
  if r.Top<0 then
  begin
    dec(PByte(Buf), r.Top*w1);
    r.Top:=0;
  end;
  if r.Left<0 then
  begin
    dec(PByte(Buf), r.Left*i);
    r.Left:=0;
  end;
  if r.Right>w then  r.Right:=w;
  if r.Bottom>h then  r.Bottom:=h;

  p:=Bitmap.ScanLine[r.Top];
  inc(p, r.Left*i);
  dy:= (-w*i) and not 3;
  w:= (r.Right - r.Left)*i;
  h:= r.Bottom - r.Top;
  
  if ToBuf then
    for i:=h-1 downto 0 do
    begin
      Move(p^, Buf^, w);
      inc(p, dy);
      inc(PByte(Buf), w1);
    end
  else
    for i:=h-1 downto 0 do
    begin
      Move(Buf^, p^, w);
      inc(p, dy);
      inc(PByte(Buf), w1);
    end;
end;

procedure RSBufferToBitmap(Buf:ptr; Bitmap:TBitmap; const r:TRect); overload;
begin
  DoBufBitmap(Buf, Bitmap, r, false);
end;

procedure RSBitmapToBuffer(Buf:ptr; Bitmap:TBitmap; const r:TRect); overload;
begin
  DoBufBitmap(Buf, Bitmap, r, true);
end;

procedure RSBufferToBitmap(Buf:ptr; Bitmap:TBitmap); overload;
var
  r: TRect;
begin
  r.Left:= 0;
  r.Top:= 0;
  r.Right:= Bitmap.Width;
  r.Bottom:= Bitmap.Height;
  DoBufBitmap(Buf, Bitmap, r, false);
end;

procedure RSBitmapToBuffer(Buf:ptr; Bitmap:TBitmap); overload;
var
  r: TRect;
begin
  r.Left:= 0;
  r.Top:= 0;
  r.Right:= Bitmap.Width;
  r.Bottom:= Bitmap.Height;
  DoBufBitmap(Buf, Bitmap, r, true);
end;

function rsRGBtoHLS(c:TColor):TRSHLS;
const HLSUndef = 240*2 div 3; //HLSMax = 240
var i, j, k:integer;
Begin
  if c<0 then c:=GetSysColor(byte(c))
  else c:=c and $ffFFff;
  j:=c shr 16;      // B
  i:=byte(c shr 8); // G
  c:=byte(c);       // R
  if c<i then
    if j>=i then
    begin
      //Max:=j; (B)
      //Min:=c;
      // H := 4 + (R - G) / Del;
      // H := H / 6;
      k:=j-c;
      if k=0 then Result.Hue := HLSUndef
      else Result.Hue:=((c-i)*240 + (240*4+3)*k) div (6*k);
      i:=j+c;
    end else
    begin
      if j<=c then
      begin
        // Max:=i; (G)
        // Min:=j
        //  H := (G - B) / Del        //R = cMax
        //  H := 2 + (B - R) / Del    //G = cMax
        //  H := 4 + (R - G) / Del    //B = cMax
        //  H := H / 6;

        k:=i-j;
        if k=0 then Result.Hue := HLSUndef
        else Result.Hue:=((j-c)*240 + (240*2+3)*k) div (6*k);
        i:=i+j;
      end else
      begin
        // Max:=i; (G)
        // Min:=c;
        k:=i-c;
        if k=0 then Result.Hue := HLSUndef
        else Result.Hue:=((j-c)*240 + (240*2+3)*k) div (6*k);
        i:=i+c;
      end;
    end
  else
    if j<i then
    begin
      //Max:=c; (R)
      //Min:=j;
      //  H := (G - B) / Del        //R = cMax
      //  H := H / 6;

      k:=c-j;
      if k=0 then i := HLSUndef
      else i:=((i-j)*240 + 3*k) div (6*k);

      if i<0 then Result.Hue:=240+i
      else Result.Hue:=i;
      i:=c+j;
    end else
    begin
      if j>=c then
      begin
        // Max:=j; (B)
        // Min:=i;
        k:=j-i;
        if k=0 then Result.Hue := HLSUndef
        else Result.Hue:=((c-i)*240 + (240*4+3)*k) div (6*k);
        i:=j+i;
      end else
      begin
        // Max:=c; (R)
        // Min:=i;
        k:=c-i;
        if k=0 then j := HLSUndef
        else j:=((i-j)*240 + 3*k) div (6*k);

        if j<0 then Result.Hue:=240+j
        else Result.Hue:=j;
        i:=c+i;
      end;
    end;


  Result.Lum:= (i*240+255) div (2*255);

//        if (L <= 0.5) then
//          S := del / sum
//        else S := del / (2 - sum);

  if k = 0 then Result.Sat := 0
  else
    if (i <= 255) then
      Result.Sat := (k*(240*2)+i) div (i*2)
    else Result.Sat := (k*(240*2) + 2*255-i) div (4*255 - i*2);
end;

function rsHLStoRGB(const HLS:TRSHLS):TColor;
var
  M1, M2 : integer;

  function M3(const x: integer): integer;
  begin
    M3:=(40*255*M1 + x*(M2-M1)*255 + sqr(240)*20) div (sqr(240)*40);
  end;
begin
  if (HLS.Lum = 0) then
  begin
    Result:=0;
    exit;
  end;
  if (HLS.Sat = 0) then
  begin
    M1:=(HLS.Lum*255 + 120) div 240;
    Result:=M1 or (M1 shl 8) or (M1 shl 16);
    exit;
  end;
  
  if (HLS.Lum <= 120) then
    M2 := HLS.Lum*(HLS.Sat+240)
  else M2 := HLS.Lum*(240-HLS.Sat) + HLS.Sat*240;
  M1 := 2*240*HLS.Lum - M2;

  case HLS.Hue div 40 of
    0:begin
      Result:=(
        (M2*255 + sqr(240) div 2) div sqr(240)        ) or (
        M3(HLS.Hue)                              shl 8) or (
        (M1*255 + sqr(240) div 2) div sqr(240)   shl 16);
    end;
    1:begin
      Result:=(
        M3(40*2 - HLS.Hue)                            ) or (
        (M2*255 + sqr(240) div 2) div sqr(240)   shl 8) or (
        (M1*255 + sqr(240) div 2) div sqr(240)   shl 16);
    end;
    2:begin
      Result:=(
        (M1*255 + sqr(240) div 2) div sqr(240)        ) or (
        (M2*255 + sqr(240) div 2) div sqr(240)   shl 8) or (
        M3(HLS.Hue - 40*2)                       shl 16);
    end;
    3:begin
      Result:=(
        (M1*255 + sqr(240) div 2) div sqr(240)        ) or (
        M3(40*4 - HLS.Hue)                       shl 8) or (
        (M2*255 + sqr(240) div 2) div sqr(240)   shl 16);
    end;
    4:begin
      Result:=(
        M3(HLS.Hue - 40*4)                            ) or (
        (M1*255 + sqr(240) div 2) div sqr(240)   shl 8) or (
        (M2*255 + sqr(240) div 2) div sqr(240)   shl 16);
    end;
    5:begin
      Result:=(
        (M2*255 + sqr(240) div 2) div sqr(240)        ) or (
        (M1*255 + sqr(240) div 2) div sqr(240)   shl 8) or (
        M3(40*6 - HLS.Hue)                       shl 16);
    end;
    else Result:=0;
  end;
end;

function RSAdjustLum(c:TColor; ChangeBy:smallint):TColor;
var a:TRSHLS; i:integer;
begin
  a:=rsRGBtoHLS(c);
  i:=a.Lum+ChangeBy;
  if i<0 then i:=0
  else if i>240 then i:=240;
  a.Lum:=i;
  Result:=rsHLStoRGB(a);
end;

function RSGetIntensity(c:TColor):integer;
asm
  test eax, eax
  jnl @0
  and eax, $ff
  call GetSysColor
@0:
  mov ecx, eax
  shr ecx, 16
  and ecx, $ff
  cmp al, cl
  jna @1
  xchg al, cl
@1:
  cmp ah, al
  jnb @2
  xchg ah, al
@2:
  cmp ah, cl
  jna @3
  xchg ah, cl
@3:
  and eax, $ff
  add eax, ecx
  shr eax, 1
end;

function RSAdjustIntensity(c:TColor; ChangeBy:smallInt):TColor;
var i,j,k:integer;
begin
  if c<0 then c:=GetSysColor(byte(c));
  i:=byte(c shr 8);
  j:=c shr 16;
  // j = min + max
  // k = max
  if byte(c)<i then
    if j>=i then
    begin
      k:=j;
      j:=j+byte(c);
    end else
      if j<=byte(c) then
      begin
        k:=i;
        j:=j+i;
      end else
      begin
        k:=byte(i);
        j:=byte(c)+i;
      end
  else
    if j<=i then
    begin
      k:=byte(c);
      j:=j+byte(c);
    end else
      if j>=byte(c) then
      begin
        k:=j;
        j:=j+i;
      end else
      begin
        k:=byte(c);
        j:=byte(c)+i;
      end;
      
  //j:=byte(c) + byte(c shr 8) + byte(c shr 16);
  if j=0 then
  begin
    if ChangeBy>0 then
      Result:=ChangeBy shl 16 + ChangeBy shl 8 + ChangeBy
    else Result:=clBlack;
  end else
  begin
//    if ChangeBy>255-k then ChangeBy:=255-k;
    j:=256+ChangeBy*(256*2) div j;
    if k*j>$ffff then j:=$ffff div k;
    if j<=0 then Result:=clBlack
    else
      Result:= integer(
        (DWord(j)*(DWord(c) and $ff00) shr 16 shl 8) or
        (DWord(j)*(DWord(c) and $ff00ff) and $ff00ff00 shr 8));
  end;
end;

function RSSwapColor(c:TColor):TColor;
asm
  bswap eax
  shr eax, 8
end;

{
function RSColorDifference(cl1,cl2:TColor):TColor;
begin
end;
}

{
// for 16-bit color
function test(c1, c2, p1:int):int;
var p2:int;
begin
  p2:= 64 - p1;
  inc(p1);
  Result:= ((((c1 and 63519)*p1 + (c2 and 63519)*p2) div 64) and 63519) + ((((c1 and 2016)*p1 + (c2 and 2016)*p2) div 64) and 2016);
end;
}

function RSMixColors(Color1, Color2:integer; Weight1:DWord):TColor; overload;
var
  w2:DWord;
begin
  if Color1 < 0 then  Color1:=GetSysColor(Byte(Color1));
  if Color2 < 0 then  Color2:=GetSysColor(Byte(Color2));
  w2:= 256 - Weight1;
  inc(Weight1);
  DWord(Result):=
    (Weight1*DWord(Color1 and $ff00) + w2*DWord(Color2 and $ff00)) shr 16 shl 8 or
    (Weight1*DWord(Color1 and $ff00ff) + w2*DWord(Color2 and $ff00ff)) and $ff00ff00 shr 8;
end;

function RSMixColorsRGB(Color1, Color2:integer; Weight1:DWord):TColor; overload;
var
  w2:DWord;
begin
  w2:= 256 - Weight1;
  inc(Weight1);
  DWord(Result):=
    (Weight1*DWord(Color1 and $ff00) + w2*DWord(Color2 and $ff00)) shr 16 shl 8 or
    (Weight1*DWord(Color1 and $ff00ff) + w2*DWord(Color2 and $ff00ff)) and $ff00ff00 shr 8;
end;

function RSMixColorsRGBNorm(Color1,Color2:integer; Weight1:DWord):TColor; overload;
var Weight2:DWord;
begin
  Weight2:=256-Weight1;
  DWord(Result):=
    (Weight1*DWord(Color1 and $ff00) +
            Weight2*DWord(Color2 and $ff00)) shr 16 shl 8 or
    (Weight1*DWord(Color1 and $ff00ff) +
            Weight2*DWord(Color2 and $ff00ff)) and $ff00ff00 shr 8;
end;

function RSMixColorsNorm(Color1,Color2:TColor; Weight1:DWord):TColor; overload;
var Weight2:DWord;
begin
  //Color1:=ColorToRGB(Color1);
  //Color2:=ColorToRGB(Color2);
  if Color1 < 0 then Color1:=GetSysColor(Byte(Color1));
  if Color2 < 0 then Color2:=GetSysColor(Byte(Color2));
  Weight2:=256-Weight1;
  DWord(Result):=
    (Weight1*DWord(Color1 and $ff00) +
            Weight2*DWord(Color2 and $ff00)) shr 16 shl 8 or
    (Weight1*DWord(Color1 and $ff00ff) +
            Weight2*DWord(Color2 and $ff00ff)) and $ff00ff00 shr 8;
end;

function RSMixColorsRGB(Color1,Color2:integer; Weight1,Weight2:DWord):TColor; overload;
begin
  Weight1 := Weight1*256 div (Weight1+Weight2);
  Weight2 := 256-Weight1;
  DWord(Result):=
    (Weight1*DWord(Color1 and $ff00) +
            Weight2*DWord(Color2 and $ff00)) shr 16 shl 8 or
    (Weight1*DWord(Color1 and $ff00ff) +
            Weight2*DWord(Color2 and $ff00ff)) and $ff00ff00 shr 8;
end;

function RSMixColors(Color1,Color2:TColor; Weight1,Weight2:DWord):TColor; overload;
begin
  //Color1:=ColorToRGB(Color1);
  //Color2:=ColorToRGB(Color2);
  if Color1 < 0 then Color1:=GetSysColor(Byte(Color1));
  if Color2 < 0 then Color2:=GetSysColor(Byte(Color2));
  Weight1:=Weight1*256 div (Weight1+Weight2);
  Weight2:=256-Weight1;
  DWord(Result):=
    (Weight1*DWord(Color1 and $ff00) +
            Weight2*DWord(Color2 and $ff00)) shr 16 shl 8 or
    (Weight1*DWord(Color1 and $ff00ff) +
            Weight2*DWord(Color2 and $ff00ff)) and $ff00ff00 shr 8;
end;

function RSMixColorsRGB(const Colors:array of integer; const Weights:array of DWord):TColor; overload;
begin
  Result:=RSMixColorsRGB(@Colors[low(Colors)],@Weights[low(Weights)],
                                            high(Colors)+1-low(Colors));
end;

function RSMixColors(const Colors:array of TColor;
                     const Weights:array of DWord):TColor; overload;
begin
  Result:=RSMixColors(@Colors[low(Colors)],@Weights[low(Weights)],
                                            high(Colors)+1-low(Colors));
end;

function RSMixColorsRGB(Colors:Pointer; Weights:Pointer;
                   length:DWord):TColor; overload;
var i,j,k:DWord; c,p:^DWord; Per, R,G,B:DWord;
begin
  c:=Colors;
  p:=Weights;
  Per:=0;
  R:=0;
  G:=0;
  B:=0;
  for i:=length downto 1 do
  begin
    k:=p^;
    inc(Per, k);
    j:=c^;
    inc(R, byte(j)*k);
    inc(G, byte(j shr 8)*k);
    inc(B, byte(j shr 16)*k);
    inc(c);
    inc(p);
  end;
  Result:=(R div Per) or ((G div Per) shl 8) or ((B div Per) shl 16);
end;

function RSMixColorsRGB(Colors:Pointer; step:Integer; Weights:Pointer;
                   length:DWord):TColor; overload;
var i,j,k:DWord; c,p:^DWord; Per, R,G,B:DWord;
begin
  c:=Colors;
  p:=Weights;
  Per:=0;
  R:=0;
  G:=0;
  B:=0;
  for i:=length downto 1 do
  begin
    k:=p^;
    inc(Per, k);
    j:=c^;
    inc(R, byte(j)*k);
    inc(G, byte(j shr 8)*k);
    inc(B, byte(j shr 16)*k);
    inc(c, step);
    inc(p, step);
  end;
  Result:=(R div Per) or ((G div Per) shl 8) or ((B div Per) shl 16);
end;

function RSMixColors(Colors:Pointer; Weights:Pointer;
                   length:DWord):TColor; overload;
var i,j,k:DWord; c,p:^DWord; Per, R,G,B:DWord;
begin
  c:=Colors;
  p:=Weights;
  Per:=0;
  R:=0;
  G:=0;
  B:=0;
  for i:=length downto 1 do
  begin
    j:=c^;
    if int(j)<0 then
      j:=GetSysColor(byte(j));
      
    k:=p^;
    inc(Per, k);
    inc(R, byte(j)*k);
    inc(G, byte(j shr 8)*k);
    inc(B, byte(j shr 16)*k);
    inc(c);
    inc(p);
  end;
  Result:=(R div Per) or ((G div Per) shl 8) or ((B div Per) shl 16);
end;

function RSMixColorsRGBNorm(Colors:Pointer;
                      Weights:Pointer; length:DWord):TColor; overload;
var e:PDWord; c,p:DWord;
begin
  e:=Weights;
  inc(e,length);
  Result:=0;
  while Weights<>e do
  begin
    c:=PDWord(Colors)^;
    p:=PDWord(Weights)^;
    Result:= Result + integer(
//      (p*byte(c shr 8)) and $ff00  or
      (p*(c and $ff00)) shr 16 shl 8  or
      (p*(c and $ff00ff) and $ff00ff00 shr 8));
    inc(PDWord(Weights));
    inc(PDWord(Colors));
  end;
end;

function RSMixColorsRGBNorm(Colors:Pointer; step:Integer;
                      Weights:Pointer; length:DWord):TColor; overload;
var e:PDWord; c,p:DWord;
begin
  e:=Weights;
  inc(e,length);
  Result:=0;
  while Weights<>e do
  begin
    c:=PDWord(Colors)^;
    p:=PDWord(Weights)^;
    Result:= Result + integer(
//      (p*byte(c shr 8)) and $ff00  or
      (p*(c and $ff00)) shr 16 shl 8  or
      (p*(c and $ff00ff) and $ff00ff00 shr 8));
    inc(PDWord(Weights));
    inc(PByte(Colors),step);
  end;
end;

function RSMixColorsNorm(Colors:Pointer;
                      Weights:Pointer; length:DWord):TColor; overload;
var e:PDWord; c,p:DWord;
begin
  e:=Weights;
  inc(e,length);
  Result:=0;
  while Weights<>e do
  begin
    c:=PDWord(Colors)^;
    if integer(c)<0 then c:=GetSysColor(Byte(c));
    p:=PDWord(Weights)^;
    Result:= Result + integer(
//      (p*byte(c shr 8)) and $ff00  or
      (p*(c and $ff00)) shr 16 shl 8  or
      (p*(c and $ff00ff) and $ff00ff00 shr 8));
    inc(PDWord(Weights));
    inc(PDWord(Colors));
  end;
end;

function RSMixColorsRGBNorm(const Colors:array of integer; const Weights:array of DWord):TColor; overload;
begin
  Result:=RSMixColorsRGBNorm(@Colors[low(Colors)],
                 @Weights[low(Weights)], high(Colors)+1-low(Colors));
end;

function RSMixColorsNorm(const Colors:array of TColor;
                     const Weights:array of DWord):TColor; overload;
begin
  Result:=RSMixColorsNorm(@Colors[low(Colors)],
                 @Weights[low(Weights)], high(Colors)+1-low(Colors));
end;

procedure RSMixPicColor32(MixTo,MixPic:Tbitmap; Color:TColor;
                                                Weight1,Weight2:DWord);
var i,x:integer; a,b:^DWord;
begin
  if MixPic.Height=0 then
  begin
    if MixTo<>MixPic then
      MixTo.Assign(MixPic);
    exit;
  end;

  MixPic.PixelFormat:= pf32bit;
  MixPic.HandleType:= bmDIB;

  Weight1:=Weight1*256 div (Weight1+Weight2);
  Weight2:=256-Weight1;
  Color:=ColorToRGB(Color);
  Color:=((Color and $ff0000) shr 16) or ((Color and $0000ff) shl 16) or
                                           (Color and integer($ff00ff00));
  if MixTo<>MixPic then
  begin
    MixTo.Width:=0;
    MixTo.Height:=0;
    MixTo.HandleType:=bmDIB;
    MixTo.PixelFormat:=pf32bit;
    MixTo.Width:=MixPic.Width;
    MixTo.Height:=MixPic.Height;
  end;

  x:=MixTo.Height-1;
  a:=MixTo.ScanLine[x];
  if MixTo=MixPic then
    b:=a
  else
    b:=MixPic.ScanLine[x];

  x:=MixTo.Width*MixTo.Height;

  if MixTo=MixPic then
    for i:=1 to x do
    begin
      a^:=((((a^ and $00ff00ff)*Weight1 + (DWord(Color) and $00ff00ff)*Weight2) shr 8) and $00ff00ff)
          or ((byte(a^ shr 8)*Weight1 + byte(DWord(Color) shr 8)*Weight2) and $ff00);
      inc(a);
    end
  else
    for i:=1 to x do
    begin
      a^:=((((b^ and $00ff00ff)*Weight1 + (DWord(Color) and $00ff00ff)*Weight2) shr 8) and $00ff00ff)
          or ((byte(b^ shr 8)*Weight1 + byte(DWord(Color) shr 8)*Weight2) and $ff00);
      inc(a);
      inc(b);
    end
end;

procedure RSMixPics(MixTo,Mix1,Mix2:Tbitmap; Weight1,Weight2:DWord);
var i,x:integer; a,b,c:^DWord;
begin
  Assert((Mix1.Width = Mix2.Width) and (Mix1.Height = Mix2.Height));
  if Mix1.Height=0 then
  begin
    if MixTo<>Mix1 then
      MixTo.Assign(Mix1);
    exit;
  end;

  Mix1.HandleType:=bmDIB;
  Mix2.HandleType:=bmDIB;
  if (Mix1.PixelFormat<>pf24bit) or (Mix2.PixelFormat<>pf24bit) then
  begin
     // MixPics handles 24bit better, but most of other functions require 32bit
    Mix1.PixelFormat:=pf32bit;
    Mix2.PixelFormat:=pf32bit;
  end;

  Weight1:=Weight1*256 div (Weight1+Weight2);
  Weight2:=256-Weight1;
  if (MixTo<>Mix1) and (MixTo<>Mix2) then
  begin
    MixTo.Width:=0;
    MixTo.Height:=0;
    MixTo.HandleType:=bmDIB;
    MixTo.PixelFormat:=Mix1.PixelFormat;
    MixTo.Width:=Mix1.Width;
    MixTo.Height:=Mix1.Height;
  end;

  x:=MixTo.Height-1;
  a:=MixTo.ScanLine[x];
  if MixTo = Mix1 then  b:=a  else  b:=Mix1.ScanLine[x];
  if MixTo = Mix2 then  c:=a  else  c:=Mix2.ScanLine[x];

  if MixTo.PixelFormat=pf32bit then
    x:=MixTo.Width*MixTo.Height
  else
    x:=((MixTo.Width*3+3) div 4)*MixTo.Height;

  if MixTo = Mix2 then
  begin
    Mix1:=Mix2;
    b:=c;
    i:=Weight1;
    Weight2:=Weight1;
    Weight1:=i;
  end;
  
  if MixTo = Mix1 then
    for i:=1 to x do
    begin
      a^:=((((a^ and $00ff00ff)*Weight1 + (c^ and $00ff00ff)*Weight2) shr 8) and $00ff00ff)
          or ((((a^ and $ff00ff00) shr 8)*Weight1 + ((c^ and $ff00ff00) shr 8)*Weight2) and $ff00ff00);
      inc(a);
      inc(c);
    end
  else
    for i:=1 to x do
    begin
      a^:=((((b^ and $00ff00ff)*Weight1 + (c^ and $00ff00ff)*Weight2) shr 8) and $00ff00ff)
          or ((((b^ and $ff00ff00) shr 8)*Weight1 + ((c^ and $ff00ff00) shr 8)*Weight2) and $ff00ff00);
      inc(a);
      inc(b);
      inc(c);
    end;
end;

var GrayPal: array[-1..255] of int;

function RSGrayscale(Bmp:TBitmap; Dest:TBitmap=nil):TBitmap;
var i,j:int;
begin
  if GrayPal[-1]=0 then
  begin
    j:=$ffffff;
    for i:=255 downto 1 do
    begin
      GrayPal[i]:=j;
      dec(j,$010101);
    end;
    // GrayPal[0] is initialized to 0
    GrayPal[-1]:=$1000300;
  end;

  if (Dest=nil) or (Dest=Bmp) then
    Result:=TBitmap.Create
  else
    Result:=Dest;

  with Result do
  try
    Transparent:=Bmp.Transparent;
    PixelFormat:=pf8bit;
    Palette:=CreatePalette(PLogPalette(@GrayPal)^);
    Width:=Bmp.Width;
    Height:=Bmp.Height;
    BitBlt(Canvas.Handle, 0, 0, Width, Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    if Transparent then
      MaskHandle:=CopyImage(Bmp.MaskHandle, IMAGE_BITMAP, 0, 0, LR_COPYRETURNORG);
  except
    if Result<>Dest then
      Free;
    raise;
  end;

  if Dest<>Bmp then exit;

  try
    Dest.Assign(Result);
  finally
    Result.Free;
  end;
  Result:=Dest;
end;

{
procedure RSGrayscaleSpec(Bmp:TBitmap; Light, Dark:TColor);
var i:int; Pal: array[-1..255] of int; h:HBITMAP;
begin
  Pal[-1]:=$1000300;
  Dark:=ColorToRGB(Dark);
  Light:=ColorToRGB(Light);
  for i:=255 downto 0 do
    Pal[i]:=RSMixColorsRGBNorm(Light, Dark, i);

  Bmp.TransparentMode:=tmFixed;
  h:=Bmp.ReleaseMaskHandle;
  Bmp.PixelFormat:=pf8bit;
  Bmp.Palette:=CreatePalette(PLogPalette(@Pal)^);
  Bmp.MaskHandle:=h;
end;
{}

procedure RSGrayscaleSpec(Bmp:TBitmap; Light, Dark:TColor);
var i:int; p:pint; Pal: array[0..255] of int; h:HBITMAP;
begin
  if Bmp.Height=0 then  exit;

  if Light<0 then  Light:= GetSysColor(byte(Light));
  if Dark<0 then  Dark:= GetSysColor(byte(Dark));

  for i:= 255 downto 0 do
    Pal[i]:= RSMixColorsRGB(Light, Dark, i);

//  Bmp.TransparentMode:=tmFixed;
  h:=Bmp.ReleaseMaskHandle;
  with Bmp do
  begin
    HandleType:=bmDIB;
    PixelFormat:=pf32bit;
    p:=ScanLine[Height-1];
    for i:= Width*Height downto 1 do
    begin
      p^:=Pal[RSGetIntensity(p^ and $FFFFFF)];
      inc(p);
    end;
  end;
  Bmp.MaskHandle:=h;
end;

procedure RSDrawMonoBmp(ACanvas:TCanvas; Bmp:TBitmap; Color:TColor; x, y:int);
const
  ROP_DSPDxax = $00E20746; // Спасибо Алексею Румянцеву - автору RyMenus
var c1,c2:TColor;
begin
  with ACanvas do
  begin
    Brush.Color:=Color;
    c1:=GetTextColor(Handle);
    c2:=GetBkColor(Handle);
    SetTextColor(Handle, clWhite);
    SetBkColor(Handle, clBlack);
    BitBlt(Handle, x, y, Bmp.Width, Bmp.Height,
           Bmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
    SetTextColor(Handle, c1);
    SetBkColor(Handle, c2);
  end;
end;

procedure RSDrawMask(ACanvas:TCanvas; Bmp:TBitmap; Color:TColor; x, y:int);
var MonoBmp:TBitmap;
begin
  MonoBmp:=TBitmap.Create;
  with MonoBmp do
    try
      Handle:=CopyImage(Bmp.MaskHandle, IMAGE_BITMAP, 0, 0,
        LR_COPYRETURNORG or LR_MONOCHROME);
      //Handle:=CopyImage(Bmp.MaskHandle, IMAGE_BITMAP, 0, 0, 0);
      RSDrawMonoBmp(ACanvas, MonoBmp, Color, x, y);
    finally
      Free;
    end;
end;

procedure RSDrawDisabled(ACanvas:TCanvas; Bmp:TBitmap; Color:TColor; x, y:int);
var MonoBmp:TBitmap;
begin
  MonoBmp := TBitmap.Create;
  with MonoBmp, Canvas do
    try
      Width:=Bmp.Width;
      Height:=Bmp.Height;
      Brush.Color:=clWhite;
      FillRect(ClipRect);
      Monochrome:=true;
      Draw(0, 0, Bmp);
      RSDrawMonoBmp(ACanvas, MonoBmp, Color, x, y);
    finally
      Free;
    end;
end;

 // Tpansparency between 0 and 255
procedure RSTransparentRandom(Bmp:TBitmap; TransparentColor:TColor; Tpansparency:Byte); overload;
var p:pint; i:int;
begin
  if (Bmp.Width=0) or (Bmp.Height=0) or (Tpansparency=0) then exit;
  Bmp.HandleType:=bmDIB;
  Bmp.PixelFormat:=pf32bit;
  TransparentColor:=RSSwapColor(ColorToRGB(TransparentColor));
  p:=Bmp.ScanLine[Bmp.Height-1];
  for i:=Bmp.Width*Bmp.Height downto 1 do
  begin
    if Random(255)<Tpansparency then
      p^:=TransparentColor;
    inc(p);
  end;
end;

 // Tpansparency is grayscale bitmap made using RSGrayscale
procedure RSTransparentRandom(Bmp:TBitmap; TransparentColor:TColor;
  Tpansparency:TBitmap); overload;
var p:pint; p1:pbyte; i,j,w,dy:int;
begin
  Assert(Tpansparency.PixelFormat=pf8bit);
  Assert((Bmp.Width=Tpansparency.Width) and (Bmp.Height=Tpansparency.Height));
  if (Bmp.Width=0) or (Bmp.Height=0) then exit;
  Tpansparency.HandleType:=bmDIB;
  Bmp.HandleType:=bmDIB;
  Bmp.PixelFormat:=pf32bit;
  TransparentColor:=RSSwapColor(ColorToRGB(TransparentColor));
  p:=Bmp.ScanLine[Bmp.Height-1];
  p1:=Tpansparency.ScanLine[Bmp.Height-1];
  w:=Bmp.Width;
  dy:= (-w) and 3;
  for j:=Bmp.Height downto 1 do
  begin
    for i:=w downto 1 do
    begin
      if Random(255)<p1^ then
        p^:=TransparentColor;
      inc(p);
      inc(p1);
    end;
    inc(p1, dy);
  end;
end;

procedure RSTransparentFixed(Bmp:TBitmap; TransparentColor:TColor; Step:int=1);
var p,pl:pint; i,j,w,h,dy:int; First:boolean;
begin
  w:=Bmp.Width;
  h:=Bmp.Height;
  if (w=0) or (h=0) or (Step<0) then exit;
  if Step=0 then
    with TBrush.Create do
      try
        Color:=TransparentColor;
        Windows.FillRect(Bmp.Canvas.Handle, Bmp.Canvas.ClipRect, Handle);
        exit;
      finally
        Free;
      end;
  Bmp.HandleType:=bmDIB;
  Bmp.PixelFormat:=pf32bit;
  TransparentColor:=RSSwapColor(ColorToRGB(TransparentColor));
  pl:=Bmp.ScanLine[0];
  dy:=-w*4;
  j:=0;
  if Step mod 2<>0 then
  begin
    First:=true;
    Step:=(Step+1) div 2;
    while j<h do
    begin
      i:=0;
      p:=pl;
      if First then
      begin
        inc(i, Step);
        inc(p, Step);
      end;
      while i<w do
      begin
        p^:=TransparentColor;
        inc(p, Step*2);
        inc(i, Step*2);
      end;
      First:=not First;
      inc(pbyte(pl), dy*Step);
      inc(j, Step);
    end;
  end else
    while j<h do
    begin
      i:=0;
      p:=pl;
      while i<w do
      begin
        p^:=TransparentColor;
        inc(p, Step);
        inc(i, Step);
      end;
      inc(pbyte(pl), dy*Step);
      inc(j, Step);
    end;
end;

procedure RSChangeGrayPic(Bmp:TBitmap; Add:int); overload;
var p:pbyte; i,j:int;
begin
  Assert(Bmp.PixelFormat=pf8bit);
  if (Bmp.Width=0) or (Bmp.Height=0) or (Add=0) then exit;
  Bmp.HandleType:=bmDIB;
  p:=Bmp.ScanLine[Bmp.Height-1];
  if Add>0 then
  begin
    if Add>255 then Add:=255;
    for i:=((Bmp.Width + 3) and not 3)*Bmp.Height downto 1 do
    begin
      j:=p^ + Add;
      if j>255 then
        p^:=255
      else
        p^:=j;
      inc(p);
    end;
  end else
  begin
    if Add<-255 then Add:=-255;
    for i:=((Bmp.Width + 3) and not 3)*Bmp.Height downto 1 do
    begin
      j:=p^ + Add;
      if j<0 then
        p^:=0
      else
        p^:=j;
      inc(p);
    end;
  end;
end;

{
procedure RSGradient(c:TCanvas; const Rect:TRect; UpCl,DnCl:TColor;
  UpAlpha, DnAlpha:int; Vertical:boolean);
begin
  GradientFill(c.Handle, )
end;
}

procedure RSGradientV(c:TCanvas; const Rect:TRect; UpCl,DnCl:TColor);
begin
  GradientFillCanvas(c, UpCl, DnCl, Rect, gdVertical);  
end;
{
var y,y1,y2,x1,x2:integer; DefC:TColor;
begin
  UpCl:=ColorToRGB(UpCl);
  DnCl:=ColorToRGB(DnCl);
  x1:=Rect.Left;
  x2:=Rect.Right;
  y1:=Rect.Top;
  y2:=Rect.Bottom-1;

  DefC:=c.Pen.Color;
  if y1=y2 then
  begin
    c.Pen.Color:=RSMixColorsRGB(UpCl,DnCl,1,1);
    c.MoveTo(x1,y2);
    c.LineTo(x2,y2);
  end else
    for y:=y1 to y2 do
    begin
      c.Pen.Color:=RSMixColorsRGB(UpCl, DnCl, y2-y, y-y1);
      c.MoveTo(x1,y);
      c.LineTo(x2,y);
    end;
  c.Pen.Color:=DefC;
end;
}

procedure RSGradientH(c:TCanvas; const Rect:TRect; LeftCl,RightCl:TColor);
begin
  GradientFillCanvas(c, LeftCl, RightCl, Rect, gdHorizontal);
end;
{
var y1,y2,x,x1,x2:integer; DefC:TColor;
begin
  LeftCl:=ColorToRGB(LeftCl);
  RightCl:=ColorToRGB(RightCl);
  x1:=Rect.Left;
  x2:=Rect.Right-1;
  y1:=Rect.Top;
  y2:=Rect.Bottom;

  DefC:=c.Pen.Color;
  if x1=x2 then
  begin
    c.Pen.Color:=RSMixColorsRGB(LeftCl,RightCl,1,1);
    c.MoveTo(x2,y1);
    c.LineTo(x2,y2);
  end else
    for x:=x1 to x2 do
    begin
      c.Pen.Color:=RSMixColorsRGB(LeftCl, RightCl, x2-x, x-x1);
      c.MoveTo(x,y1);
      c.LineTo(x,y2);
    end;
  c.Pen.Color:=DefC;
end;
}

procedure RSGradientV32(bmp:TBitmap; Rect:TRect; UpCl,DnCl:TColor);
var w,h,p1,pAll,dy,c:integer; a,sx,sy:PInt; Weight1,Weight2:DWord;
begin
  with bmp do
  begin
    PixelFormat:= pf32bit;
    HandleType:= bmDIB;
  end;

  w:=bmp.Width;
  h:=bmp.Height;

  if Rect.Left<0 then Rect.Left:=0;
  if Rect.Top<0 then Rect.Top:=0;
  if Rect.Right>w then Rect.Right:=w;
  if Rect.Bottom>h then Rect.Bottom:=h;

  if (Rect.Left>=Rect.Right) or (Rect.Top>=Rect.Bottom) then exit;

  if Rect.Top=Rect.Bottom-1 then
    with bmp.Canvas do
    begin
      w:=Pen.Color;
      Pen.Color:=RSMixColorsRGB(UpCl,DnCl,1,1);
      MoveTo(Rect.Left,Rect.Top);
      LineTo(Rect.Right,Rect.Top);
      Pen.Color:=w;
      exit;
    end;

  UpCl:= RSSwapColor(ColorToRGB(UpCl));
  DnCl:= RSSwapColor(ColorToRGB(DnCl));

  a:=pointer(integer(bmp.ScanLine[Rect.Top])+Rect.Left*4);
  dy:=(Rect.Left-Rect.Right-w)*4;
  h:=Rect.Bottom-Rect.Top;
  sy:=pointer(integer(a)-w*h*4);
  w:=Rect.Right-Rect.Left;
  p1:=(h-1)*256;
  pAll:=h-1;
  w:=w*4;

  repeat
    sx:=a;
    inc(PByte(sx),w);
    Weight1:=DWord(p1 div pAll);
    Weight2:=256-Weight1;
    c:= integer((Weight1*Byte(UpCl)+Weight2*Byte(DnCl)) shr 8 +
      (Weight1*PByte(DWord(@UpCl)+1)^+Weight2*PByte(DWord(@DnCl)+1)^) shr 8 shl 8 +
      (Weight1*PByte(DWord(@UpCl)+2)^+Weight2*PByte(DWord(@DnCl)+2)^) shr 8 shl 16);
    repeat
      a^:=c;
      inc(a);
    until a=sx;
    inc(PByte(a),dy);
    dec(p1,256);
  until a=sy;
end;

procedure RSGradientH32(bmp:TBitmap; Rect:TRect; LeftCl,RightCl:TColor);
var w,h,p1,pAll,dy,dx,c:integer; a,sx,sy:PInt; Weight1,Weight2:DWord;
begin
  with bmp do
  begin
    PixelFormat:= pf32bit;
    HandleType:= bmDIB;
  end;

  w:=bmp.Width;
  h:=bmp.Height;

  if Rect.Left<0 then Rect.Left:=0;
  if Rect.Top<0 then Rect.Top:=0;
  if Rect.Right>w then Rect.Right:=w;
  if Rect.Bottom>h then Rect.Bottom:=h;

  if (Rect.Left>=Rect.Right) or (Rect.Top>=Rect.Bottom) then exit;

  if Rect.Left=Rect.Right-1 then
    with bmp.Canvas do
    begin
      w:=Pen.Color;
      Pen.Color:=RSMixColorsRGB(LeftCl,RightCl,1,1);
      MoveTo(Rect.Left,Rect.Top);
      LineTo(Rect.Left,Rect.Bottom);
      Pen.Color:=w;
      exit;
    end;

  LeftCl:= RSSwapColor(ColorToRGB(LeftCl));
  RightCl:= RSSwapColor(ColorToRGB(RightCl));

  a:=pointer(integer(bmp.ScanLine[Rect.Top])+Rect.Left*4);
  dy:=-w*4;
  h:=Rect.Bottom-Rect.Top;
  w:=Rect.Right-Rect.Left;
  dx:=4-h*dy;
  sx:=pointer(integer(a)+w*4);
  p1:=(w-1)*256;
  pAll:=w-1;
  h:=dy*h;
  repeat
    sy:=a;
    inc(PByte(sy),h);
    Weight1:=DWord(p1 div pAll);
    Weight2:=256-Weight1;
    c:= integer((Weight1*Byte(LeftCl)+Weight2*Byte(RightCl)) shr 8 +
      (Weight1*PByte(DWord(@LeftCl)+1)^+Weight2*PByte(DWord(@RightCl)+1)^) shr 8 shl 8 +
      (Weight1*PByte(DWord(@LeftCl)+2)^+Weight2*PByte(DWord(@RightCl)+2)^) shr 8 shl 16);
    repeat
      a^:=c;
      inc(PByte(a),dy);
    until a=sy;
    inc(PByte(a),dx);
    dec(p1,256);
  until a=sx;
end;

function RSSimpleRotate32(Source:TBitmap; r:TRect; RSsrValue:integer):TBitmap; overload;
var
  a, b: pint;
  LineStop, FullStop: ptr;
  dx, dy, sdy, w, h: integer;
  flip: Boolean;
begin
  w:= Source.Width;
  h:= Source.Height;

  if r.Left<0 then r.Left:=0;
  if r.Top<0 then r.Top:=0;
  if r.Right>w then r.Right:=w;
  if r.Bottom>h then r.Bottom:=h;

  if (r.Left>=r.Right) or (r.Top>=r.Bottom) then
  begin
    Result:=TBitmap.Create;
    Result.Assign(Source);
    exit;
  end;

  with Source do
  begin
    PixelFormat:= pf32bit;
    HandleType:= bmDIB;
  end;

  flip:= (RSsrValue and RSsrHFlip) <> 0;
  RSsrValue:= RSsrValue and 3;
  Result:= TBitmap.Create;
  Result.HandleType:= bmDIB;
  Result.PixelFormat:= pf32bit;
  w:= r.Right - r.Left;
  h:= r.Bottom - r.Top;
  case RssrValue of
    0:
    begin
      Result.Width:=w;
      Result.Height:=h;
      dx:=1;
      dy:=-w*2;
      b:=Result.ScanLine[0];
    end;
    1:
    begin
      Result.Width:=h;
      Result.Height:=w;
      dx:=h;
      dy:=1-w*h;
      b:=Result.ScanLine[w-1];
    end;
    2:
    begin
      Result.Width:=w;
      Result.Height:=h;
      dx:=-1;
      dy:=w*2;
      b:=Result.ScanLine[h-1];
      inc(b,w-1);
    end;
    3:
    begin
      Result.Width:=h;
      Result.Height:=w;
      dx:=-h;
      dy:=w*h-1;
      b:= Result.ScanLine[0];
      inc(b,h-1);
    end;
    else exit; // avoid warning
  end;
  dx:=dx*4;
  dy:=dy*4;
  if not Flip then
  begin
    a:= Source.ScanLine[r.Top];
    inc(a,r.Left);
    sdy:= -4*(Source.Width + w);
    FullStop:= PChar(Source.ScanLine[r.Bottom-1]) - 4*(Source.Width-r.Left);
    w:=w*4;
    repeat
      LineStop:=a;
      inc(PByte(LineStop),w);
      repeat
        b^:=a^;
        inc(a);
        inc(PByte(b),dx);
      until a=LineStop;
      inc(PByte(a),sdy);
      inc(PByte(b),dy);
    until a = FullStop;
  end else
  begin
    a:= ptr(PChar(Source.ScanLine[r.Top]) + 4*(r.Right-1));
    sdy:= 4*(w - Source.Width);
    FullStop:= PChar(Source.ScanLine[r.Bottom-1]) + sdy + 4*r.Left - 4;
    w:=w*4;
    repeat
      LineStop:= a;
      dec(PByte(LineStop),w);
      repeat
        b^:=a^;
        dec(a); // The only differance
        inc(PByte(b),dx);
      until a = LineStop;
      inc(PByte(a),sdy);
      inc(PByte(b),dy);
    until a = FullStop;
  end;
end;

function RSSimpleRotate32(Source:TBitmap; RSsrValue:integer):TBitmap; overload;
const
  DefRect: TRect = (Left: 0; Top: 0; Right: MaxInt; Bottom: MaxInt);
begin
  Result:= RSSimpleRotate32(Source, DefRect, RSsrValue);
end;


type
  TRSColorTransforms = class
  public
    procedure Smooth(var per, col:TRSFourIntArray; AllP: Integer; a: PLongint);
    procedure Smart(var per, col:TRSFourIntArray; AllP: Integer; a: PLongint);
    procedure Smart2(var per, col:TRSFourIntArray; AllP: Integer; a: PLongint);
  end;

{ TMyColorTransforms }

procedure TRSColorTransforms.Smart(var per, col: TRSFourIntArray; AllP: Integer;
  a: PLongint);
var
  aa: int;
begin
  if AllP<255 then
    aa:=RSMixColorsRGB(@col[0],@per[0],4)
  else
    aa:=RSMixColorsRGBNorm(@col[0],@per[0],4);

  if per[0]<>0 then  per[0]:=SqDifference(aa,col[0])
  else per[0]:=MaxInt;
  if per[1]<>0 then  per[1]:=SqDifference(aa,col[1])
  else per[1]:=MaxInt;
  if per[2]<>0 then  per[2]:=SqDifference(aa,col[2])
  else per[2]:=MaxInt;
  if per[3]<>0 then  per[3]:=SqDifference(aa,col[3])
  else per[3]:=MaxInt;
  AllP:=0;
   // Интересный эффект: > вместо <
  if per[1]<per[0] then  AllP:=1;
  if per[2]<per[AllP] then  AllP:=2;
  if per[3]<per[AllP] then  AllP:=3;

  if self = nil then
    a^:= col[AllP]
  else
    a^:= RSMixColorsRGB(aa, col[AllP], Integer(self));
end;

procedure TRSColorTransforms.Smart2(var per, col: TRSFourIntArray;
  AllP: Integer; a: PLongint);
var
  aa, bb, i, k: int;
begin
  if AllP<255 then
    aa:=RSMixColorsRGB(@col[0],@per[0],4)
  else
    aa:=RSMixColorsRGBNorm(@col[0],@per[0],4);
  k:= 0;
  bb:= 0;
  for i:= 0 to high(per) do
    if per[i] > k then
    begin
      k:= per[i];
      bb:= col[i];
    end;

  a^:= RSMixColorsRGB(aa, bb, Integer(self));
end;

procedure TRSColorTransforms.Smooth(var per, col: TRSFourIntArray;
  AllP: Integer; a: PLongint);
begin
  if AllP<255 then
    a^:= RSMixColorsRGB(@col[0],@per[0],4)
  else
    a^:= RSMixColorsRGBNorm(@col[0],@per[0],4);
end;

// Bylinear
function RSTransformSmoothProc: TRSTransformColorProc;
begin
  Result:= TRSColorTransforms(nil).Smooth;
end;

// Finds the color closest to bylinear among the 4 colors, then mixes in bylinear color with Mix parameter
function RSTransformSmartProc(Mix: Integer = 0): TRSTransformColorProc;
begin
  Result:= TRSColorTransforms(Mix).Smart;
end;

// Mixes nearest neighbour with bylinear color with Mix parameter (0 - full nearest, 255 - full bylinear)
function RSTransformSmartProc2(Mix: Integer = 0): TRSTransformColorProc;
begin
  Result:= TRSColorTransforms(Mix).Smart2;
end;


function RSXForm(scale: ext = 1): TRSXForm; overload;
begin
  Result.SetScale(scale, scale);
end;

function RSXForm(scaleX, scaleY: ext; rotate: ext = 0): TRSXForm; overload;
begin
  Result.SetScale(scaleX, scaleY);
  if rotate <> 0 then
    Result.Rotate(rotate);
end;

function RSTransformEnhancer(ISigma: Double = 1.9; MidShift: Double = 0.5;
   MainShift: Double = 1): TRSTransformEnhancer;
begin
  Result.Enhanced.Width:= 0;
  Result.Enhanced.Height:= 0;
  Result.ISigma:= ISigma;
  Result.MidShift:= MidShift;
  Result.MainShift:= MainShift;
end;


type
  TRSTransforms = class
  public
    function XForm(p:TPoint; Source,Dest:TBitmap):TRSFloatPoint;
  end;

{ TRSTransforms }

function TRSTransforms.XForm(p: TPoint; Source, Dest: TBitmap): TRSFloatPoint;
var
  x, y: ext;
begin
  with PRSAreaTransform(self)^ do
  begin
    x:= p.X + Lo.X;
    y:= p.Y + Lo.Y;
    // 0.5 - это поправка на то, что пиксели - это не точки, а квадраты.
    Result.X:= x*Form.eM11 + y*Form.eM12 - 0.5;
    Result.Y:= x*Form.eM21 + y*Form.eM22 - 0.5;
  end;
end;

function RSPrepareTransform32(var Area: TRSAreaTransform;
   var wd, hd: int; ACenterInDest: Boolean = true): TRSSmoothTransformProc;
begin
  with Area do
  begin
    wd:= GetDestWidth;
    hd:= GetDestHeight;
    if ACenterInDest then
      Area.CenterInDest(wd, hd);
    // 0.5 - это поправка на то, что пиксели - это не точки, а квадраты.
    // Delta - лекарство от ошибок округления при увеличении на рациональный множитель
    Lo.X:= Lo.X + Delta + 0.5;
    Lo.Y:= Lo.Y + Delta + 0.5;
    // Обратная матрица
    Form.Inverse;
  end;
  Result:= TRSTransforms(@Area).XForm;
end;

function RSTransform32(Source: TBitmap; Area: TRSAreaTransform;
           NoCl: TColor; PreserveNoCl: Boolean; sr: TRect;
           ColorProc: TRSTransformColorProc = nil;
           CenterInDest: Boolean = true;
           Enhance: TRSTransformEnhanceProc = nil): TBitmap; overload;
var
  proc: TRSSmoothTransformProc;
  wd,hd, dy, x,y, x1,y1: integer;
  vx, vy: ext;
  a,s: PInt;
begin
  proc:= RSPrepareTransform32(Area, wd, hd, CenterInDest);

  if Assigned(ColorProc) or Assigned(Enhance) then
    Result:= RSAnyTransform32(Source, proc, wd, hd, NoCl, PreserveNoCl,
       sr, ColorProc, Enhance)
  else
    with Area do
    begin
      // Мог бы быть заметный проигрыш в скорости при использовании AnyTransform

      Source.HandleType:= bmDIB;
      Source.PixelFormat:= pf32bit;

      NoCl:=ColorToRGB(NoCl);
      NoCl:=((Nocl and $ff0000) shr 16) or
            ((Nocl and $0000ff) shl 16) or
            (Nocl and int($ff00ff00)); //Перевернем NoCl

      Result:=TBitmap.Create;
      Result.HandleType:=bmDIB;
      Result.PixelFormat:=pf32bit;
      Result.Width:= wd;
      Result.Height:= hd;

      s:= Source.ScanLine[0];
      dy:= -4*Source.Width;
      a:= Result.ScanLine[Result.Height-1];
      dec(wd);
      dec(hd);
      for y:= hd downto 0 do
      begin
        for x:= 0 to wd do
        begin
          vx:= x + Lo.X;
          vy:= y + Lo.Y;
          // 0.5 - это поправка на то, что пиксели - это не точки, а квадраты.
          x1:= round(vx*Form.eM11 + vy*Form.eM12 - 0.5);
          y1:= round(vx*Form.eM21 + vy*Form.eM22 - 0.5);
          if (x1 >= sr.Left) and (x1 < sr.Right) and (y1 >= sr.Top) and (y1 < sr.Bottom) then
            a^:= PInt(integer(s) + x1*4 + y1*dy)^
          else
            a^:= NoCl;
          inc(a);
        end;
      end;
    end;
end;

function RSTransform32(Source: TBitmap; const Area: TRSAreaTransform;
           NoCl: TColor; PreserveNoCl: Boolean;
           ColorProc: TRSTransformColorProc = nil;
           CenterInDest: Boolean = true;
           Enhance: TRSTransformEnhanceProc = nil): TBitmap; overload;
begin
  Result:= RSTransform32(Source, Area, NoCl, PreserveNoCl,
    Rect(0, 0, Source.Width, Source.Height), ColorProc, CenterInDest,
    Enhance);
end;

function RSTransform32(Source:TBitmap; const XForm: TRSXForm;
           NoCl:TColor; PreserveNoCl:Boolean; sr:TRect; CutRect:boolean;
           ColorProc: TRSTransformColorProc = nil;
           Enhance: TRSTransformEnhanceProc = nil): TBitmap; overload;
var
  Area: TRSAreaTransform;
  w,h: integer;
begin
  w:=Source.Width;
  h:=Source.Height;

  SetMax(sr.Left, 0);
  SetMax(sr.Top, 0);
  SetMin(sr.Right, w);
  SetMin(sr.Bottom, h);

  if (sr.Left>=sr.Right) or (sr.Top>=sr.Bottom) then
  begin
    Result:=TBitmap.Create;
    exit;
  end;

  Area.Form:= XForm;
  Area.SetSourceRect(sr);

  if not CutRect then
    sr:= Rect(0, 0, w, h);

  Result:= RSTransform32(Source, Area, NoCl, PreserveNoCl, sr,
     ColorProc, true, Enhance);
end;

function RSTransform32(Source:TBitmap; const XForm: TRSXForm;
           NoCl:TColor; PreserveNoCl:Boolean;
           ColorProc: TRSTransformColorProc = nil;
           Enhance: TRSTransformEnhanceProc = nil): TBitmap; overload;
begin
  Result:= RSTransform32(Source, XForm, NoCl, PreserveNoCl,
     Rect(0,0,MaxInt,MaxInt), false, ColorProc, Enhance);
end;

function RSAnyTransform32(Source:TBitmap; proc:TRSTransformProc;
           Width, Height:integer; NoCl:TColor; ClipRect:TRect):TBitmap; overload;
var w,dy,x,y:integer; a,s:PInt;
    p:TPoint;
begin
  if ClipRect.Left<0 then ClipRect.Left:=0;
  if ClipRect.Top<0 then ClipRect.Top:=0;
  if ClipRect.Right>Source.Width then ClipRect.Right:=Source.Width;
  if ClipRect.Bottom>Source.Height then ClipRect.Bottom:=Source.Height;

  if (ClipRect.Right - ClipRect.Left <= 0) or
     (ClipRect.Bottom - ClipRect.Top <= 0) then
  begin
    Result:=TBitmap.Create;
    Result.Assign(Source);
    exit;
  end;
  with Source do
  begin
    PixelFormat:= pf32bit;
    HandleType:= bmDIB;
  end;


  if Width<=0 then Width:=ClipRect.Right - ClipRect.Left;
  if Height<=0 then Height:=ClipRect.Bottom - ClipRect.Top;

  NoCl:=ColorToRGB(NoCl);
   //Перевернем NoCl
  NoCl:=Byte(Nocl shr 16) or (Byte(Nocl) shl 16) or (Nocl and integer($ff00ff00));

  w:=Source.Width;

  Result:=TBitmap.Create;
  Result.HandleType:=bmDIB;
  Result.PixelFormat:=pf32bit;
  Result.Width:=Width;
  Result.Height:=Height;

  s:=Source.ScanLine[0];
  dy:=-4*w;
  a:=Result.ScanLine[Height-1];

  dec(Width);
  dec(Height);
  for y:=Height downto 0 do
  begin
    for x:=0 to Width do
    begin
      p:=proc(point(x,y),Source,Result);
      if (p.x>=ClipRect.Left) and (p.x<ClipRect.Right) and
         (p.y>=ClipRect.Top) and (p.y<ClipRect.Bottom) then
      begin
        a^:=PInt(integer(s)+p.x*4+p.y*dy)^;
      end else a^:=NoCl;
      inc(a);
    end;
  end;
end;

function RSAnyTransform32(Source:TBitmap; proc:TRSTransformProc;
           Width, Height:integer; NoCl:TColor):TBitmap; overload;
begin
  Result:= RSAnyTransform32(Source, proc, Width, Height, NoCl, Rect(0,0,MaxInt,MaxInt));
end;


function RSAnyTransform32(Source:TBitmap; proc:TRSSmoothTransformProc;
           Width, Height:integer; NoCl:TColor; PreserveNoCl:Boolean;
           ClipRect:TRect; ColorProc: TRSTransformColorProc = nil;
           Enhance: TRSTransformEnhanceProc = nil):TBitmap; overload;
const
  TranspMul = 7;
  TranspDiv = 10;
  Inf = 1E100;
{$DEFINE Lin}
{$IFDEF Lin}
  Multiplier = 100;
  AbsCoeff = 0.0;
{$ELSE}
  Multiplier = 250;
  function Inv(x: ext): ext; inline;
  begin
    if x > 1/Inf then
      Result:= 1/x
    else
      Result:= Inf;
  end;
{$ENDIF}

var
  w,dy,x,y,x1,y1:integer;
  a,s: PLongint;
  xp,yp,r: ext;
  p:TRSFloatPoint;
  per, col: TRSFourIntArray;  perL, perT, perR, perB: ext;
  AllP, TransP:int;
begin
  SetMax(ClipRect.Left, 0);
  SetMax(ClipRect.Top, 0);
  SetMin(ClipRect.Right, Source.Width);
  SetMin(ClipRect.Bottom, Source.Height);

  if (ClipRect.Right <= ClipRect.Left) or (ClipRect.Bottom <= ClipRect.Top) then
  begin
    Result:= TBitmap.Create;
    Result.Assign(Source);
    exit;
  end;

  Source.PixelFormat:= pf32bit;
  Source.HandleType:= bmDIB;

  if Width<=0 then Width:= ClipRect.Right - ClipRect.Left;
  if Height<=0 then Height:= ClipRect.Bottom - ClipRect.Top;

  NoCl:=ColorToRGB(NoCl);
   //Перевернем NoCl
  NoCl:=((Nocl shr 16) and $ff) or ((Nocl and $0000ff) shl 16) or (Nocl and integer($ff00ff00));

  w:=Source.Width;

  Result:=TBitmap.Create;
  Result.HandleType:=bmDIB;
  Result.PixelFormat:=pf32bit;
  Result.Width:=Width;
  Result.Height:=Height;

  if Assigned(Enhance) then
    proc:= Enhance(Source, Result, ClipRect, proc);

  s:= Source.ScanLine[0];
  dy:= -4*w;
  a:= Result.ScanLine[Height-1];

//  dec(ClipRect.Right);
//  dec(ClipRect.Bottom);
  dec(Width);
  dec(Height);

  if not Assigned(ColorProc) then
    for y:=Height downto 0 do
    begin
      for x:=0 to Width do
      begin
        p:=proc(point(x,y),Source,Result);
        x1:=round(p.x);
        y1:=round(p.y);
        if (x1>=ClipRect.Left) and (x1<ClipRect.Right) and
           (y1>=ClipRect.Top) and (y1<ClipRect.Bottom) then
        begin
          a^:=PInt(integer(s)+x1*4+y1*dy)^;
        end else a^:=NoCl;
        inc(a);
      end;
    end
  else
    for y:=Height downto 0 do
    begin
      for x:=0 to Width do
      begin
        p:=proc(point(x,y),Source,Result);
        x1:=round(p.x);
        y1:=round(p.y);
        if (x1>=ClipRect.Left) and (x1<ClipRect.Right) and
           (y1>=ClipRect.Top) and (y1<ClipRect.Bottom) then
        begin
          xp:=Frac(p.X+1);
          yp:=Frac(p.Y+1);

          //x1:=trunc(p.x+1);
          //y1:=trunc(p.y+1);
          if xp<0.5 then  inc(x1);
          if yp<0.5 then  inc(y1);

        {$IFDEF Lin}
          r:= (1-xp)*(1-yp) + AbsCoeff*(sqr(1-xp) + sqr(1-yp));
          per[0]:= Round(r*Multiplier);
          r:= (xp)*(1-yp) + AbsCoeff*(sqr(xp) + sqr(1-yp));
          per[1]:= Round(r*Multiplier);
          r:= (1-xp)*(yp) + AbsCoeff*(sqr(1-xp) + sqr(yp));
          per[2]:= Round(r*Multiplier);
          r:= (xp)*(yp) + AbsCoeff*(sqr(xp) + sqr(yp));
          per[3]:= Round(r*Multiplier);
        {$ELSE}
          perL:= Inv(xp);
          perT:= Inv(yp);
          perR:= Inv(1-xp);
          perB:= Inv(1-yp);
          r:= Multiplier/(perL*perT + perT*perR + perR*perB + perB*perL);
          per[0]:= Round(r*perL*perT);
          per[1]:= Round(r*perR*perT);
          per[2]:= Round(r*perL*perB);
          per[3]:= Round(r*perR*perB);
        {$ENDIF}

          if y1>0 then
          begin
            if x1>0 then
              col[0]:=PInt(integer(s)+(x1-1)*4+(y1-1)*dy)^ and $ffffff
            else
              per[0]:=0;

            if x1<Source.Width then
              col[1]:=PInt(integer(s)+(x1)*4+(y1-1)*dy)^ and $ffffff
            else
              per[1]:=0;
          end else
          begin
            per[0]:=0;
            per[1]:=0;
          end;

          if y1<Source.Height then
          begin
            if x1>0 then
              col[2]:=PInt(integer(s)+(x1-1)*4+(y1)*dy)^ and $ffffff
            else
              per[2]:=0;

            if x1<Source.Width then
              col[3]:=PInt(integer(s)+(x1)*4+(y1)*dy)^ and $ffffff
            else
              per[3]:=0;
          end else
          begin
            per[2]:=0;
            per[3]:=0;
          end;

          { Мозаика:
          AllP:=per[0];
          per[0]:=per[3];
          per[3]:=AllP;
          if per[0]=0 then col[3]:=col[0]
          else if per[3]=0 then col[0]:=col[3];
          AllP:=per[1];
          per[1]:=per[2];
          per[2]:=AllP;
          if per[1]=0 then col[2]:=col[1]
          else if per[2]=0 then col[1]:=col[2];
          {}

          if PreserveNoCl then
          begin
            TransP:=0;
            if col[0]=NoCl then
            begin
              inc(TransP, per[0]);
              per[0]:=0;
            end;
            if col[1]=NoCl then
            begin
              inc(TransP, per[1]);
              per[1]:=0;
            end;
            if col[2]=NoCl then
            begin
              inc(TransP, per[2]);
              per[2]:=0;
            end;
            if col[3]=NoCl then
            begin
              inc(TransP, per[3]);
              per[3]:=0;
            end;
            AllP:=per[0]+per[1]+per[2]+per[3];
            if TransP*TranspMul > AllP*TranspDiv then
              AllP:=0;
          end else
            AllP:=per[0]+per[1]+per[2]+per[3];

          if AllP<>0 then
            ColorProc(per, col, AllP, a)
          else
            a^:=NoCl;
        end else
          a^:=NoCl;
        inc(a);
      end;
    end;
end;

function RSAnyTransform32(Source:TBitmap; proc:TRSSmoothTransformProc;
           Width, Height:integer; NoCl:TColor; PreserveNoCl:Boolean;
           ColorProc:TRSTransformColorProc = nil;
           Enhance: TRSTransformEnhanceProc = nil):TBitmap; overload;
begin
  Result:= RSAnyTransform32(Source, proc, Width, Height, NoCl, PreserveNoCl,
     Rect(0,0,MaxInt,MaxInt), ColorProc, Enhance);
end;

procedure RSDrawVectorGlyph(Canvas: TCanvas; const lines: array of TRSVectorGlyphLine;
   AX, AY: ext; ScaleX: ext = 1; ScaleY: ext = Infinity);
const
  X1 = 0; Y1 = 1; X2 = 2; Y2 = 3;
var
  draw: Boolean;
  x, y, top, bottom, i: int;
  fy, v, ymin, ymax: ext;
begin
  if length(lines) = 0 then  exit;
  if IsInfinite(ScaleY) then
    ScaleY:= Sign(ScaleY)*abs(ScaleX);
  ymin:= lines[low(lines)][Y1];
  ymax:= lines[low(lines)][Y2];
  for i:= low(lines) + 1 to high(lines) do
  begin
    SetMin(ymin, lines[i][Y1]);
    SetMax(ymax, lines[i][Y2]);
  end;
  ymin:= ymin*ScaleY + AY;
  ymax:= ymax*ScaleY + AY;
  if ScaleY >= 0 then
  begin
    top:= Floor(ymin);
    bottom:= Floor(ymax);
  end else
  begin
    top:= Floor(ymax);
    bottom:= Floor(ymin);
  end;
  if ScaleY <> 0 then
    ScaleY:= 1/ScaleY;
  for y:= top to bottom do
  begin
    draw:= false;
    fy:= (y + 0.5 - AY)*ScaleY;
    for i:= low(lines) to high(lines) do
    begin
      v:= fy - lines[i][Y1];
      if (v >= 0) and (fy < lines[i][Y2]) then
      begin
        v:= v/(lines[i][Y2] - lines[i][Y1]);
        x:= Round((lines[i][X1]*(1 - v) + lines[i][X2]*v)*ScaleX + AX);
        if draw then
          Canvas.LineTo(x, y)
        else
          Canvas.MoveTo(x, y);
        draw:= not draw;
      end;
    end;
  end;
end;

end.
