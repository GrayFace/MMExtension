unit RSImgList;

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

uses Windows, Classes, SysUtils, Graphics, Math, RSQ, ImgList, CommCtrl,
  RSGraphics;

function RSImgListToBmp(il:TCustomImageList; Index:int; Bmp:TBitmap=nil):TBitmap;

procedure RSUpscaleImgList(il:TCustomImageList; w, h: int);

implementation

const
  MyTransCl = $E900F6;

//type
//  TImageListHack = class(TCustomImageList)
//  end;

//function GetRGBColor(Value: TColor): DWORD;
//begin
//  Result := ColorToRGB(Value);
//  case Result of
//    clNone: Result := CLR_NONE;
//    clDefault: Result := CLR_DEFAULT;
//  end;
//end;

procedure MyGetImages(il: TCustomImageList; Index: Integer; Image, Mask: TBitmap);
var
  R: TRect;
begin
  with il do
  begin
    R := Rect(0, 0, Width, Height);
    with Image.Canvas do
    begin
      Brush.Color:= MyTransCl;
      FillRect(R);
      ImageList_Draw(il.Handle, Index, Handle, 0, 0, ILD_NORMAL);
    end;
    with Mask.Canvas do
    begin
      Brush.Color := clWhite;
      FillRect(R);
      ImageList_Draw(il.Handle, Index, Handle, 0, 0, ILD_MASK);
    end;
  end;
end;

function RSImgListToBmp(il:TCustomImageList; Index:int;  Bmp:TBitmap=nil):TBitmap;
var
//  r: TRect;
  b: TBitmap;
begin
  Result:= Bmp;
  if Bmp<>nil then
    Result.Height:= 0
  else
    Result:= TBitmap.Create;
  b:= nil;

  with Result do
  try
    Width:= il.Width;
    Height:= il.Height;

    b:= TBitmap.Create;
    b.Monochrome:= true;
    b.HandleType:= bmDIB;
    b.Handle:= MaskHandle;
    MyGetImages(il, Index, Result, b);
    Transparent:= true;
    TransparentColor:= MyTransCl;
    MaskHandle:= b.ReleaseHandle;

//    Brush.Color := $FF00F6;
//    r:= Rect(0, 0, Width, Height);
//    FillRect(r);
//    ImageList_Draw(il.Handle, Index, Canvas.Handle, 0, 0, ILD_NORMAL);
////    il.Draw(Canvas, 0, 0, Index);
//    Transparent:= true;
//    b:= TBitmap.Create;
//    b.HandleType:= bmDIB;
//    b.Handle:= MaskHandle;
//    b.Canvas.Brush.Color:= clWhite;
//    b.Canvas.FillRect(r);
//    ImageList_Draw(il.Handle, Index, b.Canvas.Handle, 0, 0, ILD_MASK);
//    MaskHandle:= b.ReleaseHandle;

    Bmp:= Result;
  finally
    b.Free;
    if Bmp = nil then
      Result.Free;
  end;
end;

procedure RSUpscaleImgList(il: TCustomImageList; w, h: int);
var
  a: array of array[0..1] of TBitmap;
  Enhancer: TRSTransformEnhancer;
  b: TBitmap;
  partial: Boolean;
  i, j, w0, h0, cl: int;
begin
  w0:= il.Width;
  h0:= il.Height;
  if not (w > w0) and not (h > h0) or (w < w0) or (h < h0) then  exit;
  partial:= (w0 > 0) and (w mod w0 <> 0) or (h0 > 0) and (h mod h0 <> 0);
  Enhancer:= RSTransformEnhancer(50);
  Enhancer.Reuse:= true;
  SetLength(a, il.Count);
  try
    // create
    for i:= 0 to high(a) do
      for j:= 0 to 1 do
      begin
        a[i][j]:= TBitmap.Create;
        if partial and (j = 0) then
        begin
          a[i][j].Width:= w0;
          a[i][j].Height:= h0;
        end else
        begin
          a[i][j].Width:= w;
          a[i][j].Height:= h;
        end;
      end;
    // get
    for i:= 0 to high(a) do
      MyGetImages(il, i, a[i][0], a[i][1]);
    // upscale
    for i:= 0 to high(a) do
      for j:= 0 to 1 do
        if partial then
        begin
          b:= a[i][j];
          cl:= MyTransCl;
          if j = 1 then
            cl:= clWhite;
          a[i][j]:= RSTransform32(b, RSXForm(w/w0, h/h0), cl,
             true, RSTransformSmoothProc(), Enhancer.Get());
          b.Free;
        end else
          with a[i][j], Canvas do
            CopyRect(Rect(0, 0, w, h), Canvas, Rect(0, 0, w0, h0));
    // add
    il.Clear;
    il.Width:= w;
    il.Height:= h;
    for i:= 0 to high(a) do
      il.Add(a[i][0], a[i][1]);
  finally
    // delete
    for i:= 0 to high(a) do
      for j:= 0 to 1 do
        a[i][j].Free;
  end;
end;

end.
