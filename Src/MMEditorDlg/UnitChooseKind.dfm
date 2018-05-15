object FormChooseKind: TFormChooseKind
  Left = 0
  Top = 0
  Caption = 'Choose Type'
  ClientHeight = 583
  ClientWidth = 854
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnPaint = FormPaint
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 17
  object Panel4: TRSPanel
    Left = 0
    Top = 545
    Width = 854
    Height = 38
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      854
      38)
    object Panel5: TRSPanel
      Left = 322
      Top = 3
      Width = 210
      Height = 32
      Anchors = [akTop]
      BevelOuter = bvNone
      TabOrder = 0
      object Button1: TButton
        Left = 0
        Top = 0
        Width = 98
        Height = 32
        Align = alLeft
        Caption = 'OK'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 111
        Top = 0
        Width = 99
        Height = 32
        Align = alRight
        Caption = 'Cancel'
        TabOrder = 1
        OnClick = Button2Click
      end
    end
  end
  object ListView1: TRSListView
    Left = 0
    Top = 0
    Width = 854
    Height = 545
    Align = alClient
    BevelInner = bvSpace
    BevelKind = bkFlat
    BorderStyle = bsNone
    Columns = <>
    HideSelection = False
    LargeImages = ImageList1
    MultiSelect = True
    OwnerData = True
    TabOrder = 1
    OnAdvancedCustomDrawItem = ListView1AdvancedCustomDrawItem
    OnData = ListView1Data
    OnDataFind = ListView1DataFind
    OnDblClick = ListView1DblClick
    OnKeyDown = ListView1KeyDown
    OnMouseDown = ListView1MouseDown
  end
  object ImageList1: TImageList
    Height = 190
    Width = 150
    Left = 16
    Top = 8
  end
end
