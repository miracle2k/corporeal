object ConfigForm: TConfigForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Configuration'
  ClientHeight = 226
  ClientWidth = 428
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
  object JvGroupBox1: TJvGroupBox
    Left = 16
    Top = 8
    Width = 397
    Height = 169
    Caption = 'Enable Online Synchronization'
    TabOrder = 0
    Checkable = True
    PropagateEnable = True
    DesignSize = (
      397
      169)
    object Label1: TLabel
      Left = 40
      Top = 96
      Width = 37
      Height = 13
      Caption = 'API Url:'
    end
    object Image1: TImage
      Left = 16
      Top = 24
      Width = 32
      Height = 32
      AutoSize = True
    end
    object TntLabel1: TLabel
      Left = 64
      Top = 24
      Width = 313
      Height = 63
      AutoSize = False
      WordWrap = True
    end
    object Edit1: TEdit
      Left = 88
      Top = 93
      Width = 293
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
  end
end
