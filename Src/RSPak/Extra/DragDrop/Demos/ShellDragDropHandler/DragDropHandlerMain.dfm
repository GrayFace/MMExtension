object DataModuleDragDropHandler: TDataModuleDragDropHandler
  OldCreateOrder = False
  Height = 479
  Width = 741
  object PopupMenu1: TPopupMenu
    Left = 48
    Top = 72
    object MenuEncrypt: TMenuItem
      Bitmap.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000010000000000000000000
        BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFF000FFFFFFFFFFFF03300FFFFFFFFFF030B30FFFFFFFFF030B
        0B0FFFFFFF0030B0B0FFFF0000330B0B0FFFF0333300B0B0FFFF037B7B3B0B0F
        FFFF07BB3B73B0FFFFFF0BB3B3BB00FFFFFF88303B3B70FFFFFF070F03B3B0FF
        FFFF0B803B3B70FFFFFFF0BB8BB70FFFFFFFFF008000FFFFFFFF}
      Caption = 'Encrypt %s'
      Hint = 'Encrypt the file and place the encrypted file in this directory.'
      OnClick = MenuEncryptClick
    end
    object MenuLine1: TMenuItem
      Caption = '-'
    end
  end
  object DragDropHandler1: TDragDropHandler
    ContextMenu = PopupMenu1
    OnPopup = DragDropHandler1Popup
    Left = 48
    Top = 16
  end
end
