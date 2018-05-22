unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, RSSpeedButton, ExtCtrls, RSQ, RSSysUtils, RSStrUtils,
  StdCtrls, RSLabel, RSSpinEdit, RSListBox, UnitChooseKind, RSLod,
  Types, Menus, RSGraphics, pngimage, Math;

type
  TMyCallback = function(cmd: PChar; params: ptr = nil): int; stdcall;
  TMyCreateIndex = (ciSprite, ciLight, ciSpawn, ciItem, ciMonster);

  TForm1 = class(TForm)
    BtnOpen: TRSSpeedButton;
    BtnSave: TRSSpeedButton;
    BtnImport: TRSSpeedButton;
    Timer1: TTimer;
    BtnExport: TRSSpeedButton;
    BtnSaveAs: TRSSpeedButton;
    BtnLoadBlv: TRSSpeedButton;
    PanelFacet: TPanel;
    Bevel1: TBevel;
    BtnEditFacet: TRSSpeedButton;
    OpenDatDialog: TOpenDialog;
    SaveDatDialog: TSaveDialog;
    OpenObjDialog: TOpenDialog;
    SaveObjDialog: TSaveDialog;
    BtnCompile: TRSSpeedButton;
    BtnSelectSameTexture: TRSSpeedButton;
    BtnSelectObject: TRSSpeedButton;
    SaveBlvDialog: TSaveDialog;
    BtnNewDoor: TRSSpeedButton;
    BtnEditDoor: TRSSpeedButton;
    BtnSelectDoor: TRSSpeedButton;
    BtnChangeDoorShape: TRSSpeedButton;
    BtnEditRoom: TRSSpeedButton;
    BtnShowInvisible: TRSSpeedButton;
    BtnChangeTexture: TRSSpeedButton;
    PanelSprite: TPanel;
    Bevel2: TBevel;
    BtnEditObject: TRSSpeedButton;
    BtnEditKind: TRSSpeedButton;
    BtnDoorState: TRSSpeedButton;
    BtnNew: TRSSpeedButton;
    BtnContinue: TRSSpeedButton;
    PanelNone: TPanel;
    Bevel3: TBevel;
    BtnNewSprite: TRSSpeedButton;
    BtnNewMonster: TRSSpeedButton;
    BtnNewItem: TRSSpeedButton;
    BtnNewSpawn: TRSSpeedButton;
    BtnNewLight: TRSSpeedButton;
    BtnDeselect: TRSSpeedButton;
    BtnNoDark: TRSSpeedButton;
    BtnDiscard: TRSSpeedButton;
    BtnShowPortals: TRSSpeedButton;
    BtnImportObjects: TRSSpeedButton;
    BtnDeselect2: TRSSpeedButton;
    BtnDelete: TRSSpeedButton;
    BtnClone: TRSSpeedButton;
    BtnDeleteDoor: TRSSpeedButton;
    BtnResetDoors: TRSSpeedButton;
    BtnCreate: TRSSpeedButton;
    BtnNewKind: TRSSpeedButton;
    BtnMoveToParty: TRSSpeedButton;
    BtnLand: TRSSpeedButton;
    PanelChests: TPanel;
    Bevel4: TBevel;
    BtnTestChest: TRSSpeedButton;
    BtnDeleteChest: TRSSpeedButton;
    BtnChests: TRSSpeedButton;
    BtnEditChest: TRSSpeedButton;
    ListChests: TRSListBox;
    BtnAlignX: TRSSpeedButton;
    BtnAlignY: TRSSpeedButton;
    BtnAlignZ: TRSSpeedButton;
    BtnUndo: TRSSpeedButton;
    BtnRedo: TRSSpeedButton;
    BtnMonItem: TRSSpeedButton;
    PanelGround: TPanel;
    Bevel5: TBevel;
    BtnTiles: TRSSpeedButton;
    BtnHeight: TRSSpeedButton;
    BtnGround: TRSSpeedButton;
    BtnDeselect3: TRSSpeedButton;
    PanelHeight: TPanel;
    EditBrushSize: TRSSpinEdit;
    Label1: TLabel;
    BtnHeightMode1: TRSSpeedButton;
    BtnHeightMode2: TRSSpeedButton;
    BtnHeightMode5: TRSSpeedButton;
    BtnHeightMode3: TRSSpeedButton;
    BtnHeightMode4: TRSSpeedButton;
    BtnHeightMode6: TRSSpeedButton;
    PanelTiles: TPanel;
    BtnTileset1: TRSSpeedButton;
    BtnTileset2: TRSSpeedButton;
    BtnTileset3: TRSSpeedButton;
    BtnRoad: TRSSpeedButton;
    BtnRoadDiag: TRSSpeedButton;
    BtnChangeTilesFile: TRSSpeedButton;
    BtnChangeTileset: TRSSpeedButton;
    BtnTileset0: TRSSpeedButton;
    Label2: TLabel;
    EditBrushSpeed: TRSSpinEdit;
    PopupTilesFile: TPopupMenu;
    ItemTile1: TMenuItem;
    ItemTile2: TMenuItem;
    ItemTile3: TMenuItem;
    BtnAutoLand: TRSSpeedButton;
    BtnEditMapProps: TRSSpeedButton;
    Timer2: TTimer;
    BtnSelectSameSprite: TRSSpeedButton;
    BtnModelMode1: TRSSpeedButton;
    BtnModelMode2: TRSSpeedButton;
    BtnSaveModel: TRSSpeedButton;
    OpenModelDialog: TOpenDialog;
    SaveModelDialog: TSaveDialog;
    BtnExportSelected: TRSSpeedButton;
    BtnSaveHeightMap: TRSSpeedButton;
    BtnLoadHeightMap: TRSSpeedButton;
    OpenBmpDialog: TOpenDialog;
    SaveBmpDialog: TSaveDialog;
    BtnSelectAll: TRSSpeedButton;
    BtnUpdateBSP: TRSSpeedButton;
    procedure ListChestsWndProc(Sender: TObject; var m: TMessage;
      var Handled: Boolean; const NextWndProc: TWndMethod);
    procedure BtnSaveHeightMapClick(Sender: TObject);
    procedure BtnLoadHeightMapClick(Sender: TObject);
    procedure SaveModelDialogTypeChange(Sender: TObject);
    procedure OpenDatDialogTypeChange(Sender: TObject);
    procedure BtnSaveModelClick(Sender: TObject);
    procedure BtnModelMode1Click(Sender: TObject);
    procedure BtnAutoLandClick(Sender: TObject);
    procedure BtnSkyTextureClick(Sender: TObject);
    procedure BtnTileset1Paint(Sender: TRSSpeedButton;
      DefaultPaint: TRSProcedure; var State: TButtonState;
      var MouseInControl: Boolean; MouseReallyInControl: Boolean);
    procedure ItemTile1Click(Sender: TObject);
    procedure BtnChangeTilesFileClick(Sender: TObject);
    procedure EditBrushSpeedChange(Sender: TObject);
    procedure BtnDeselect3Click(Sender: TObject);
    procedure BtnChangeTilesetClick(Sender: TObject);
    procedure EditBrushSizeChange(Sender: TObject);
    procedure BtnTileset1Click(Sender: TObject);
    procedure BtnHeightMode1Click(Sender: TObject);
    procedure BtnTilesClick(Sender: TObject);
    procedure BtnGroundClick(Sender: TObject);
    procedure BtnMonItemClick(Sender: TObject);
    procedure BtnNewLightClick(Sender: TObject);
    procedure BtnNewSpriteClick(Sender: TObject);
    procedure BtnNewKindClick(Sender: TObject);
    procedure BtnEditKindClick(Sender: TObject);
    procedure BtnUndoClick(Sender: TObject);
    procedure BtnTestChestClick(Sender: TObject);
    procedure BtnEditChestClick(Sender: TObject);
    procedure BtnDeleteChestClick(Sender: TObject);
    procedure BtnChestsClick(Sender: TObject);
    procedure BtnCompileClick(Sender: TObject);
    procedure BtnContinueClick(Sender: TObject);
    procedure BtnChangeTextureClick(Sender: TObject);
    procedure BtnLoadBlvClick(Sender: TObject);
    procedure BtnCreateClick(Sender: TObject);
    procedure BtnDeselectClick(Sender: TObject);
    procedure SimpleBtnDblWndProc(Sender: TObject; var m: TMessage;
      var Handled: Boolean; const NextWndProc: TWndMethod);
    procedure BtnNewClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SimpleBtnClick(Sender: TObject);
    procedure BtnExportClick(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnSaveAsClick(Sender: TObject);
    procedure BtnOpenClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  protected
    BitmapsLod: TRSLod;
    GamesLods: TRSMMArchivesArray;
    TileBitmaps: array[0..5] of TBitmap;
    Scaling: Boolean;

    function SafeExecute(dlg: TCommonDialog): Boolean;
    procedure Pause(AOn: Boolean);
    function FileNameCallback(cmd: PChar; params: ptr = nil): string;
    procedure LoadMapNames;
    function Confirm: Boolean;
    function GetCreateIndex: TMyCreateIndex;
    function DoChooseKind(ps: TRSParsedString; var Index: int; Fmt: string = '%s%s'): Boolean;
    function FindKindIndex(ps: TRSParsedString; const Name: string): int;
    function ChooseKind(ps: TRSParsedString; var Index: int; sk: int): Boolean; overload;
    function ChooseKind(ps: TRSParsedString; var Name: string; sk: int): Boolean; overload;
    procedure ChooseBlv;
    procedure LoadTileBitmaps;
    procedure ParseFilter(const s: string; var Arr);
    procedure LoadModel;
    procedure SimpleCommand(Sender: TObject; param: ptr);

    procedure CNChar(var m: TWMChar); message CN_CHAR;
    procedure WMPaint(var m: TMessage); message WM_PAINT;
    procedure WNSysKeyDown(var m: TWMKeyDown); message WM_SYSKEYDOWN;
  public
    DatFilters: array[Boolean] of string;
    BlvFilters: array[Boolean] of string;
    IsD3D: Boolean;
    MMVersion: int;
    Editable: Boolean;
    Outdoor: Boolean;
    StateLoaded: Boolean;
    StateSync: Boolean;
    SelKind: int;
    SelSubKind: int;
    ModelChosen: Boolean;
    MapNames, MapPics: TStringList;
    procedure UpdatePanels;
    procedure UpdateChests;
    procedure UpdatePosition;
  end;

const
  skNone = 0;
  skSpawn = 1;
  skObject = 2;
  skMonster = 3;
  skSprite = 5;
  skFacet = 6;
  skLight = 7;
  skModel = 8;
  CreateSelKind: array[TMyCreateIndex] of int = (
    skSprite, skLight, skSpawn, skObject, skMonster
  );
  DatDefExt: array[Boolean] of string = ('.dat', '.odt');
  BlvDefExt: array[Boolean] of string = ('.blv', '.odm');

var
  Form1: TForm1;
  MainWnd: HWND;
  Callback: TMyCallback;
  CreateKinds: array[TMyCreateIndex] of int = (-1, -1, 0, 0, 0);
  CreateSpriteName: string = 'Party Start';

implementation

{$R *.dfm}

function Ref(s: string): ptr;
var
  ps: ptr absolute s;
begin
  Result:= ps;
  ps:= nil;
end;

function GetLodsList(const name: string): string;
begin
  Result:= PChar(callback('GetLodsList', ptr(name)));
  if Result = '' then
  begin
    Result:= 'Data\' + name + '.lod';
    with TRSFindFile.Create('Data\' + '*.' + name + '.lod') do
      try
        while FindNextAttributes(0, FILE_ATTRIBUTE_DIRECTORY) do // Only files
          Result:= Result + ('|Data\' + Data.cFileName);
      finally
        Free;
      end;
  end;
end;

// hack through resources, because there is no other way
procedure MakeScaled;
var
  h: THandle;
  p: PChar;

  function Find(const s: string): PChar;
  begin
    Result:= p;
    while not CompareMem(Result, ptr(s), length(s)) do
      inc(Result);
    inc(Result, length(s));
  end;

  procedure Change(p: PChar; v: char);
  var
    OldProtect: DWord;
  begin
    VirtualProtect(ptr(p), 1, PAGE_READWRITE, @OldProtect);
    p^:= v;
    VirtualProtect(ptr(p), 1, OldProtect, @OldProtect);
  end;

begin
  h:= FindResource(HInstance, 'TFORM1', RT_RCDATA);
  p:= LockResource(LoadResource(HInstance, h));
  Change(Find(#6'Scaled'), Find(#7'Visible')^); // requires Visible = true
  Change(Find(#13'PixelsPerInch') + 1, #96);
end;

procedure StartEditor(wnd: HWND; callbak: TMyCallback; d3d: Bool; mmver: int); stdcall;
var
  r: TRect;
begin
  MainWnd:= wnd;
  Callback:= callbak;
  if Form1 = nil then
  begin
    GetClientRect(wnd, r);
    if r.Bottom > 480 then
      MakeScaled;
    Application.Initialize;
    Application.Handle:= wnd;
    Application.CreateForm(TForm1, Form1);
    Application.CreateForm(TFormChooseKind, FormChooseKind);
    pptr(@Application.MainForm)^:= nil;
    callback('SetMapsDir', PChar(Form1.OpenDatDialog.InitialDir));
    BitmapsLods:= LoadLods(GetLodsList('Bitmaps'));
  end else
  begin
    Form1.Show;
  end;
  Form1.IsD3D:= d3d;
  Form1.MMVersion:= mmver;
  BringWindowToTop(MainWnd);
end;

procedure CloseEditor; stdcall;
begin
  if Form1 <> nil then
    Form1.Close;
end;

procedure SetStateLoaded(ok, sync, edit, odoor: Bool); stdcall;
begin
  if Form1 = nil then  exit;

  with Form1 do
  begin
    StateLoaded:= ok;
    StateSync:= sync;
    Outdoor:= odoor;
    Editable:= edit;
    BtnSave.Enabled:= ok;
    BtnSaveAs.Enabled:= ok;
    BtnNew.Enabled:= ok or odoor;
    BtnCompile.Enabled:= ok and edit;
    if odoor then
      BtnImportObjects.Caption:= 'Import'
    else
      BtnImportObjects.Caption:= 'Import'#13#10'Objects';
    BtnImport.Visible:= not odoor;
    BtnExportSelected.Visible:= odoor;
    BtnExport.Enabled:= ok or edit;
    BtnShowPortals.Enabled:= not odoor and IsD3D and edit;
    BtnShowPortals.Visible:= IsD3D;
    BtnUpdateBSP.Visible:= not IsD3D;
    BtnUpdateBSP.Enabled:= false;
    BtnNoDark.Enabled:= ok and sync and not odoor;
    BtnShowInvisible.Enabled:= ok and sync;
    BtnResetDoors.Enabled:= Editable;
    BtnResetDoors.Visible:= not Outdoor;
    BtnChests.Enabled:= ok and sync;
    BtnContinue.Visible:= ok and not sync;
    BtnDiscard.Visible:= ok and not sync;
    BtnGround.Enabled:= ok and sync;
    BtnGround.Visible:= Outdoor;
    BtnChangeTilesFile.Visible:= (MMVersion = 8);
    if Outdoor then
      BtnNewLight.Caption:= 'Model'
    else
      BtnNewLight.Caption:= 'Light';
    SaveDatDialog.Filter:= DatFilters[odoor];
    SaveDatDialog.DefaultExt:= DatDefExt[odoor];
    OpenDatDialogTypeChange(nil);
    SaveBlvDialog.Filter:= BlvFilters[odoor];
    SaveBlvDialog.DefaultExt:= BlvDefExt[odoor];
    if BtnChests.Down and BtnChests.Enabled then
      UpdateChests;
  end;
end;

procedure SetSelectionState(kind, subkind: int; ch: Bool); stdcall;
begin
  if Form1 = nil then  exit;

  with Form1 do
  begin
    SelKind:= kind;
    SelSubKind:= subkind;
    if ch then
      BtnChests.Down:= false;
    UpdatePanels;
  end;
end;

procedure SetUndoState(undo, redo: Bool); stdcall;
begin
  if Form1 = nil then  exit;

  with Form1 do
  begin
    BtnUndo.Enabled:= undo;
    BtnRedo.Enabled:= redo;
  end;
end;

procedure TilesetsChanged; stdcall;
begin
  if Form1 = nil then  exit;

  with Form1 do
    if PanelGround.Visible then
      LoadTileBitmaps;
end;

procedure UpdateBSPState(bsp: Bool); stdcall;
begin
  with Form1 do
    BtnUpdateBSP.Enabled:= bsp and not Outdoor;
end;

procedure ClickBtn(btn: TSpeedButton; btn2: TSpeedButton = nil; btn3: TSpeedButton = nil; btn4: TSpeedButton = nil);
begin
  if btn.Enabled and btn.Visible and btn.Parent.Visible then
  begin
    if btn.GroupIndex <> 0 then
      btn.Down:= not btn.Down;
    btn.OnClick(btn)
  end else
    if btn2 <> nil then
      ClickBtn(btn2, btn3, btn4);
end;

procedure CtrlKeyPressed(Key: int); stdcall;
begin
  if (Form1 = nil) or not Form1.Enabled then  exit;

  with Form1 do
    case Key of
      ord('S'):
        ClickBtn(Form1.BtnSave);
      ord('O'):
        ClickBtn(Form1.BtnOpen);
      ord('Y'):
        ClickBtn(Form1.BtnRedo);
      ord('Z'):
        if GetKeyState(VK_SHIFT) >= 0 then
          ClickBtn(Form1.BtnUndo)
        else
          ClickBtn(Form1.BtnRedo);
    end;
end;

procedure KeyPressed(Key: int); stdcall;
begin
  if (Form1 = nil) or not Form1.Enabled then  exit;

  with Form1 do
    case Key of
      ord('X'):
        Callback('Deselect');
        //ClickBtn(BtnDeselect, BtnDeselect2);
      ord('C'):
        ClickBtn(BtnCreate, BtnClone);
      VK_DELETE:
        ClickBtn(BtnDelete, BtnDeleteChest);
      ord('L'):
        ClickBtn(BtnLand);
      ord('P'):
        ClickBtn(BtnMoveToParty);
      ord('E'):
        ClickBtn(BtnEditFacet, BtnEditObject, BtnEditChest);
{      ord('F'):
        ClickBtn(BtnDoorState);}
      ord('Q'):
        ClickBtn(BtnEditDoor);
      ord('R'):
        ClickBtn(BtnEditRoom);
      ord('T'):
        ClickBtn(BtnChangeTexture, BtnEditKind, BtnNewKind, BtnTestChest);
      VK_SPACE:
        if PanelFacet.Visible and BtnDoorState.Visible and BtnDoorState.Enabled then
        begin
          Callback('DoorState', ptr(1));
          //Callback('DoorStateDbl');
        end else
          ClickBtn(BtnModelMode1, BtnModelMode2);
      ord('G'):
        ClickBtn(BtnGround);
      ord('1'):
        ClickBtn(BtnTileset1, BtnHeightMode1, BtnNewSprite);
      ord('2'):
        ClickBtn(BtnTileset2, BtnHeightMode3, BtnNewMonster);
      ord('3'):
        ClickBtn(BtnTileset3, BtnHeightMode5, BtnNewItem);
      ord('4'):
        ClickBtn(BtnTileset0, BtnHeightMode2, BtnNewLight);
      ord('5'):
        ClickBtn(BtnRoad, BtnHeightMode4, BtnNewSpawn);
      ord('6'):
        ClickBtn(BtnRoadDiag, BtnHeightMode6);
    end;
end;

procedure AltKeyPressed(Key: int); //stdcall;
begin
  if (Form1 = nil) or not Form1.Enabled then  exit;

  with Form1 do
    case Key of
      VK_F1:
        CloseEditor;
    end;
end;

procedure KeyUp(Key: int); stdcall;
begin
  if (Form1 = nil) or not Form1.Enabled then  exit;
  
  with Form1 do
    case Key of
      VK_SPACE:
        if PanelFacet.Visible and BtnDoorState.Visible and BtnDoorState.Enabled then
          Callback('DoorStateDbl');
    end;
end;

procedure OnTick; stdcall;
begin
  (*if (Form1 <> nil) and Form1.Visible and (TRSWnd(MainWnd).ExStyle and WS_EX_TOPMOST <> 0) then
  begin
    //Form1.Invalidate;
    Form1.Repaint;
    {Form1.Invalidate;
    InvalidateRect(Form1.Handle, nil, false);}
  end;*)
end;

function CheckSamePalette(Bmp: array of TBitmap): Boolean;
var
  pal1: array[0..255] of int;
  pal2: array[0..255] of int;
  n: uint;
  i: int;
begin
  Result:= false;
  if length(Bmp) < 1 then  exit;
  for i := 0 to high(Bmp) do
    if RSGetPixelFormat(Bmp[i]) <> pf8bit then
      exit;

  n:= GetPaletteEntries(Bmp[0].Palette, 0, 256, ptr(@pal1[0])^);
  if n = 0 then  exit;

  for i := 1 to high(Bmp) do
    if (GetPaletteEntries(Bmp[i].Palette, 0, 256, pal2) <> n) or
      not CompareMem(@pal1, @pal2, n*SizeOf(TPaletteEntry)) then
        exit;

  Result:= true;
end;

function CopyWaterBmp8(b, b1: TBitmap): TBitmap;
var
  p1, p2: PChar;
  i: int;
begin
  p1:= b.ScanLine[b.Height - 1];
  p2:= b1.ScanLine[b1.Height - 1];
  for i := 0 to ((b.Width + 3) and not 3)*b.Height - 1 do
    if (p1 + i)^ = #0 then
      (p1 + i)^:= (p2 + i)^;
  Result:= b;
end;

function CopyWaterBmp32(g: TGraphic; b1: TBitmap): TBitmap;
begin
  b1.PixelFormat:= pf24bit;
  b1.Canvas.Draw(0, 0, g);
  Result:= b1;
end;

function CopyWaterPng(g: TGraphic; g1: TPNGObject): TGraphic;
var
  w, h: int;

  procedure GetScan(b: TPNGObject; out p: pByteArray; out d: int);
  begin
    p:= b.Scanline[0];
    d:= 0;
    if h > 1 then
      d:= PChar(b.Scanline[1]) - PChar(p) - w*3;
  end;

  function MakeColored(c: TColor): TPNGObject;
  begin
    Result:= TPNGObject.CreateBlank(COLOR_RGB, 8, g.Width, g.Height);
    with Result.Canvas do
    begin
      Brush.Color:= c;
      FillRect(ClipRect);
      Draw(0, 0, g1);
      Draw(0, 0, g);
    end;
  end;

  procedure ComponentDiv(var p: pByteArray; a3: int);
  begin
    if a3 <> 0 then
      p[0]:= min(255, (int(p[0])*255*3 + a3 div 2) div a3);
    p:= @p[1];
  end;

var
  b1, b2: TPNGObject;
  p, p2, pa: pByteArray;
  d, d2, da, x, y, a3: int;
begin
  Result:= g1;
  w:= g1.Width;
  h:= g1.Height;
  if w*h = 0 then  exit;
  b1:= nil;
  b2:= nil;
  try
    // combine on black and white background
    b1:= MakeColored(clBlack);
    b2:= MakeColored(clWhite);
    g1.Assign(b1);
    g1.CreateAlpha;
    // scanlines
    GetScan(g1, p, d);
    GetScan(b2, p2, d2);
    pa:= g1.AlphaScanline[0];
    da:= 0;
    if h > 1 then
      da:= PChar(g1.AlphaScanline[1]) - pa - w;
    // convert
    for y := 0 to g1.Height - 1 do
    begin
      for x := 0 to g1.Width - 1 do
      begin
        a3:= min(255*3, 255*3 - p2[0] + p[0] - p2[1] + p[1] - p2[2] + p[2]);
				ComponentDiv(p, a3);
				ComponentDiv(p, a3);
				ComponentDiv(p, a3);
        pa[0]:= (a3 + 1) div 3;
        p2:= @p2[3];
        pa:= @pa[1];
      end;
      p:= @p[d];
      p2:= @p2[d2];
      pa:= @pa[da];
    end;
  finally
    b1.Free;
    b2.Free;
  end;
end;

function CopyWater(g, g1: TGraphic): TGraphic;
var
  b: TBitmap absolute g;
  b1: TBitmap absolute g1;
begin
  if g1 is TBitmap then
  begin
    if (g is TBitmap) and CheckSamePalette([b, b1]) then
      Result:= CopyWaterBmp8(b, b1)
    else
      Result:= CopyWaterBmp32(g, b1);
  end else
    Result:= CopyWaterPng(g, TPNGObject(g1));
end;

function ExtractWithOverride(Lod: TRSMMArchive; i: int; out b: TGraphic; ground: Boolean): Boolean;
const
  over: array[Boolean] of string = ('Texture Override', 'Ground Override');
  ppath = '%sData\%s\%s.png';
  bpath = '%sData\%s\%s.bmp';
var
  a: TRSByteArray;
  s: string;
begin
  s:= Format(ppath, [AppPath, over[ground], Lod.Names[i]]);
  if FileExists(s) then
  begin
    b:= TPNGObject.Create;
    b.LoadFromFile(s);
  end else
  begin
    s:= Format(bpath, [AppPath, over[ground], Lod.Names[i]]);
    if FileExists(s) then
      b:= RSLoadBitmap(s)
    else
      b:= Lod.ExtractArrayOrBmp(i, a);
  end;
  Result:= b <> nil;
end;

function ExtractTexture(name, path, extra: PChar): LongBool; stdcall;
const
  PicExt: array[Boolean] of string = ('.png', '.bmp');
var
  Lod: TRSMMArchive;
  b, b1, g: TGraphic;
  i, c: int;
begin
  Result:= false;
  b:= nil;
  b1:= nil;
  try
    try
      if RSMMArchivesFind(BitmapsLods, name, Lod, i) and
         ExtractWithOverride(Lod, i, b, extra <> nil) then
      begin
        if not (b is TBitmap) then
        begin
          if RSMMArchivesFind(BitmapsLods, extra, Lod, i) then
            ExtractWithOverride(Lod, i, b1, true);
        end else
        if TBitmap(b).PixelFormat = pf8bit then
        begin
          GetPaletteEntries(b.Palette, 0, 1, c);
          if (c = $FFFF00) or (c = $FF00FF) or (c = $FC00FC) or (c = $FCFC00) then
          begin
            if RSMMArchivesFind(BitmapsLods, extra, Lod, i) then
              ExtractWithOverride(Lod, i, b1, true);
            TBitmap(b).TransparentColor:= c;
            b.Transparent:= true;
          end;
        end;

        if (b1 <> nil) and (b1.Width = b.Width) and (b1.Height = b.Height) then
          g:= CopyWater(b, b1)
        else
          g:= b;

        Result:= g is TBitmap;
        g.SaveToFile(path + PicExt[Result]);
      end else
      begin
        b:= TPNGObject.CreateBlank(COLOR_RGBALPHA, 8, 1, 1);
        with TPNGObject(b) do
          if name = '_Portal_' then
          begin
            Canvas.Pixels[0, 0]:= clYellow;
            AlphaScanline[0][0]:= 140;
          end else
            AlphaScanline[0][0]:= 0;
        b.SaveToFile(path + PicExt[Result]);
      end;
    finally
      b.Free;
      b1.Free;
    end;
  except
  end;
end;

{Form1}

procedure TForm1.BtnEditChestClick(Sender: TObject);
begin
  Callback('EditChest', ptr(ListChests.ItemIndex));
  UpdateChests;
  BringToFront;
  ListChests.SetFocus;
end;

procedure TForm1.BtnEditClick(Sender: TObject);
begin
  Callback('EditProps');
end;

procedure TForm1.BtnEditKindClick(Sender: TObject);
var
  s: string;
  kind: int;
begin
  kind:= Callback('GetKind');
  s:= PChar(Callback('GetKindList'));
  if ChooseKind(RSParseString(s, [#1]), kind, SelKind) then
    Callback('SetKind', ptr(kind));
end;

procedure TForm1.SimpleBtnClick(Sender: TObject);
begin
  SimpleCommand(Sender, ptr(TSpeedButton(Sender).Down));
end;

procedure TForm1.SimpleBtnDblWndProc(Sender: TObject; var m: TMessage;
  var Handled: Boolean; const NextWndProc: TWndMethod);
var
  s: string;
begin
  if m.Msg = WM_LBUTTONDBLCLK then
  begin
    s:= TComponent(Sender).Name;
    Callback(ptr(copy(s, 4, length(s) - 3) + 'Dbl'));
    Handled:= true;
  end;
end;

procedure TForm1.SimpleCommand(Sender: TObject; param: ptr);
var
  s: string;
begin
  s:= TSpeedButton(Sender).Name;
  Callback(ptr(copy(s, 4, length(s) - 3)), param);
end;

procedure TForm1.BtnExportClick(Sender: TObject);
begin
  SaveObjDialog.FileName:= IncludeTrailingPathDelimiter(SaveObjDialog.InitialDir)
    + FileNameCallback('GetExportFileName');
  if SafeExecute(SaveObjDialog) then
    SimpleCommand(Sender, ptr(SaveObjDialog.FileName));
end;

procedure TForm1.BtnHeightMode1Click(Sender: TObject);
begin
  Callback('SetGridMode', ptr(TControl(Sender).Tag));
end;

procedure TForm1.BtnImportClick(Sender: TObject);
begin
  if SafeExecute(OpenObjDialog) then
    SimpleCommand(Sender, ptr(OpenObjDialog.FileName));
end;

procedure TForm1.BtnLoadBlvClick(Sender: TObject);
begin
  ChooseBlv;
end;

procedure TForm1.BtnLoadHeightMapClick(Sender: TObject);
var
  b: TBitmap;
  s: string;
begin
  CreateDir(OpenBmpDialog.InitialDir);
  OpenBmpDialog.FileName:= IncludeTrailingPathDelimiter(OpenBmpDialog.InitialDir)
     + FileNameCallback('GetExportFileName');
  if SafeExecute(OpenBmpDialog) then
  begin
    b:= RSLoadBitmap(OpenBmpDialog.FileName);
    try
      Assert((b.Height = 128) and (b.Width = 128), 'Height map must be a 128*128 bitmap');
      Assert(b.PixelFormat = pf8bit, 'Height map must have 256 colors');
      SetLength(s, 128*128);
      RSBitmapToBuffer(ptr(s), b);
    finally
      b.Free;
    end;
    Callback('SetHeightMap', ptr(s));
  end;
end;

procedure TForm1.BtnModelMode1Click(Sender: TObject);
begin
  BtnModelMode1.Down:= false;
  BtnModelMode2.Down:= true;
  Callback('ModelMode', ptr(not TRSSpeedButton(Sender).Down));
end;

procedure TForm1.BtnMonItemClick(Sender: TObject);
var
  s: string;
  kind: int;
begin
  kind:= Callback('GetMonItem');
  s:= 'None'#1#13#10'(0)'#1''#1'0'#1 + PChar(Callback('GetKindList', ptr(skObject)));
  if ChooseKind(RSParseString(s, [#1]), kind, skObject) then
    Callback('SetMonItem', ptr(kind));
end;

procedure TForm1.BtnOpenClick(Sender: TObject);
begin
  if SafeExecute(OpenDatDialog) then
    Callback('Open', ptr(OpenDatDialog.FileName));
end;

procedure TForm1.BtnSaveAsClick(Sender: TObject);
begin
  SaveDatDialog.FileName:= FileNameCallback('GetSaveAsName');
  if SafeExecute(SaveDatDialog) then
    Callback('Save', ptr(SaveDatDialog.FileName));
end;

procedure TForm1.BtnSaveClick(Sender: TObject);
var
  s: string;
begin
  s:= FileNameCallback('GetFileName');
  if s <> '' then
    Callback('Save', ptr(s))
  else
    BtnSaveAsClick(nil);
end;

procedure TForm1.BtnSaveHeightMapClick(Sender: TObject);
var
  b: TBitmap;
  p: ptr;
begin
  CreateDir(SaveBmpDialog.InitialDir);
  SaveBmpDialog.FileName:= IncludeTrailingPathDelimiter(SaveBmpDialog.InitialDir)
     + FileNameCallback('GetExportFileName');
  if SafeExecute(SaveBmpDialog) then
  begin
    p:= ptr(Callback('GetHeightMap'));
    b:= TBitmap.Create;
    try
      RSGrayscale(b, b);
      b.Width:= 128;
      b.Height:= 128;
      RSBufferToBitmap(p, b);
      b.SaveToFile(SaveBmpDialog.FileName);
    finally
      b.Free;
    end;
  end;
end;

procedure TForm1.BtnSaveModelClick(Sender: TObject);
begin
  SaveModelDialog.FileName:= IncludeTrailingPathDelimiter(SaveModelDialog.InitialDir)
    + FileNameCallback('GetSaveModelName');
  if SafeExecute(SaveModelDialog) then
    Callback('SaveModel', PChar(SaveModelDialog.FileName));
end;

procedure TForm1.BtnTestChestClick(Sender: TObject);
begin
  Callback('TestChest', ptr(ListChests.ItemIndex));
end;

procedure TForm1.BtnTilesClick(Sender: TObject);
var
  i: int;
begin
  i:= TControl(Sender).Tag;
  PanelTiles.Visible:= (i = 0);
  PanelHeight.Visible:= (i = 1);
  Callback('SetTileBrushGrid', ptr(i));
  Callback('SetTileBrushSize', ptr(EditBrushSize.Value));
  Callback('SetTileBrushSpeed', ptr(EditBrushSpeed.Value));
end;

procedure TForm1.BtnTileset1Click(Sender: TObject);
begin
  BtnChangeTileset.Enabled:= TControl(Sender).Tag > 0;
  Callback('SetCurrentTileset', ptr(TControl(Sender).Tag));
end;

procedure TForm1.BtnTileset1Paint(Sender: TRSSpeedButton;
  DefaultPaint: TRSProcedure; var State: TButtonState;
  var MouseInControl: Boolean; MouseReallyInControl: Boolean);
begin
  DefaultPaint;
  Sender.Canvas.Draw(1, 1, TileBitmaps[Sender.Tag]);
  if State in [bsDown, bsExclusive] then
    with Sender.Canvas do
    begin
      Pen.Mode:= pmNot;
      Brush.Style:= bsClear;
      Rectangle(2, 2, 46, 38);
    end;
end;

procedure TForm1.BtnUndoClick(Sender: TObject);
begin
  SimpleBtnClick(Sender);
  if Form1.PanelChests.Visible then
    Form1.UpdateChests;
end;

function TForm1.ChooseKind(ps: TRSParsedString; var Index: int; sk: int): Boolean;
begin
  with FormChooseKind do
  begin
    case sk of
      skObject:
        ArchivePath:= GetLodsList('Icons');
      skFacet:
        ArchivePath:= '';  // bitmaps (default)
      else
        ArchivePath:= GetLodsList('Sprites');
    end;
    case sk of
      skNone:
        Caption:= 'Choose Map';
      skObject:
        Caption:= 'Choose Item';
      skMonster:
        Caption:= 'Choose Monster';
      skSprite:
        Caption:= 'Choose Sprite';
      skFacet:
        Caption:= 'Choose Texture';
      skSpawn:
        Caption:= 'Choose Spawn Kind';
    end;
    if sk = skNone then
    begin
      ArchivePath2:= GetLodsList('Icons');
      NoTransparency2:= true;
      SquareIcons:= true;
    end;
  end;
  if sk = skNone then
    Result:= DoChooseKind(ps, Index, '%1:s'#13#10'(%0:s)')
  else
    Result:= DoChooseKind(ps, Index);
end;

procedure TForm1.ChooseBlv;
const
  minus1: string = '-1';
  indoor: string = 'divbar';//'ar_dn_up';
var
  lods: TRSMMArchivesArray;
  files: TRSMMFiles;
  sl: TStringList;
  ps: TRSParsedString;
  s, ext: string;
  p: PChar;
  i, j, k, idx, len: int;
begin
  LoadMapNames;
  sl:= TStringList.Create;
  try
    sl.Duplicates:= dupIgnore;
    sl.CaseSensitive:= false;
    sl.Sorted:= true;
    if GamesLods = nil then
      GamesLods:= LoadLods(GetLodsList('Games'));
    lods:= GamesLods;
    for j := high(lods) downto 0 do
    begin
      files:= lods[j].RawFiles;
      for i := 0 to files.Count - 1 do
      begin
        p:= files.Name[i];
        s:= p;
        ext:= LowerCase(ExtractFileExt(s));
        if (ext = '.odm') or (ext = '.blv') then
          sl.AddObject(s, ptr(p));
      end;
    end;
    k:= 0;
    SetLength(ps, sl.Count*8);
    for i := 0 to sl.Count - 1 do
    begin
      s:= sl[i];
      p:= ptr(sl.Objects[i]);
      len:= length(s);
      ps[k]:= p;
      ps[k + 1]:= p + len;
      if MapNames.Find(s, idx) then
        CopyMemory(@ps[k + 2], ptr(RSParseString(string(MapNames.Objects[idx]), [#1])), 6*SizeOf(PChar));

      if SameText(ExtractFileExt(s), '.odm') then
      begin
        ps[k + 4]:= p;
        ps[k + 5]:= p + len - 4;
        ps[k + 6]:= @minus1[1];
        ps[k + 7]:= @minus1[3];
      end
      else if ps[k + 4] = ps[k + 5] then
      begin
        ps[k + 4]:= @indoor[1];
        ps[k + 5]:= @indoor[length(indoor) + 1];
        ps[k + 6]:= @minus1[1];
        ps[k + 7]:= @minus1[3];
      end;
      inc(k, 8);
    end;
  finally
    sl.Free;
  end;

  s:= PChar(Callback('GetMapName'));
  if ChooseKind(ps, s, skNone) then
    Callback('LoadBlv', ptr(s));
end;

function TForm1.ChooseKind(ps: TRSParsedString; var Name: string;
  sk: int): Boolean;
var
  kind: int;
begin
  kind:= FindKindIndex(ps, Name);
  Result:= ChooseKind(ps, kind, sk);
  if Result then
    Name:= RSGetToken(ps, kind*4);
end;

procedure TForm1.CNChar(var m: TWMChar);
begin
  // ignore
end;

function TForm1.Confirm: Boolean;
begin
  Result:= RSMessageBox(Handle, 'Are you sure?', 'MM Editor',
      MB_ICONINFORMATION or MB_OKCANCEL) = IDOK;
end;

function TForm1.DoChooseKind(ps: TRSParsedString; var Index: int; Fmt: string): Boolean;
var
  wp: TWindowPlacement;
  i: int;
begin
  Result:= false;
  if RSGetTokensCount(ps) < 4 then  exit;
  UpdatePosition;
  with FormChooseKind do
  begin
    wp.length:= SizeOf(wp);
    GetWindowPlacement(Handle, @wp);
    with wp.rcNormalPosition do
    begin
      Top:= self.Top;
      Left:= self.Left;
      Bottom:= Top + TRSWnd(MainWnd).Height;
      Right:= Left + self.Width + TRSWnd(MainWnd).Width;
    end;
    wp.showCmd:= SW_HIDE;
    SetWindowPlacement(Handle, @wp);
    SetLength(ItemCaptions, RSGetTokensCount(ps) div 4);
    SetLength(ItemBitmaps, length(ItemCaptions));
    SetLength(ItemPalettes, length(ItemCaptions));
    for i := 0 to length(ItemCaptions) - 1 do
    begin
      ItemCaptions[i]:= Format(Fmt, [RSGetToken(ps, i*4), RSGetToken(ps, i*4 + 1)]);
      ItemBitmaps[i]:= RSGetToken(ps, i*4 + 2);
      ItemPalettes[i]:= StrToInt(RSGetToken(ps, i*4 + 3));
    end;
    SelectedItem:= Index;
    Pause(true);
    Result:= Open;
    Pause(false);
    if Result then
      Index:= SelectedItem;
  end;
end;

procedure TForm1.EditBrushSizeChange(Sender: TObject);
begin
  Callback('SetTileBrushSize', ptr(EditBrushSize.Value));
end;

procedure TForm1.EditBrushSpeedChange(Sender: TObject);
begin
  Callback('SetTileBrushSpeed', ptr(EditBrushSpeed.Value));
end;

procedure TForm1.BtnAutoLandClick(Sender: TObject);
begin
  Callback('SetAutoLand', ptr(BtnAutoLand.Down));
end;

procedure TForm1.BtnChangeTextureClick(Sender: TObject);
const
  null: string = '0';
var
  lods: TRSMMArchivesArray;
  files: TRSMMFiles;
  sl: TStringList;
  ps: TRSParsedString;
  texture: string;
  p: PChar;
  i, j, k, len: int;
begin
  sl:= TStringList.Create;
  try
    sl.Duplicates:= dupIgnore;
    sl.CaseSensitive:= false;
    sl.Sorted:= true;
    lods:= BitmapsLods;
    k:= 0;
    for j := high(lods) downto 0 do
    begin
      files:= lods[j].RawFiles;
      SetLength(ps, k + files.Count*8);
      for i := 0 to files.Count - 1 do
      begin
        p:= files.Name[i];
        len:= StrLen(p);
        if (len < 6) or not IsThere(p, 'pal') or not (p[4] in ['0'..'9']) then
          if (len < 10) and (sl.Objects[sl.AddObject(p, ptr(k))] = ptr(k)) then
          begin
            ps[k]:= p;
            ps[k + 1]:= p + len;
            ps[k + 4]:= p;
            ps[k + 5]:= p + len;
            ps[k + 6]:= @null[1];
            ps[k + 7]:= @null[2];
            inc(k, 8);
          end;
      end;
      SetLength(ps, k);
    end;
  finally
    sl.Free;
  end;

  texture:= PChar(Callback('GetTexture'));
  if ChooseKind(ps, texture, skFacet) then
    Callback('SetTexture', ptr(texture));
end;
{begin
  PrepareLodEdit(true);
  Pause(true);
  RSLodEdit.SpecFilter:= TextureSpecFilter;
  if RSLodEdit.LoadShowModal('', PChar(Callback('GetTexture')),
     AppPath + 'Data\bitmaps.lod') = mrOk then
  begin
    Callback('SetTexture', ptr(RSLodResult));
  end;
  Pause(false);
end;}

procedure TForm1.BtnCompileClick(Sender: TObject);
begin
  CreateDir(SaveBlvDialog.InitialDir);
  SaveBlvDialog.FileName:= IncludeTrailingPathDelimiter(SaveBlvDialog.InitialDir)
    + FileNameCallback('GetCompileName');
  if SafeExecute(SaveBlvDialog) then
    Callback('Compile', ptr(SaveBlvDialog.FileName));
end;

procedure TForm1.BtnContinueClick(Sender: TObject);
begin
  Callback('Continue');
end;

procedure TForm1.BtnCreateClick(Sender: TObject);
const
  Command: array[TMyCreateIndex] of PChar = (
    'NewSprite', 'NewLight', 'NewSpawn', 'NewItem', 'NewMonster'
  );
begin
  if BtnNewSprite.Down then
    Callback('NewSprite', PChar(CreateSpriteName))
  else if BtnNewLight.Down and Outdoor then
    Callback('NewModel')
  else
    Callback(Command[GetCreateIndex], ptr(CreateKinds[GetCreateIndex] + 1));
end;

procedure TForm1.BtnDeleteChestClick(Sender: TObject);
begin
  Callback('DeleteChest', ptr(ListChests.ItemIndex));
  UpdateChests;
  ListChests.SetFocus;
end;

procedure TForm1.BtnDeselect3Click(Sender: TObject);
begin
  ClickBtn(BtnGround);
end;

procedure TForm1.BtnDeselectClick(Sender: TObject);
begin
  Callback('Deselect');
end;

function TForm1.FileNameCallback(cmd: PChar; params: ptr): string;
begin
  Result:= RSStringReplace(PChar(Callback(cmd, params)), '/', '\');
end;

function TForm1.FindKindIndex(ps: TRSParsedString; const Name: string): int;
var
  i: int;
begin
  Result:= 0;
  for i:= 0 to RSGetTokensCount(ps) div 4 - 1 do
    if SameText(RSGetToken(ps, i*4), Name) then
    begin
      Result:= i;
      break;
    end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Callback('Closed');
  Action:= caHide;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: int;
begin
  ClientWidth:= PanelFacet.Width;
  PanelSprite.Left:= 0;
  PanelNone.Left:= 0;
  PanelFacet.Left:= 0;
  PanelGround.Left:= 0;
  Height:= TRSWnd(MainWnd).Height;
  UpdatePosition;
  OpenDatDialog.InitialDir:= AppPath + 'Maps';
  SaveDatDialog.InitialDir:= OpenDatDialog.InitialDir;
  OpenObjDialog.InitialDir:= AppPath + 'MapObj';
  SaveObjDialog.InitialDir:= OpenObjDialog.InitialDir;
  SaveBlvDialog.InitialDir:= AppPath + 'Data\Games';
  OpenModelDialog.InitialDir:= AppPath + 'MapModels';
  SaveModelDialog.InitialDir:= OpenModelDialog.InitialDir;
  OpenBmpDialog.InitialDir:= AppPath + 'MapHeight';
  SaveBmpDialog.InitialDir:= OpenBmpDialog.InitialDir;
  CreateDir(OpenDatDialog.InitialDir);
  CreateDir(OpenObjDialog.InitialDir);
  CreateDir(OpenModelDialog.InitialDir);
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TRSSpeedButton then
      with TRSSpeedButton(Components[i]) do
        Caption:= RSStringReplace(Caption, '~', #13#10);
  BitmapsLod:= TRSLod.Create(AppPath + 'Data\bitmaps.lod');
  ParseFilter(SaveDatDialog.Filter, DatFilters);
  ParseFilter(SaveBlvDialog.Filter, BlvFilters);
  LoadMapNames;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: int;
begin
  for i := 0 to ComponentCount - 1 do
    if (Components[i] is TCustomEdit) and TCustomEdit(Components[i]).Focused then
      exit;

  if ssCtrl in Shift then
    CtrlKeyPressed(Key)
  else
    KeyPressed(Key);
end;

function TForm1.GetCreateIndex: TMyCreateIndex;
begin
  if BtnNewSprite.Down then
    Result:= ciSprite
  else if BtnNewLight.Down then
    Result:= ciLight
  else if BtnNewSpawn.Down then
    Result:= ciSpawn
  else if BtnNewItem.Down then
    Result:= ciItem
  else// if BtnNewMonster.Down then
    Result:= ciMonster
end;

procedure TForm1.ItemTile1Click(Sender: TObject);
begin
  Callback('SetTilesetsFile', ptr(TMenuItem(Sender).Tag));
end;

procedure TForm1.ListChestsWndProc(Sender: TObject; var m: TMessage;
  var Handled: Boolean; const NextWndProc: TWndMethod);
begin
  if m.Msg = WM_SYSKEYDOWN then
    AltKeyPressed(m.WParam);
end;

procedure TForm1.LoadMapNames;
var
  ps: TRSParsedString;
  ss: string;
  i: int;
begin
  if MapNames <> nil then  exit;
  MapNames:= TStringList.Create;
  MapNames.CaseSensitive:= false;
  MapNames.Sorted:= true;
  ss:= PChar(Callback('GetMapNames'));
  ps:= RSParseString(ss, [#1]);
  for i := 0 to RSGetTokensCount(ps) div 4 - 1 do
    MapNames.AddObject(RSGetToken(ps, i*4), Ref(RSGetTokens(ps, i*4 + 1, i*4 + 4)));
end;

procedure TForm1.LoadModel;
begin
  if SafeExecute(OpenModelDialog) then
    if Callback('LoadModel', PChar(OpenModelDialog.FileName)) <> 0 then
    begin
      ModelChosen:= true;
      BtnCreate.Enabled:= true;
    end;
end;

procedure TForm1.LoadTileBitmaps;
const
  w = 46;
  h = 38;
  r: TRect = (Left: 0; Top: (h - w) div 2; Right: w; Bottom: (h + w) div 2);
var
  a: TRSByteArray;
  b: TBitmap;
  i, n: int;
begin
  for i := 0 to 5 do
  begin
    FreeAndNil(TileBitmaps[i]);
    if BitmapsLod.RawFiles.FindFile(PChar(Callback('GetTilesetBitmap', ptr(i))), n)
      or BitmapsLod.RawFiles.FindFile('pending', n) then
    begin
      b:= BitmapsLod.ExtractArrayOrBmp(n, a);
      with b do
      begin
        PixelFormat:= pf32bit;
        Canvas.StretchDraw(r, b);
        Width:= w;
        Height:= h;
      end;
      TileBitmaps[i]:= b;
    end;
  end;
  PanelTiles.Invalidate;
end;

procedure TForm1.OpenDatDialogTypeChange(Sender: TObject);
var
  b: Boolean;
begin
  case OpenDatDialog.FilterIndex of
    2:  b:= false;
    3:  b:= true;
    else  b:= Outdoor;
  end;
  OpenDatDialog.DefaultExt:= DatDefExt[b];
end;

procedure TForm1.ParseFilter(const s: string; var Arr);
var
  a: array[Boolean] of string absolute Arr;
  ps: TRSParsedString;
begin
  ps:= RSParseString(s, ['!']);
  Assert(length(ps) = 6);
  a[false]:= RSGetToken(ps, 0) + RSGetToken(ps, 2);
  a[true]:= RSGetToken(ps, 1) + RSGetToken(ps, 2);
end;

procedure TForm1.Pause(AOn: Boolean);
begin
  Callback('Pause', ptr(AOn));
end;

procedure TForm1.BtnSkyTextureClick(Sender: TObject);
{const
  null: string = '0';
var
  files: TRSMMFiles;
  ps: TRSParsedString;
  s: string;
  p: PChar;
  i, k, len: int;}
begin
{  files:= FormChooseKind.BitmapsLod.RawFiles;
  SetLength(ps, files.Count*8);
  k:= 0;
  for i := 0 to files.Count - 1 do
  begin
    p:= files.Name[i];
    len:= StrLen(p);
    if (len < 6) or not IsThere(p, 'pal') or not (p[4] in ['0'..'9']) then
    begin
      s:= LowerCase(p);
      if (pos('sky', s) > 0) or (pos('cloud', s) > 0) then
      begin
        ps[k]:= p;
        ps[k + 1]:= p + len;
        ps[k + 4]:= p;
        ps[k + 5]:= p + len;
        ps[k + 6]:= @null[1];
        ps[k + 7]:= @null[2];
        inc(k, 8);
      end;
    end;
  end;
  SetLength(ps, k);

  i:= FindKindIndex(ps, PChar(Callback('GetSkyTexture')));
  with FormChooseKind do
  begin
    ArchivePath:= AppPath + 'Data\bitmaps.lod';
    Caption:= 'Choose Sky Texture';
  end;
  if DoChooseKind(ps, i) then
    Callback('SetSkyTexture', PChar(RSGetToken(ps, i*4)));}
end;

procedure TForm1.BtnGroundClick(Sender: TObject);
var
  i: int;
begin
  i:= 0;
  if BtnGround.Down then
  begin
    i:= EditBrushSize.Value;
    LoadTileBitmaps;
  end;
  UpdatePanels;
  Callback('SetTileBrushSize', ptr(i));
end;

procedure TForm1.BtnChangeTilesetClick(Sender: TObject);
var
  s: string;
  ps: TRSParsedString;
  idx: int;
begin
  s:= PChar(Callback('GetTilesetsList'));
  ps:= RSParseString(s, [#1]);
  idx:= StrToInt(RSGetToken(ps, RSGetTokensCount(ps) - 1));
  with FormChooseKind do
  begin
    ArchivePath:= AppPath + 'Data\bitmaps.lod';
    Caption:= 'Choose Tileset';
  end;
  if DoChooseKind(ps, idx) then
    Callback('SetTileset', ptr(StrToInt(RSGetToken(ps, idx*4))));
end;

procedure TForm1.BtnChangeTilesFileClick(Sender: TObject);
var
  i: int;
begin
  i:= Callback('GetTilesetsFile', ptr(TMenuItem(Sender).Tag));
  ItemTile1.Checked:= (i = ItemTile1.Tag);
  ItemTile2.Checked:= (i = ItemTile2.Tag);
  ItemTile3.Checked:= (i = ItemTile3.Tag);
  with Mouse.CursorPos do
    PopupTilesFile.Popup(X, Y);
end;

procedure TForm1.BtnChestsClick(Sender: TObject);
begin
  UpdateChests;
  UpdatePanels;
  if PanelChests.Visible then
  begin
    if ListChests.ItemIndex < 0 then
      ListChests.ItemIndex:= 0;
    ListChests.SetFocus;
  end;
end;

procedure TForm1.BtnNewClick(Sender: TObject);
begin
  if Confirm then
    Callback('New');
end;

procedure TForm1.BtnNewKindClick(Sender: TObject);
var
  index: TMyCreateIndex;
  s: string;
  ps: TRSParsedString;
begin
  index:= GetCreateIndex;
  if (index = ciLight) and Outdoor then
  begin
    LoadModel;
    exit;
  end;
  s:= PChar(Callback('GetKindList', ptr(CreateSelKind[index])));
  ps:= RSParseString(s, [#1]);
  if index = ciSprite then
    ChooseKind(ps, CreateSpriteName, skSprite)
  else
    ChooseKind(ps, CreateKinds[index], CreateSelKind[index]);
end;

procedure TForm1.BtnNewLightClick(Sender: TObject);
begin
  BtnNewKind.Enabled:= Outdoor;
  BtnCreate.Enabled:= not Outdoor or ModelChosen;
end;

procedure TForm1.BtnNewSpriteClick(Sender: TObject);
begin
  BtnNewKind.Enabled:= true;
  BtnCreate.Enabled:= true;
end;

function TForm1.SafeExecute(dlg: TCommonDialog): Boolean;
var
  s: string;
begin
  s:= GetCurrentDir;
  Result:= dlg.Execute;
  SetCurrentDir(s);
end;

procedure TForm1.SaveModelDialogTypeChange(Sender: TObject);
begin
  with SaveModelDialog do
    if FilterIndex = 2 then
      DefaultExt:= '.obj'
    else
      DefaultExt:= '.mdt';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  UpdatePosition;
end;

procedure TForm1.UpdateChests;
var
  ss: string;
  ps: TRSParsedString;
  i: int;
begin
  ss:= PChar(Callback('GetChestsList'));
  ps:= RSParseString(ss, [#13#10]);
  for i := 0 to RSGetTokensCount(ps) - 1 do
    if i < ListChests.Items.Count then
      ListChests.Items[i]:= RSGetToken(ps, i)
    else
      ListChests.Items.Add(RSGetToken(ps, i));

  for i := ListChests.Items.Count - 1 downto RSGetTokensCount(ps) do
    ListChests.Items.Delete(i);
end;

procedure TForm1.UpdatePanels;
var
  vis: TPanel;
begin
  vis:= nil;
  try
    BtnExportSelected.Enabled:= false;
    if not StateLoaded or not StateSync or not Editable then  exit;
    vis:= PanelChests;
    if BtnChests.Down then  exit;
    vis:= PanelGround;
    if BtnGround.Visible and BtnGround.Down then  exit;

    case SelKind of
      skFacet:
      begin
        // 0 = no door, 1 = 1 door, 2 = 1 door not exact, 3 = multiple doors
        vis:= PanelFacet;
        BtnNewDoor.Visible:= not Outdoor and (SelSubKind = 0);
        BtnDeleteDoor.Enabled:= (SelSubKind <> 0);
        BtnSelectDoor.Enabled:= (SelSubKind >= 2);
        BtnChangeDoorShape.Enabled:= (SelSubKind = 2);
        BtnEditDoor.Enabled:= (SelSubKind = 1) or (SelSubKind = 2);
        BtnDoorState.Enabled:= (SelSubKind = 1) or (SelSubKind = 2);
        BtnModelMode1.Visible:= Outdoor;
        BtnEditRoom.Visible:= not Outdoor;
        BtnDeleteDoor.Visible:= not Outdoor;
        BtnSelectDoor.Visible:= not Outdoor;
        BtnChangeDoorShape.Visible:= not Outdoor;
        BtnEditDoor.Visible:= not Outdoor;
        BtnDoorState.Visible:= not Outdoor;
      end;
      skNone:
        vis:= PanelNone;
      else
      begin
        vis:= PanelSprite;
        BtnEditKind.Enabled:= (SelKind <> skLight);
        //BtnClone.Enabled:= (SelSubKind = 0);
        BtnAlignX.Enabled:= (SelSubKind = 1);
        BtnAlignY.Enabled:= (SelSubKind = 1);
        BtnAlignZ.Enabled:= (SelSubKind = 1);
        BtnMonItem.Visible:= (SelKind = skMonster);
        BtnModelMode2.Visible:= (SelKind = skModel);
        BtnSaveModel.Visible:= (SelKind = skModel);
        BtnEditKind.Visible:= (SelKind <> skModel);
        BtnExportSelected.Enabled:= (SelKind = skModel);
        BtnSelectSameSprite.Visible:= (SelKind <> skModel);
        BtnSelectAll.Visible:= (SelKind = skModel);
      end;
    end;
  finally
    PanelFacet.Visible:= (vis = PanelFacet);
    PanelSprite.Visible:= (vis = PanelSprite);
    PanelNone.Visible:= (vis = PanelNone);
    PanelChests.Visible:= (vis = PanelChests);
    PanelGround.Visible:= (vis = PanelGround);
  end;
end;

procedure TForm1.UpdatePosition;
var
  r: TRect;
  p: TPoint;
  h: int;
begin
  //if not Visible then  exit;
  r:= TRSWnd(MainWnd).BoundsRect;
  Top:= r.Top;
  Height:= r.Bottom - r.Top;
  if GetWindowLong(MainWnd, GWL_STYLE) and WS_BORDER = 0 then
  begin
    p.X:= 0;
    p.Y:= 0;
    Windows.ClientToScreen(MainWnd, p);
    Left:= p.X - Width;
    ClipCursor(nil);
  end else
    Left:= r.Left - Width;

  with ListChests do
  begin
    Canvas.Font:= Font;
    h:= Canvas.TextHeight('W')*20 + 10 + PanelChests.Height - Height;
  end;
  PanelChests.Height:= min(h, ClientHeight - PanelChests.Top);
end;

procedure TForm1.WMPaint(var m: TMessage);
begin
  inherited;
  //InvalidateRect(Handle, nil, false);
  //Invalidate;
end;

procedure TForm1.WNSysKeyDown(var m: TWMKeyDown);
begin
  AltKeyPressed(m.CharCode);
  inherited;
end;

exports
  StartEditor,
  SetStateLoaded,
  SetSelectionState,
  SetUndoState,
  TilesetsChanged,
  CtrlKeyPressed,
  KeyPressed,
  KeyUp,
  CloseEditor,
  OnTick,
  ExtractTexture,
  UpdateBSPState;
end.
