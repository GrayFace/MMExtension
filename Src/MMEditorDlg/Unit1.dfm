object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Level Editor'
  ClientHeight = 583
  ClientWidth = 783
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BtnImport: TRSSpeedButton
    Left = 48
    Top = 80
    Width = 48
    Height = 40
    Caption = 'Import~Rooms'
    OnClick = BtnImportClick
    HighlightedMild = True
    Styled = True
  end
  object BtnExportSelected: TRSSpeedButton
    Left = 48
    Top = 80
    Width = 48
    Height = 40
    Caption = 'Export~Selection'
    OnClick = BtnExportClick
    HighlightedMild = True
    Styled = True
  end
  object BtnResetDoors: TRSSpeedButton
    Left = 96
    Top = 172
    Width = 48
    Height = 40
    Caption = 'Reset~Doors'
    OnClick = SimpleBtnClick
    HighlightedMild = True
    Styled = True
  end
  object BtnGround: TRSSpeedButton
    Left = 96
    Top = 172
    Width = 48
    Height = 40
    AllowAllUp = True
    GroupIndex = 5
    Caption = '&Ground'
    OnClick = BtnGroundClick
    HighlightedMild = True
    Styled = True
  end
  object BtnOpen: TRSSpeedButton
    Left = 0
    Top = 0
    Width = 48
    Height = 40
    Caption = 'Open'
    OnClick = BtnOpenClick
    HighlightedMild = True
    Styled = True
  end
  object BtnSave: TRSSpeedButton
    Left = 48
    Top = 0
    Width = 48
    Height = 40
    Caption = 'Save'
    OnClick = BtnSaveClick
    HighlightedMild = True
    Styled = True
  end
  object BtnExport: TRSSpeedButton
    Left = 96
    Top = 80
    Width = 48
    Height = 40
    Caption = 'Export'
    OnClick = BtnExportClick
    HighlightedMild = True
    Styled = True
  end
  object BtnSaveAs: TRSSpeedButton
    Left = 96
    Top = 0
    Width = 48
    Height = 40
    Caption = 'Save As'
    OnClick = BtnSaveAsClick
    HighlightedMild = True
    Styled = True
  end
  object BtnLoadBlv: TRSSpeedButton
    Left = 48
    Top = 40
    Width = 48
    Height = 40
    Caption = 'Internal~Map'
    OnClick = BtnLoadBlvClick
    HighlightedMild = True
    Styled = True
  end
  object BtnCompile: TRSSpeedButton
    Left = 96
    Top = 40
    Width = 48
    Height = 40
    Caption = 'Compile'
    OnClick = BtnCompileClick
    HighlightedMild = True
    Styled = True
  end
  object BtnShowInvisible: TRSSpeedButton
    Left = 96
    Top = 126
    Width = 48
    Height = 40
    AllowAllUp = True
    GroupIndex = 3
    Caption = 'Show~Invis'
    OnClick = SimpleBtnClick
    HighlightedMild = True
    Styled = True
  end
  object BtnNew: TRSSpeedButton
    Left = 0
    Top = 40
    Width = 48
    Height = 40
    Caption = 'New'
    OnClick = BtnNewClick
    HighlightedMild = True
    Styled = True
  end
  object BtnContinue: TRSSpeedButton
    Left = 40
    Top = 268
    Width = 64
    Height = 40
    Caption = 'Continue'
    Visible = False
    OnClick = BtnContinueClick
    HighlightedMild = True
    Styled = True
  end
  object BtnNoDark: TRSSpeedButton
    Left = 48
    Top = 126
    Width = 48
    Height = 40
    AllowAllUp = True
    GroupIndex = 2
    Caption = 'No~Dark'
    OnClick = SimpleBtnClick
    HighlightedMild = True
    Styled = True
  end
  object BtnDiscard: TRSSpeedButton
    Left = 40
    Top = 314
    Width = 64
    Height = 40
    Caption = 'Discard'
    Visible = False
    OnClick = BtnNewClick
    HighlightedMild = True
    Styled = True
  end
  object BtnShowPortals: TRSSpeedButton
    Left = 0
    Top = 126
    Width = 48
    Height = 40
    AllowAllUp = True
    GroupIndex = 1
    Caption = 'Portals'
    OnClick = SimpleBtnClick
    HighlightedMild = True
    Styled = True
  end
  object BtnImportObjects: TRSSpeedButton
    Left = 0
    Top = 80
    Width = 48
    Height = 40
    Caption = 'Import~Objects'
    OnClick = BtnImportClick
    HighlightedMild = True
    Styled = True
  end
  object BtnChests: TRSSpeedButton
    Left = 0
    Top = 172
    Width = 48
    Height = 40
    AllowAllUp = True
    GroupIndex = 4
    Caption = 'Chests'
    OnClick = BtnChestsClick
    HighlightedMild = True
    Styled = True
  end
  object BtnUndo: TRSSpeedButton
    Left = 48
    Top = 172
    Width = 48
    Height = 20
    Caption = 'Undo'
    OnClick = BtnUndoClick
    HighlightedMild = True
    Styled = True
  end
  object BtnRedo: TRSSpeedButton
    Left = 48
    Top = 192
    Width = 48
    Height = 20
    Caption = 'Redo'
    OnClick = BtnUndoClick
    HighlightedMild = True
    Styled = True
  end
  object BtnUpdateBSP: TRSSpeedButton
    Left = 0
    Top = 126
    Width = 48
    Height = 40
    Caption = 'Update~BSP'
    OnClick = SimpleBtnClick
    HighlightedMild = True
    Styled = True
  end
  object PanelFacet: TPanel
    Left = 450
    Top = 220
    Width = 144
    Height = 253
    BevelOuter = bvNone
    TabOrder = 0
    Visible = False
    DesignSize = (
      144
      253)
    object BtnSelectDoor: TRSSpeedButton
      Left = 48
      Top = 142
      Width = 48
      Height = 40
      Caption = 'Select~Door'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 144
      Height = 9
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
      ExplicitWidth = 192
    end
    object BtnEditFacet: TRSSpeedButton
      Left = 0
      Top = 8
      Width = 48
      Height = 40
      Caption = '&Edit'
      OnClick = BtnEditClick
      HighlightedMild = True
      Styled = True
    end
    object BtnSelectSameTexture: TRSSpeedButton
      Left = 0
      Top = 48
      Width = 48
      Height = 40
      Caption = 'Select~Same~Texture'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnSelectObject: TRSSpeedButton
      Left = 48
      Top = 48
      Width = 48
      Height = 40
      Caption = 'Select~Object'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnNewDoor: TRSSpeedButton
      Left = 48
      Top = 142
      Width = 48
      Height = 40
      Caption = 'New~Door'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnEditDoor: TRSSpeedButton
      Left = 96
      Top = 182
      Width = 48
      Height = 40
      Caption = 'Edit~Door'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnChangeDoorShape: TRSSpeedButton
      Left = 48
      Top = 182
      Width = 48
      Height = 40
      Caption = 'Door~Shape'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnEditRoom: TRSSpeedButton
      Left = 96
      Top = 94
      Width = 48
      Height = 40
      Caption = 'Edit~Room'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnChangeTexture: TRSSpeedButton
      Left = 48
      Top = 8
      Width = 48
      Height = 40
      Caption = '&Texture'
      OnClick = BtnChangeTextureClick
      HighlightedMild = True
      Styled = True
    end
    object BtnDoorState: TRSSpeedButton
      Left = 96
      Top = 142
      Width = 48
      Height = 40
      Caption = 'Door~State'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
      OnWndProc = SimpleBtnDblWndProc
    end
    object BtnDeselect: TRSSpeedButton
      Left = 112
      Top = 10
      Width = 32
      Height = 31
      Hint = 'Deselect'
      Caption = '[X]'
      OnClick = BtnDeselectClick
      HighlightedMild = True
      Styled = True
    end
    object BtnDeleteDoor: TRSSpeedButton
      Left = 0
      Top = 182
      Width = 48
      Height = 40
      Caption = 'Delete~Door'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnModelMode1: TRSSpeedButton
      Left = 48
      Top = 134
      Width = 48
      Height = 40
      Caption = 'Model'
      OnClick = BtnModelMode1Click
      HighlightedMild = True
      Styled = True
    end
  end
  object PanelSprite: TPanel
    Left = 300
    Top = 220
    Width = 144
    Height = 253
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    DesignSize = (
      144
      253)
    object BtnSelectSameSprite: TRSSpeedButton
      Left = 0
      Top = 48
      Width = 48
      Height = 40
      Caption = 'Select~Similar'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnEditKind: TRSSpeedButton
      Left = 48
      Top = 8
      Width = 48
      Height = 40
      Caption = '&Type'
      OnClick = BtnEditKindClick
      HighlightedMild = True
      Styled = True
    end
    object BtnSaveModel: TRSSpeedButton
      Left = 48
      Top = 8
      Width = 48
      Height = 40
      Caption = 'Save'
      Visible = False
      OnClick = BtnSaveModelClick
      HighlightedMild = True
      Styled = True
    end
    object Bevel2: TBevel
      Left = 0
      Top = 0
      Width = 144
      Height = 9
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
    end
    object BtnEditObject: TRSSpeedButton
      Left = 0
      Top = 8
      Width = 48
      Height = 40
      Caption = '&Edit'
      OnClick = BtnEditClick
      HighlightedMild = True
      Styled = True
    end
    object BtnDeselect2: TRSSpeedButton
      Left = 112
      Top = 10
      Width = 32
      Height = 32
      Hint = 'Deselect'
      Caption = '[X]'
      OnClick = BtnDeselectClick
      HighlightedMild = True
      Styled = True
    end
    object BtnDelete: TRSSpeedButton
      Left = 0
      Top = 183
      Width = 48
      Height = 40
      Caption = 'Delete'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnClone: TRSSpeedButton
      Left = 96
      Top = 183
      Width = 48
      Height = 40
      Caption = '&Clone'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnMoveToParty: TRSSpeedButton
      Left = 48
      Top = 48
      Width = 48
      Height = 40
      Caption = 'Move To~&Party'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnLand: TRSSpeedButton
      Left = 96
      Top = 48
      Width = 48
      Height = 40
      Caption = '&Land'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnAlignX: TRSSpeedButton
      Left = 0
      Top = 88
      Width = 48
      Height = 40
      Caption = 'Align X'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnAlignY: TRSSpeedButton
      Left = 48
      Top = 88
      Width = 48
      Height = 40
      Caption = 'Align Y'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnAlignZ: TRSSpeedButton
      Left = 96
      Top = 88
      Width = 48
      Height = 40
      Caption = 'Align Z'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
    object BtnMonItem: TRSSpeedButton
      Left = 48
      Top = 128
      Width = 48
      Height = 40
      Caption = 'Item'
      OnClick = BtnMonItemClick
      HighlightedMild = True
      Styled = True
    end
    object BtnModelMode2: TRSSpeedButton
      Left = 48
      Top = 134
      Width = 48
      Height = 40
      GroupIndex = 1
      Down = True
      Caption = 'Model'
      OnClick = BtnModelMode1Click
      HighlightedMild = True
      Styled = True
    end
    object BtnSelectAll: TRSSpeedButton
      Left = 0
      Top = 48
      Width = 48
      Height = 40
      Caption = 'Select~All'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
  end
  object PanelNone: TPanel
    Left = 150
    Top = 220
    Width = 144
    Height = 253
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    DesignSize = (
      144
      253)
    object Bevel3: TBevel
      Left = 0
      Top = 0
      Width = 144
      Height = 9
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
      ExplicitWidth = 192
    end
    object BtnNewSprite: TRSSpeedButton
      Left = 0
      Top = 8
      Width = 48
      Height = 40
      GroupIndex = 1
      Down = True
      Caption = 'Sprite'
      OnClick = BtnNewSpriteClick
      HighlightedMild = True
      Styled = True
    end
    object BtnNewMonster: TRSSpeedButton
      Left = 48
      Top = 8
      Width = 48
      Height = 40
      GroupIndex = 1
      Caption = 'Monster'
      OnClick = BtnNewSpriteClick
      HighlightedMild = True
      Styled = True
    end
    object BtnNewItem: TRSSpeedButton
      Left = 96
      Top = 8
      Width = 48
      Height = 40
      GroupIndex = 1
      Caption = 'Item'
      OnClick = BtnNewSpriteClick
      HighlightedMild = True
      Styled = True
    end
    object BtnNewSpawn: TRSSpeedButton
      Left = 48
      Top = 48
      Width = 48
      Height = 40
      GroupIndex = 1
      Caption = 'Spawn'
      OnClick = BtnNewSpriteClick
      HighlightedMild = True
      Styled = True
    end
    object BtnNewLight: TRSSpeedButton
      Left = 0
      Top = 48
      Width = 48
      Height = 40
      GroupIndex = 1
      Caption = 'Light'
      OnClick = BtnNewLightClick
      HighlightedMild = True
      Styled = True
    end
    object BtnCreate: TRSSpeedButton
      Left = 96
      Top = 184
      Width = 48
      Height = 40
      Caption = '&Create'
      OnClick = BtnCreateClick
      HighlightedMild = True
      Styled = True
    end
    object BtnNewKind: TRSSpeedButton
      Left = 96
      Top = 48
      Width = 48
      Height = 40
      Caption = '&Type'
      OnClick = BtnNewKindClick
      HighlightedMild = True
      Styled = True
    end
    object BtnAutoLand: TRSSpeedButton
      Left = 96
      Top = 94
      Width = 48
      Height = 40
      AllowAllUp = True
      GroupIndex = 2
      Caption = 'Auto~Land'
      OnClick = BtnAutoLandClick
      HighlightedMild = True
      Styled = True
    end
    object BtnEditMapProps: TRSSpeedButton
      Left = 0
      Top = 94
      Width = 48
      Height = 40
      Caption = 'Map~Setup'
      OnClick = SimpleBtnClick
      HighlightedMild = True
      Styled = True
    end
  end
  object PanelChests: TPanel
    Left = 0
    Top = 220
    Width = 144
    Height = 253
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    DesignSize = (
      144
      253)
    object Bevel4: TBevel
      Left = 0
      Top = 0
      Width = 144
      Height = 9
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
      ExplicitWidth = 192
    end
    object BtnTestChest: TRSSpeedButton
      Left = 96
      Top = 213
      Width = 48
      Height = 40
      Anchors = [akLeft, akBottom]
      Caption = '&Test'
      OnClick = BtnTestChestClick
      HighlightedMild = True
      Styled = True
    end
    object BtnDeleteChest: TRSSpeedButton
      Left = 0
      Top = 213
      Width = 48
      Height = 40
      Anchors = [akLeft, akBottom]
      Caption = 'Delete'
      OnClick = BtnDeleteChestClick
      HighlightedMild = True
      Styled = True
    end
    object BtnEditChest: TRSSpeedButton
      Left = 48
      Top = 213
      Width = 48
      Height = 40
      Anchors = [akLeft, akBottom]
      Caption = '&Edit'
      OnClick = BtnEditChestClick
      HighlightedMild = True
      Styled = True
    end
    object ListChests: TRSListBox
      Left = 0
      Top = 8
      Width = 144
      Height = 199
      Anchors = [akLeft, akTop, akBottom]
      BevelInner = bvSpace
      BevelKind = bkFlat
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      Items.Strings = (
        'Error')
      ParentFont = False
      TabOrder = 0
      TabWidth = 17
      OnDblClick = BtnEditChestClick
      OnWndProc = ListChestsWndProc
    end
  end
  object PanelGround: TPanel
    Left = 600
    Top = 220
    Width = 144
    Height = 253
    BevelOuter = bvNone
    TabOrder = 4
    Visible = False
    DesignSize = (
      144
      253)
    object Bevel5: TBevel
      Left = 0
      Top = 0
      Width = 144
      Height = 9
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
      ExplicitWidth = 192
    end
    object BtnTiles: TRSSpeedButton
      Left = 0
      Top = 8
      Width = 48
      Height = 40
      GroupIndex = 1
      Down = True
      Caption = 'Tiles'
      OnClick = BtnTilesClick
      HighlightedMild = True
      Styled = True
    end
    object BtnHeight: TRSSpeedButton
      Tag = 1
      Left = 48
      Top = 8
      Width = 48
      Height = 40
      GroupIndex = 1
      Caption = 'Height'
      OnClick = BtnTilesClick
      HighlightedMild = True
      Styled = True
    end
    object BtnDeselect3: TRSSpeedButton
      Left = 112
      Top = 10
      Width = 32
      Height = 31
      Hint = 'Deselect'
      Caption = '[X]'
      OnClick = BtnDeselect3Click
      HighlightedMild = True
      Styled = True
    end
    object Label1: TLabel
      Left = 15
      Top = 57
      Width = 27
      Height = 13
      Alignment = taRightJustify
      Caption = 'Brush'
    end
    object PanelTiles: TPanel
      Left = 0
      Top = 81
      Width = 144
      Height = 144
      BevelOuter = bvNone
      TabOrder = 2
      object BtnTileset2: TRSSpeedButton
        Tag = 2
        Left = 48
        Top = 0
        Width = 48
        Height = 40
        GroupIndex = 1
        Caption = '2'
        OnClick = BtnTileset1Click
        HighlightedMild = True
        Styled = True
        OnPaint = BtnTileset1Paint
      end
      object BtnTileset3: TRSSpeedButton
        Tag = 3
        Left = 96
        Top = 0
        Width = 48
        Height = 40
        GroupIndex = 1
        Caption = '3'
        OnClick = BtnTileset1Click
        HighlightedMild = True
        Styled = True
        OnPaint = BtnTileset1Paint
      end
      object BtnRoad: TRSSpeedButton
        Tag = 4
        Left = 48
        Top = 40
        Width = 48
        Height = 40
        GroupIndex = 1
        Caption = 'Road'
        OnClick = BtnTileset1Click
        HighlightedMild = True
        Styled = True
        OnPaint = BtnTileset1Paint
      end
      object BtnRoadDiag: TRSSpeedButton
        Tag = 5
        Left = 96
        Top = 40
        Width = 48
        Height = 40
        GroupIndex = 1
        Caption = 'D. Road'
        OnClick = BtnTileset1Click
        HighlightedMild = True
        Styled = True
        OnPaint = BtnTileset1Paint
      end
      object BtnChangeTilesFile: TRSSpeedButton
        Left = 0
        Top = 101
        Width = 48
        Height = 40
        Caption = 'Change~Tiles~File'
        OnClick = BtnChangeTilesFileClick
        HighlightedMild = True
        Styled = True
      end
      object BtnChangeTileset: TRSSpeedButton
        Left = 48
        Top = 101
        Width = 48
        Height = 40
        Caption = 'Change~Tileset'
        Enabled = False
        OnClick = BtnChangeTilesetClick
        HighlightedMild = True
        Styled = True
      end
      object BtnTileset0: TRSSpeedButton
        Left = 0
        Top = 40
        Width = 48
        Height = 40
        GroupIndex = 1
        Down = True
        Caption = '0'
        OnClick = BtnTileset1Click
        HighlightedMild = True
        Styled = True
        OnPaint = BtnTileset1Paint
      end
      object BtnTileset1: TRSSpeedButton
        Tag = 1
        Left = 0
        Top = 0
        Width = 48
        Height = 40
        GroupIndex = 1
        Caption = '1'
        OnClick = BtnTileset1Click
        HighlightedMild = True
        Styled = True
        OnPaint = BtnTileset1Paint
      end
    end
    object PanelHeight: TPanel
      Left = 0
      Top = 81
      Width = 144
      Height = 160
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      object BtnHeightMode1: TRSSpeedButton
        Left = 0
        Top = 29
        Width = 48
        Height = 40
        GroupIndex = 1
        Down = True
        Caption = '+ Flat'
        OnClick = BtnHeightMode1Click
        HighlightedMild = True
        Styled = True
      end
      object BtnHeightMode2: TRSSpeedButton
        Tag = 1
        Left = 0
        Top = 69
        Width = 48
        Height = 40
        GroupIndex = 1
        Caption = '- Flat'
        OnClick = BtnHeightMode1Click
        HighlightedMild = True
        Styled = True
      end
      object BtnHeightMode5: TRSSpeedButton
        Tag = 4
        Left = 96
        Top = 29
        Width = 48
        Height = 40
        GroupIndex = 1
        Caption = 'Flatten'
        OnClick = BtnHeightMode1Click
        HighlightedMild = True
        Styled = True
      end
      object BtnHeightMode3: TRSSpeedButton
        Tag = 2
        Left = 48
        Top = 29
        Width = 48
        Height = 40
        GroupIndex = 1
        Caption = '+ Soft'
        OnClick = BtnHeightMode1Click
        HighlightedMild = True
        Styled = True
      end
      object BtnHeightMode4: TRSSpeedButton
        Tag = 3
        Left = 48
        Top = 69
        Width = 48
        Height = 40
        GroupIndex = 1
        Caption = '- Soft'
        OnClick = BtnHeightMode1Click
        HighlightedMild = True
        Styled = True
      end
      object BtnHeightMode6: TRSSpeedButton
        Tag = 5
        Left = 96
        Top = 69
        Width = 48
        Height = 40
        GroupIndex = 1
        Caption = 'Smooth~Out'
        OnClick = BtnHeightMode1Click
        HighlightedMild = True
        Styled = True
      end
      object Label2: TLabel
        Left = 12
        Top = 4
        Width = 30
        Height = 13
        Alignment = taRightJustify
        Caption = 'Speed'
      end
      object BtnSaveHeightMap: TRSSpeedButton
        Left = 48
        Top = 123
        Width = 48
        Height = 34
        Caption = 'Save'
        OnClick = BtnSaveHeightMapClick
        HighlightedMild = True
        Styled = True
      end
      object BtnLoadHeightMap: TRSSpeedButton
        Left = 0
        Top = 123
        Width = 48
        Height = 34
        Caption = 'Load'
        OnClick = BtnLoadHeightMapClick
        HighlightedMild = True
        Styled = True
      end
      object EditBrushSpeed: TRSSpinEdit
        Left = 48
        Top = 1
        Width = 73
        Height = 21
        Button.Left = 54
        Button.Top = 0
        Button.Width = 15
        Button.Height = 17
        Button.DownButton.Left = 0
        Button.DownButton.Top = 9
        Button.DownButton.Width = 15
        Button.DownButton.Height = 8
        Button.FocusControl = EditBrushSpeed
        Button.SpinFactor = 15
        Button.UpButton.Left = 0
        Button.UpButton.Top = 0
        Button.UpButton.Width = 15
        Button.UpButton.Height = 9
        Button.TabOrder = 0
        OnChange = EditBrushSpeedChange
        TabOrder = 0
        MaxValue = 50
        MinValue = 1
        Value = 3
      end
    end
    object EditBrushSize: TRSSpinEdit
      Left = 48
      Top = 54
      Width = 73
      Height = 21
      Button.Left = 54
      Button.Top = 0
      Button.Width = 15
      Button.Height = 17
      Button.DownButton.Left = 0
      Button.DownButton.Top = 9
      Button.DownButton.Width = 15
      Button.DownButton.Height = 8
      Button.FocusControl = EditBrushSize
      Button.SpinFactor = 15
      Button.UpButton.Left = 0
      Button.UpButton.Top = 0
      Button.UpButton.Width = 15
      Button.UpButton.Height = 9
      Button.TabOrder = 0
      OnChange = EditBrushSizeChange
      TabOrder = 1
      MaxValue = 400
      MinValue = 1
      Value = 2
    end
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 264
  end
  object OpenDatDialog: TOpenDialog
    DefaultExt = '.dat'
    Filter = 
      'Map Files (*.dat;*.odt)|*.dat;*.odt|Indoor Map Files (*.dat)|*.d' +
      'at|Outdoor Map Files (*.odt)|*.odt|All Files|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    OnTypeChange = OpenDatDialogTypeChange
    Left = 200
  end
  object SaveDatDialog: TSaveDialog
    DefaultExt = '.dat'
    Filter = 
      'Indoor Map Files (*.dat)|*.dat|!Oudoor Map Files (*.odt)|*.odt|!' +
      'All Files|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 232
  end
  object OpenObjDialog: TOpenDialog
    DefaultExt = '.obj'
    Filter = 'Obj Files (*.obj)|*.obj|All Files|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 200
    Top = 32
  end
  object SaveObjDialog: TSaveDialog
    DefaultExt = '.obj'
    Filter = 'Obj Files (*.obj)|*.obj|All Files|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 232
    Top = 32
  end
  object SaveBlvDialog: TSaveDialog
    DefaultExt = '.blv'
    Filter = 
      'Indoor Levels (*.blv)|*.blv|!Outdoor Levels (*.odm)|*.odm|!All F' +
      'iles|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 264
    Top = 32
  end
  object PopupTilesFile: TPopupMenu
    Left = 600
    Top = 184
    object ItemTile1: TMenuItem
      Caption = 'Tile'
      OnClick = ItemTile1Click
    end
    object ItemTile2: TMenuItem
      Tag = 1
      Caption = 'Tile2'
      OnClick = ItemTile1Click
    end
    object ItemTile3: TMenuItem
      Tag = 2
      Caption = 'Tile3'
      OnClick = ItemTile1Click
    end
  end
  object OpenModelDialog: TOpenDialog
    DefaultExt = '.mdt'
    Filter = 'Model Files (*.mdt;*.obj)|*.mdt;*.obj|All Files|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 200
    Top = 64
  end
  object SaveModelDialog: TSaveDialog
    DefaultExt = '.mdt'
    Filter = 'Model Files (*.mdt)|*.mdt|Obj Files (*.obj)|*.obj|All Files|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    OnTypeChange = SaveModelDialogTypeChange
    Left = 232
    Top = 64
  end
  object OpenBmpDialog: TOpenDialog
    DefaultExt = '.bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp|All Files|*.*'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 200
    Top = 96
  end
  object SaveBmpDialog: TSaveDialog
    DefaultExt = '.bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp|All Files|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    OnTypeChange = SaveModelDialogTypeChange
    Left = 232
    Top = 96
  end
  object RSDesignerDPI1: TRSDesignerDPI
    DPI = 96
    Left = 300
  end
end
