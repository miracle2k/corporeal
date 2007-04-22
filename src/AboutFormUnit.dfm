object AboutForm: TAboutForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 331
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollingCredits: TScrollingCredits
    AlignWithMargins = True
    Left = 10
    Top = 56
    Width = 278
    Height = 237
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Credits.Strings = (
      '')
    CreditsFont.Charset = DEFAULT_CHARSET
    CreditsFont.Color = clBlack
    CreditsFont.Height = -11
    CreditsFont.Name = 'Tahoma'
    CreditsFont.Style = []
    BackgroundColor = clWhite
    BorderColor = clBlack
    Animate = False
    Interval = 50
    ShowBorder = True
    Align = alClient
    ExplicitLeft = 66
    ExplicitTop = -6
    ExplicitHeight = 273
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 296
    Width = 298
    Height = 35
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      298
      35)
    object OKButton: TButton
      Left = 212
      Top = 3
      Width = 76
      Height = 25
      Anchors = [akLeft, akRight, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 298
    Height = 46
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object WebsiteLink: TLabel
      Left = 182
      Top = 31
      Width = 105
      Height = 13
      Cursor = crHandPoint
      Margins.Bottom = 0
      Alignment = taRightJustify
      Caption = '%DYNAMICTEXT%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = WebsiteLinkClick
      OnMouseEnter = WebsiteLinkMouseEnter
      OnMouseLeave = WebsiteLinkMouseLeave
    end
    object VersionLabel: TLabel
      Left = 195
      Top = 12
      Width = 92
      Height = 13
      Margins.Bottom = 0
      Alignment = taRightJustify
      Caption = '%DYNAMICTEXT%'
    end
  end
end
