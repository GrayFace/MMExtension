object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'MMExtension Debug Console'
  ClientHeight = 530
  ClientWidth = 769
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 120
  TextHeight = 17
  object RSMemo1: TRSMemo
    Left = 0
    Top = 0
    Width = 769
    Height = 530
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    WantTabs = True
    OnKeyDown = RSMemo1KeyDown
    OnKeyPress = RSMemo1KeyPress
    OnWndProc = RSMemo1WndProc
  end
end
