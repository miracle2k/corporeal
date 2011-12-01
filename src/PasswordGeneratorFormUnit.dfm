object PasswordGeneratorForm: TPasswordGeneratorForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Password Wizard'
  ClientHeight = 212
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  DesignSize = (
    276
    212)
  PixelsPerInch = 96
  TextHeight = 13
  object TntLabel1: TLabel
    Left = 8
    Top = 144
    Width = 108
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Number of characters:'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 170
    Width = 276
    Height = 42
    Align = alBottom
    Shape = bsTopLine
    ExplicitLeft = -72
    ExplicitTop = 255
    ExplicitWidth = 348
  end
  object CharSpacesList: TCheckListBox
    Left = 8
    Top = 8
    Width = 260
    Height = 116
    Anchors = [akLeft, akTop, akRight, akBottom]
    IntegralHeight = True
    ItemHeight = 14
    Items.Strings = (
      'Uppercase alphabetic (A-Z)'
      'Lowercase alphabetic (a-z)'
      'Numbers (0-9)'
      'Underline '#39'_'#39
      'Minus '#39'-'#39
      'Space '#39' '#39
      'Special characters (!, ?, $, %, ...)'
      'Brackets '#39'('#39', '#39')'#39', '#39'['#39', '#39']'#39', '#39'{'#39', '#39'}'#39)
    Style = lbOwnerDrawVariable
    TabOrder = 0
  end
  object PasswordLengthEdit: TJvSpinEdit
    Left = 141
    Top = 141
    Width = 127
    Height = 21
    Alignment = taCenter
    ButtonKind = bkStandard
    MaxValue = 99.000000000000000000
    MinValue = 1.000000000000000000
    Value = 15.000000000000000000
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
  end
  object Button2: TButton
    Left = 193
    Top = 179
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object Button1: TButton
    Left = 112
    Top = 179
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = Button1Click
  end
  object JvBalloonHint: TJvBalloonHint
    DefaultBalloonPosition = bpRightUp
    Left = 40
    Top = 176
  end
end
