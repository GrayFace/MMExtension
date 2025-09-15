unit UnitChooseKind;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, RSListView, StdCtrls, ExtCtrls, RSPanel, ImgList,
  RSSysUtils, RSLod, RSQ, CommCtrl, Math, RSGraphics, RSStrUtils, RSDefLod,
  Types;

type
  TFormChooseKind = class(TForm)
    Panel4: TRSPanel;
    Panel5: TRSPanel;
    Button1: TButton;
    Button2: TButton;
    ListView1: TRSListView;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure ListView1AdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure ListView1DataFind(Sender: TObject; Find: TItemFind;
      const FindString: string; const FindPosition: TPoint; FindData: Pointer;
      StartIndex: Integer; Direction: TSearchDirection; Wrap: Boolean;
      var Index: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListView1Data(Sender: TObject; Item: TListItem);
    procedure ListView1DblClick(Sender: TObject);
    procedure ListView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  protected
    FFirstPaint: Boolean;
    FLods, FLods2: TRSMMArchivesArray;
    FPalIndex: int;
    FItemBmp: array of TBitmap;
    FLastPath, FLastPath2: string;
    MaxW, MaxH: int;
    WorkerHandle, WorkerTask, WorkerIteration: int;
    WorkerEvent: THandle;
    procedure LoadArchives(const ArchivePath: string; var FLastPath: string; var FLods: TRSMMArchivesArray; var NoTransparency: Boolean);
    procedure DrawBavel(Canvas: TCanvas; const r: TRect; c1, c2: TColor);
    procedure LodSpritePalette(Sender: TRSLod; Name: string; var pal: int2; var Data);
    function IsTransparent(Index: int): Boolean;
    function GetLods(Index: int): TRSMMArchivesArray;
    function ResizeBitmap(b: TBitmap; Transparent: Boolean): TBitmap;
    procedure LoadBitmap(Index: int);
    procedure Worker;
    procedure StartWorker;
    procedure StopWorker;
    procedure SetWorkerTask(i: int);
    function FeedWorker: Boolean;
    procedure LVMRedrawItems(var m: TMessage); message LVM_REDRAWITEMS;
  public
    ItemCaptions: array of string;
    ItemBitmaps: array of string;
    ItemPalettes: array of int;
    ArchivePath, ArchivePath2: string;
    SelectedItem: int;
    NoTransparency, NoTransparency2: Boolean;
    SquareIcons: Boolean;
    function Open: Boolean;
  end;

var
  FormChooseKind: TFormChooseKind;
  BitmapsLods: TRSMMArchivesArray;

function LoadLods(const ss: string): TRSMMArchivesArray;
function IsThere(s1: PChar; s2: string): Boolean;

implementation

var
  EnterReaderModeHelper: function(Wnd: HWND): BOOL; stdcall;

function LoadLods(const ss: string): TRSMMArchivesArray;
var
  ps: TRSParsedString;
  i: int;
begin
  ps:= RSParseString(ss, ['|']);
  SetLength(Result, RSGetTokensCount(ps));
  for i:= 0 to RSGetTokensCount(ps) - 1 do
    Result[i]:= RSLoadMMArchive(ExpandFileName(RSGetToken(ps, i)));
end;

{function LoadLods(path: string): TRSMMArchivesArray;

  procedure Add(const s: string);
  var
    i: int;
  begin
    i:= length(Result);
    SetLength(Result, i + 1);
    Result[i]:= TRSLod.Create(s);
  end;

begin
  Add(path);
  with TRSFindFile.Create(ExtractFilePath(path) + '*.' + ExtractFileName(path)) do
    try
      while FindNextAttributes(0, FILE_ATTRIBUTE_DIRECTORY) do // Only files
        Add(FileName);
    finally
      Free;
    end;
end;}

function IsThere(s1: PChar; s2: string): Boolean; overload;
var
  i: int;
begin
  RSLodCompareStr(s1, PChar(s2), i);
  Result:= i >= length(s2);
end;

{$R *.dfm}

procedure TFormChooseKind.Button1Click(Sender: TObject);
var
  it: TListItem;
begin
  it:= ListView1.GetNextItem(nil, sdAll, [isFocused]);
  if it = nil then  exit;
  ModalResult:= mrOk;
  SelectedItem:= it.Index;
end;

procedure TFormChooseKind.DrawBavel(Canvas: TCanvas; const r: TRect; c1,
  c2: TColor);
begin
  with Canvas do
  begin
    Pen.Color:= c1;
    MoveTo(r.Right - 1, r.Top);
    LineTo(r.Left, r.Top);
    LineTo(r.Left, r.Bottom - 1);
    Pen.Color:= c2;
    LineTo(r.Right - 1, r.Bottom - 1);
    LineTo(r.Right - 1, r.Top);
  end;
end;

function TFormChooseKind.FeedWorker: Boolean;
var
  r: TRect;
  k: int;

  function Check(i: int; vis: Boolean = false): Boolean;
  var
    r1, r2: TRect;
  begin
    Result:= ItemBitmaps[i] <> '';
    if Result and vis then
    begin
      ListView_GetItemRect(ListView1.Handle, i, r1, LVIR_ICON);
      Result:= IntersectRect(r2, r1, r);
    end;
    if Result then
      SetWorkerTask(i);
  end;

  function CheckAll(vis: Boolean): Boolean;
  var
    i: int;
  begin
    Result:= true;

    for i:= 1 to max(k, high(ItemBitmaps) - k) do
      if (k + i < length(ItemBitmaps)) and Check(k + i, vis) or
         (k - i >= 0) and Check(k - i, vis) then
        exit;
    Result:= false;
  end;

begin
  Result:= Visible;
  if not Result then  exit;
  ListView_GetViewRect(ListView1.Handle, r);
  k:= max(ListView1.ItemIndex, 0);
  Result:= Check(k) or CheckAll(true) or CheckAll(false);
end;

procedure TFormChooseKind.FormCreate(Sender: TObject);
var
  space: DWORD;
  h: int;
begin
  with ListView1.Canvas do
  begin
    Font:= ListView1.Font;
    h:= TextHeight('W');
  end;
  space:= ListView_GetItemSpacing(ListView1.Handle, 0);
  ListView_SetIconSpacing(ListView1.Handle, word(space), HiWord(space) + h - 5);
end;

procedure TFormChooseKind.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Button2.Click;
end;

procedure TFormChooseKind.FormPaint(Sender: TObject);
begin
  if FFirstPaint then
  begin
    ListView1.SetFocus;
    ListView_SetItemState(ListView1.Handle, SelectedItem,
       LVIS_SELECTED or LVIS_FOCUSED, LVIS_SELECTED or LVIS_FOCUSED);
    ListView_EnsureVisible(ListView1.Handle, SelectedItem, false);
    FFirstPaint:= false;
    StartWorker;
  end;
end;

procedure TFormChooseKind.FormShow(Sender: TObject);
begin
  FFirstPaint:= true;
end;

function TFormChooseKind.GetLods(Index: int): TRSMMArchivesArray;
begin
  if (ArchivePath2 <> '') and (ItemPalettes[Index] < 0) then
    Result:= FLods2
  else
    Result:= FLods;
end;

function TFormChooseKind.IsTransparent(Index: int): Boolean;
begin
  if (ArchivePath2 <> '') and (ItemPalettes[Index] < 0) then
    Result:= not NoTransparency2
  else
    Result:= not NoTransparency;
end;

procedure TFormChooseKind.ListView1AdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
const
  bit = LVIS_FOCUSED;
var
  r: TRect;
  bmp: TBitmap;
  c: TColor;
  w, h: int;
begin
  if Stage <> cdPostPaint then  exit;
  with Sender, Canvas do
  begin
    r:= Item.DisplayRect(drIcon);
    MaxW:= r.Right - r.Left - 6;
    MaxH:= r.Bottom - r.Top - 6;
    if SquareIcons then
      MaxH:= MaxW; // for Choose Map dialog
    bmp:= FItemBmp[Item.Index];
    c:= ColorToRGB(ListView1.Color);
    if ListView_GetItemState(Sender.Handle, Item.Index, bit) and bit <> 0 then
    begin
      inc(r.Bottom);
      DrawBavel(Canvas, r, clBlack, clBlack);
      inc(r.Top);  inc(r.Left);  dec(r.Right);  dec(r.Bottom);
      DrawBavel(Canvas, r, clBtnHighlight, clBtnShadow);
      inc(r.Top);  inc(r.Left);  dec(r.Right);  dec(r.Bottom);
      DrawBavel(Canvas, r, clBtnHighlight, clBtnShadow);
      inc(r.Top);  inc(r.Left);  dec(r.Right);  dec(r.Bottom);
      Brush.Color:= clBtnFace;
      FillRect(r);
      c:= ColorToRGB(clBtnFace);
    end;
    if bmp <> nil then
    begin
      if IsTransparent(Item.Index) then
        SetDIBColorTable(bmp.Canvas.Handle, 0, 1, c);
      w:= min(r.Right - r.Left, bmp.Width);
      h:= min(r.Bottom - r.Top, bmp.Height);
      BitBlt(Handle, (r.Left + r.Right - w) div 2, r.Bottom - h, w, h,
         bmp.Canvas.Handle, (bmp.Width - w) div 2, bmp.Height - h, SRCCOPY);
    end;
  end;
end;

procedure TFormChooseKind.ListView1Data(Sender: TObject; Item: TListItem);
begin
  Item.Caption:= ItemCaptions[Item.Index];
end;

procedure TFormChooseKind.ListView1DataFind(Sender: TObject; Find: TItemFind;
  const FindString: string; const FindPosition: TPoint; FindData: Pointer;
  StartIndex: Integer; Direction: TSearchDirection; Wrap: Boolean;
  var Index: Integer);
var
  i: int;
begin
  if StartIndex >= length(ItemCaptions) then
    StartIndex:= 0;
  for i := StartIndex to length(ItemCaptions) - 1 do
    if IsThere(PChar(ItemCaptions[i]), FindString) then
    begin
      Index:= i;
      exit;
    end;
  for i := 0 to StartIndex - 1 do
    if IsThere(PChar(ItemCaptions[i]), FindString) then
    begin
      Index:= i;
      exit;
    end;
end;

procedure TFormChooseKind.ListView1DblClick(Sender: TObject);
begin
  Button1.Click;
end;

procedure TFormChooseKind.ListView1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_RETURN) and (Shift=[]) then
    Button1.Click;
end;

procedure TFormChooseKind.ListView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button=mbMiddle) and (@EnterReaderModeHelper<>nil) then
    EnterReaderModeHelper(ListView1.Handle);
end;

procedure TFormChooseKind.LoadArchives(const ArchivePath: string;
  var FLastPath: string; var FLods: TRSMMArchivesArray;
  var NoTransparency: Boolean);
var
  i: int;
begin
  if (FLastPath <> '') and (ArchivePath <> FLastPath) then
    RSMMArchivesFree(FLods);

  if ArchivePath = '' then
  begin
    FLods:= BitmapsLods
  end else
    if (FLastPath = '') or (FLods = nil) then
    begin
      FLods:= LoadLods(ArchivePath);
      for i := 0 to high(FLods) do
      begin
        TRSLod(FLods[i]).BitmapsLods:= BitmapsLods;
        TRSLod(FLods[i]).OnSpritePalette:= LodSpritePalette;
      end;
    end;

  FLastPath:= ArchivePath;
  NoTransparency:= NoTransparency or (TRSLod(FLods[0]).Version = RSLodBitmaps);
end;

procedure TFormChooseKind.LoadBitmap(Index: int);
var
  Lod: TRSMMArchive;
  Lods: TRSMMArchivesArray;
  arr: TRSByteArray;
  b: TBitmap;
  s: string;
  i: int;
begin
  s:= ItemBitmaps[Index];
  Lods:= GetLods(Index);
  if (FItemBmp[Index] = nil) and (s <> '') then
    if RSMMArchivesFind(Lods, s, Lod, i) or (TRSLod(Lods[0]).Version = RSLodSprites) and
       RSMMArchivesFind(Lods, s + '0', Lod, i) then
    begin
      FPalIndex:= ItemPalettes[Index];
      b:= Lod.ExtractArrayOrBmp(i, arr);
      if b = nil then  exit;
      FItemBmp[Index]:= ResizeBitmap(b, IsTransparent(Index));
    end;
  // LParam has special meaning here
  PostMessage(Handle, LVM_REDRAWITEMS, Index, WorkerIteration);
end;

procedure TFormChooseKind.LodSpritePalette(Sender: TRSLod; Name: string;
  var pal: int2; var Data);
begin
  pal:= FPalIndex;
end;

procedure TFormChooseKind.LVMRedrawItems(var m: TMessage);
begin
  if m.LParam <> WorkerIteration then  exit;  // leftover redraw message
  ItemBitmaps[m.WParam]:= '';
  if not FeedWorker then
    SetWorkerTask(-1);
  if Visible and (FItemBmp <> nil) then
    ListView1.Perform(LVM_REDRAWITEMS, m.WParam, m.WParam);
end;

function TFormChooseKind.Open: Boolean;
var
  i: int;
begin
  StopWorker;
  LoadArchives(ArchivePath, FLastPath, FLods, NoTransparency);
  LoadArchives(ArchivePath2, FLastPath2, FLods2, NoTransparency2);
  for i := 0 to length(FItemBmp) - 1 do
    FItemBmp[i].Free;
  FItemBmp:= nil;
  SetLength(FItemBmp, length(ItemCaptions));

  ListView1.Items.Count:= 0;
  ListView1.Items.Clear;
  ListView1.Items.Count:= length(ItemCaptions);

  Result:= (ShowModal = mrOk);
  ImageList1.Clear;
  NoTransparency:= false;
  NoTransparency2:= false;
  SquareIcons:= false;
  ArchivePath2:= '';
end;

procedure DoMyStretchBlt(dest, src: TBitmap; const r: TRect; sz: int); inline;
var
  p, pd, ps, ps0, dd, ds: IntPtr;
  x, y, wd, hd, ws, hs: int;
begin
  wd:= dest.Width;
  hd:= dest.Height;
  ws:= RectW(r);
  hs:= RectH(r);
  pd:= IntPtr(dest.ScanLine[hd - 1]);
  dd:= IntPtr(dest.ScanLine[max(0, hd - 2)]) - pd - wd*sz;
  ps0:= IntPtr(src.ScanLine[r.Bottom - 1]);
  ds:= IntPtr(src.ScanLine[max(0, r.Bottom - 2)]) - ps0;
  inc(ps0, r.Left*sz);
  for y:= 0 to hd - 1 do
  begin
    ps:= ps0 + ((1 + y*2)*hs div (hd*2))*ds;
    for x:= 0 to wd - 1 do
    begin
      p:= ps + ((1 + x*2)*ws div (wd*2))*sz;
      case sz of
        1: pbyte(pd)^:= pbyte(p)^;
        2: pword(pd)^:= pword(p)^;
        4: pint(pd)^:= pint(p)^;
        3:
        begin
          pword(pd)^:= pword(p)^;
          pbyte(pd+2)^:= pbyte(p+2)^;
        end;
      end;
      inc(pd, sz);
    end;
    inc(pd, dd);
  end;
end;

procedure MyStretchBlt(dest, src: TBitmap; const SrcRect: TRect);
begin
  case RSGetPixelFormat(dest) of
    pf8bit:
      DoMyStretchBlt(dest, src, SrcRect, 1);
    pf15bit, pf16bit:
      DoMyStretchBlt(dest, src, SrcRect, 2);
    pf24bit:
      DoMyStretchBlt(dest, src, SrcRect, 3);
    pf32bit:
      DoMyStretchBlt(dest, src, SrcRect, 4);
    else
      Assert(false);
  end;
end;

// always destroys 'b'
function TFormChooseKind.ResizeBitmap(b: TBitmap; Transparent: Boolean): TBitmap;
var
  r: TRect;
  w, h, w2, h2: int;
begin
  w:= b.Width;
  h:= b.Height;
  Result:= b;
  if (w <= MaxW) and (h <= MaxH) or (w = 0) or (h = 0) then  exit;
  Result:= nil;
  try
    // crop
    if Transparent then
    begin
      r:= RSGetNonZeroColorRect(b);
      r.Bottom:= (3*r.Bottom + h + 2) div 4;  // always keep some vertical space
      if w <= MaxW then
      begin
        r.Left:= 0;
        r.Right:= w;
      end else
      if h <= MaxH then
      begin
        r.Top:= 0;
        r.Bottom:= h;
      end;
      w:= RectW(r);
      if max(w, MaxW)*MaxH > (r.Bottom - r.Top)*MaxW then
        r.Bottom:= min(r.Top + max(w, MaxW)*MaxH div MaxW, h);
      h:= RectH(r);
    end else
      r:= Rect(0, 0, w, h);
    // scale
    if (w <= MaxW) and (h <= MaxH) then
    begin
      w2:= w;
      h2:= h;
    end
    else if w*MaxH > h*MaxW then
    begin
      w2:= MaxW;
      h2:= (h*MaxW + w div 2) div w;
    end else
    begin
      w2:= (w*MaxH + h div 2) div h;
      h2:= MaxH;
    end;

    Result:= TBitmap.Create;
    Result.HandleType:= bmDIB;
    Result.PixelFormat:= RSGetPixelFormat(b);
    Result.Palette:= b.ReleasePalette;
    Result.Width:= w2;
    Result.Height:= h2;
    // has to be done manually, because GDI drawing doesn't work in worker thread
    MyStretchBlt(Result, b, r);
  except
    FreeAndNil(Result);
  end;
  b.Free;
end;

procedure TFormChooseKind.SetWorkerTask(i: int);
begin
  InterlockedExchange(WorkerTask, i);
  SetEvent(WorkerEvent);
end;

procedure TFormChooseKind.StartWorker;
begin
  if WorkerEvent = 0 then
    WorkerEvent:= RSWin32Check(CreateEvent(nil, false, false, nil))
  else if WorkerHandle <> 0 then
    StopWorker;
  if FeedWorker then
    RSRunThread(@TFormChooseKind.Worker, [self, nil], @WorkerHandle);
end;

procedure TFormChooseKind.StopWorker;
begin
  if WorkerHandle <> 0 then
  begin
    SetWorkerTask(-1);
    WaitForSingleObject(WorkerHandle, INFINITE);
    CloseHandle(WorkerHandle);
    WorkerHandle:= 0;
    inc(WorkerIteration);
  end;
end;

procedure TFormChooseKind.Worker;
var
  i: int;
begin
  while WaitForSingleObject(WorkerEvent, INFINITE) = WAIT_OBJECT_0 do
  begin
    i:= WorkerTask;
    if i < 0 then  break;
    LoadBitmap(i);
  end;
end;

initialization
  RSLoadProc(@EnterReaderModeHelper, user32, 'EnterReaderModeHelper');

end.
