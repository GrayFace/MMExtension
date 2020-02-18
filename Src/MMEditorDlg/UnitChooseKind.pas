unit UnitChooseKind;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, RSListView, StdCtrls, ExtCtrls, RSPanel, ImgList,
  RSSysUtils, RSLod, RSQ, CommCtrl, Math, RSGraphics, RSStrUtils, RSDefLod;

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
    procedure Button2Click(Sender: TObject);
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
    FBmpResized: array of Boolean;
    FLastPath, FLastPath2: string;
    MaxW, MaxH: int;
    WorkerHandle: int;
    BitmapsLeft: int;
    procedure LoadArchives(const ArchivePath: string; var FLastPath: string; var FLods: TRSMMArchivesArray; var NoTransparency: Boolean);
    procedure DrawBavel(Canvas: TCanvas; const r: TRect; c1, c2: TColor);
    procedure LodSpritePalette(Sender: TRSLod; Name: string; var pal: int2; var Data);
    function NeedTransparent(Index: int; var Transparent: Boolean): TRSMMArchivesArray;
    function NeedBitmap(Index: int; var Transparent: Boolean): TBitmap;
    procedure ResizeBitmap(b: TBitmap; Transparent: Boolean);
    procedure LoadBitmap(Index: int);
    procedure Worker;
    procedure StartWorker;
    procedure StopWorker;
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
//  ListView1.
  SelectedItem:= it.Index;
end;

procedure TFormChooseKind.Button2Click(Sender: TObject);
begin
  Close;
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

procedure TFormChooseKind.ListView1AdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
const
  bit = LVIS_FOCUSED;
var
  r: TRect;
  bmp: TBitmap;
  c: TColor;
  Transparent: Boolean;
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
    bmp:= NeedBitmap(Item.Index, Transparent);
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
      if Transparent then
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
  Transparent: Boolean;
  Lod: TRSMMArchive;
  Lods: TRSMMArchivesArray;
  arr: TRSByteArray;
  s: string;
  i: int;
begin
  s:= ItemBitmaps[Index];
  ItemBitmaps[Index]:= '';
  Lods:= NeedTransparent(Index, Transparent);
  if (FItemBmp[Index] = nil) and (s <> '') then
    if RSMMArchivesFind(Lods, s, Lod, i) or (TRSLod(Lods[0]).Version = RSLodSprites) and
       RSMMArchivesFind(Lods, s + '0', Lod, i) then
      try
        FPalIndex:= ItemPalettes[Index];
        FItemBmp[Index]:= Lod.ExtractArrayOrBmp(i, arr);
        if FItemBmp[Index] <> nil then
          ListView_RedrawItems(ListView1.Handle, Index, Index);
      except
      end;
end;

procedure TFormChooseKind.LodSpritePalette(Sender: TRSLod; Name: string;
  var pal: int2; var Data);
begin
  pal:= FPalIndex;
end;

function TFormChooseKind.NeedBitmap(Index: int; var Transparent: Boolean): TBitmap;
begin
  NeedTransparent(Index, Transparent);
  Result:= FItemBmp[Index];
  if (Result <> nil) and not FBmpResized[Index] then
    ResizeBitmap(FItemBmp[Index], Transparent);
end;

function TFormChooseKind.NeedTransparent(Index: int;
  var Transparent: Boolean): TRSMMArchivesArray;
begin
  if (ArchivePath2 <> '') and (ItemPalettes[Index] < 0) then
  begin
    Result:= FLods2;
    Transparent:= not NoTransparency2;
  end else
  begin
    Result:= FLods;
    Transparent:= not NoTransparency;
  end;
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
  FBmpResized:= nil;
  SetLength(FBmpResized, length(ItemCaptions));

  ListView1.Items.Count:= 0;
  ListView1.Items.Clear;
  ListView1.Items.Count:= length(ItemCaptions);

  Result:= ShowModal = mrOk;
  InterlockedExchange(BitmapsLeft, 0);
  ImageList1.Clear;
  NoTransparency:= false;
  NoTransparency2:= false;
  SquareIcons:= false;
  ArchivePath2:= '';
end;

procedure TFormChooseKind.ResizeBitmap(b: TBitmap; Transparent: Boolean);
var
  r: TRect;
  w, h: int;
begin
  w:= b.Width;
  h:= b.Height;
  if (w <= MaxW) and (h <= MaxH) then  exit;
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
    w:= r.Right - r.Left;
    if max(w, MaxW)*MaxH > (r.Bottom - r.Top)*MaxW then
      r.Bottom:= min(r.Top + max(w, MaxW)*MaxH div MaxW, h);
    h:= r.Bottom - r.Top;
    if (w < b.Width) or (h < b.Height) then
    begin
      b.Canvas.CopyRect(Rect(0, 0, w, h), b.Canvas, r);
      b.Height:= h;
      b.Width:= w;
    end;
    if (w <= MaxW) and (h <= MaxH) then  exit;
  end;
  // scale
  if w*MaxH > h*MaxW then
    r:= Rect(0, 0, MaxW, (h*MaxW + w div 2) div w)
  else
    r:= Rect(0, 0, (w*MaxH + h div 2) div h, MaxH);

  SetStretchBltMode(b.Canvas.Handle, BLACKONWHITE);
  b.Canvas.StretchDraw(r, b);
  b.Height:= r.Bottom;
  b.Width:= r.Right;
end;

procedure TFormChooseKind.StartWorker;
begin
  InterlockedExchange(BitmapsLeft, length(ItemBitmaps));
  RSRunThread(@TFormChooseKind.Worker, [self, nil], @WorkerHandle);
end;

procedure TFormChooseKind.StopWorker;
begin
  if WorkerHandle <> 0 then
  begin
    WaitForSingleObject(WorkerHandle, INFINITE);
    CloseHandle(WorkerHandle);
    WorkerHandle:= 0;
  end;
end;

procedure TFormChooseKind.Worker;
var
  h: HWND;
  r: TRect;
  k: int;

  function Check(i: int; vis: Boolean = false): Boolean;
  var
    r1, r2: TRect;
  begin
    Result:= ItemBitmaps[i] <> '';
    if Result and vis then
    begin
      ListView_GetItemRect(h, i, r1, LVIR_ICON);
      Result:= IntersectRect(r2, r1, r);
    end;
    if Result then
      LoadBitmap(i);
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
  h:= ListView1.Handle;
  while InterlockedDecrement(BitmapsLeft) >= 0 do
  begin
    ListView_GetViewRect(h, r);
    k:= max(ListView1.ItemIndex, 0);
    if Check(k) or CheckAll(true) or CheckAll(false) then;
  end;
end;

initialization
  RSLoadProc(@EnterReaderModeHelper, user32, 'EnterReaderModeHelper');

end.
