object OpenStoreForm: TOpenStoreForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Choose / Create Password Store'
  ClientHeight = 184
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    476
    184)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel2: TBevel
    Left = 0
    Top = 41
    Width = 476
    Height = 11
    Align = alTop
    Shape = bsTopLine
    ExplicitLeft = -224
    ExplicitTop = 18
    ExplicitWidth = 348
  end
  object Bevel1: TBevel
    Left = 0
    Top = 142
    Width = 476
    Height = 42
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 140
    ExplicitWidth = 424
  end
  object Label1: TLabel
    Left = 31
    Top = 58
    Width = 74
    Height = 13
    Alignment = taRightJustify
    Caption = 'Selected Store:'
  end
  object StoreFilenameLabel: TJvLabel
    Left = 120
    Top = 58
    Width = 257
    Height = 13
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Anchors = [akLeft, akTop, akRight]
    ParentFont = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
    TextEllipsis = tePathEllipsis
  end
  object KeyLabel: TLabel
    Left = 54
    Top = 93
    Width = 51
    Height = 13
    Alignment = taRightJustify
    Caption = 'Enter Key:'
  end
  object QualityLabel: TLabel
    Left = 366
    Top = 120
    Width = 3
    Height = 13
    Alignment = taRightJustify
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 476
    Height = 41
    Align = alTop
    BevelEdges = [beLeft, beTop, beBottom]
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object FormHeaderLabel: TLabel
      Left = 45
      Top = 11
      Width = 161
      Height = 18
      Caption = 'Open Password Store'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Image1: TImage
      Left = 6
      Top = 4
      Width = 32
      Height = 32
      AutoSize = True
      Picture.Data = {
        0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000002000
        0000200806000000737A7AF40000000774494D45000000000000000973942E00
        00001774455874536F66747761726500474C44504E472076657220332E347185
        A4E10000000874704E47474C4433000000004A80291F0000000467414D410000
        B18F0BFC6105000007BC4944415478DAAD970B5054E715C7FF77F7EE835D2822
        B20BB20521D50495C447C447E25443CC24DAD09A8D688A9D96646A67AC561D5F
        CD283A4E121A27C5B4E90ED68989C6D0B4A901934913B48A46D028F8084A7C20
        0F5F8BC022C202BBECE33E7AEEBD9FE2648222CD9DF9CFBD77BEBBE7FCBE73CE
        77BE6F390CE272381C11191919D3B3B2B2326D36DB2CBD5E6FF4FBFD3DCDCDCD
        A7F7EEDD5B525E5E5ED5D9D9D935105BDC833ACFCDCD9D3861C284A59999993F
        B3DBEDB156AB15B22C23180CA2A7A707E7CE9D6B2D2B2BFBDCE572AD2228EF0F
        06101515655DB264C9EFE6CF9FFF665A5A9A81E338D569281482288A2AC4ED7B
        7B7B3B76ECD851BC7DFBF6B5DDDDDD0D3F08C0FAF5EBF3727272568D1C39F247
        8AD34020A03A53A4BC0B82004992D467E56A6868F0151414E41F3870E06D7AED
        1D3400CD9C5BB468D1C2C58B17EF4A4E4E56C3AC38519CB5B5B549C78E1FF750
        D85B4422C8CECE1E9D909060F1F97CEA37A5A5A5D51B376E9C47661A49D2A000
        D2D3D3876FDAB4E9232AB89FF6F6F64231AE84BFAEAE2EFC61D13F6AF6ECD9F3
        C5AD5BEDE79292538D852ED76BE3C6A527BBDD6E15E0D4A953CD4B972E759299
        93A4F0A000E6CE9D3B2B3F3FFFE3A4A4A418AFD7ABE6F97A53B3B8216FC37FCB
        0FEF2F1E3F5CACB48808A4243AD27FBD7EEBDB691993931B1B1BD5FAA8A9A969
        A3BAC92133E5A4E0A0000A0B0B5F9A3D7BF6AEE8E8689E9616022101078B3FF6
        54FC3B6FF7A316709969FA8448B39CC0A5C6DABDE3FFEE48193DCD40D1516BE4
        E2C58B6D1481850C20302880BFB95C397366CFD969369B78AA6874747AE550D5
        3A714CE27EBD298DE3CCC932F466A0A3C386FAFAAD48744CC1850B175480FAFA
        FAB6E5CB97FF7F00FFD9BAE095479EC9DF66321AF44A043A3B3A30DCBE1AA9A3
        2AB5AC2AA5251040970D75570B919098A1F402F41240CBD5C6CED7DE5899DBDC
        867DE86725F40BB0E617485EF4385E6AD34D5B1597BD2B56A7D3A9EBBBABAB0B
        298E579192540588B803E16948407DB70BB18EB1384F004AAAB8963AC49C5877
        6A7325561FAAC7617CCF4AF85E802DCF70639F7D58BF35EE696152D7C86926C1
        B0139C0C65D9A9CBF0273FCE43AAA34A73AE88409A8EC7E36CA000291327E24C
        7535026101BAD6EB7836F0AA58B59F3FB3F996F0DB8A1A9CD1BEBE07C0B7CB90
        6B30F0F9A9EB84787E0870E5F25404C33B2184C3686D6D85DFEF435AD2EB7828
        BE4AABEB909682502750B36F221A86FD0A3E514F60418C683A88998F7D89DE68
        E0EBBD7CF5CAAF843F3C34DA79B4A4A458EA17E0EBA7749FA5BBA4ACC851DAFB
        85AFA6834B7817212108DA6CE0F7F931266E334625556ACE6F43D03D4C10ED0D
        7108F658C087C288B17A60C924BA18E05FBFE16B57560979539F737E5A5C5C1C
        EE17E0F093BA4F1FFF40FAB96584367AF2AFD3204D7A07BA080E4D4D6EF8BB42
        48B9E2C294799452EF5D00BDACCE7DCCAA8394426A273503459B0C97569D0A6F
        78F20567C9FD01761240AA367AF34834BEA95880CEF8A7D02B09D05FABC3A4A8
        0F306AC665A09B3956A43C539D600473EC27B530400B01AC2180130301788201
        8C60E5C2D3ED1A4DA4C282A037024387DE82C52E830BB2714A374C243B29125A
        545AD918F5074468E345BF2780CA8102282948644644E6C0C3C2A9633232E70A
        480FA98B3DDF1E336BF0EA5D017885008E0D04601A03B031E721768F22D5913A
        58C87D6C4CAFCD52A67189AC71E450A7001B988C0CE097047074A000EF13402C
        FA3A5D48CB23BE60CFA6BED0AA772BF588D36678BFB5C2102B21FE792F4C7192
        0667D454348F008E0C04602A016C2380183673818556013AC6A04C4C6458A459
        BA4BA3D0BA6F188624F3305928EE491E24AF68D7600D2C02CF1340C54000A610
        808B01087701C4936AEEAA0966B8BB89C7C5BFD860329910318487399287ECF0
        206975BBF63B9686A2E708A07C20009309A0800086A0AFD707D8D2BAC25262EC
        CBADA7220297B70D8365288F0892AC9330EC653762A60435EBAC288B9E1E2840
        0601BC4900D16CF6B7011E26DD64007C5F14BC978CA87B230E46B31196580230
        08885FE146D423CC07AF017C9469B8B4F25078C313F70338344EF7C9C40DD20B
        51761A0B3208A5EAC73310898595D7140A71B8B42E0E52AB5505D0F31CAC2FBA
        61CBF2AB8D495919BE1AC85BE6F147B7D40B6FCD723A4BEF09303F12D92B661A
        DE9AB42C9CA41359FE1580C92C9CAC39A91054E57EAF1EB5CB6CD007CD301829
        02A284A1B9AD889FDFA3DA6BD9AD134AFECC35E49D10DFBB25E34BA7D3799E00
        E47E0194808D3520E3F50CFE9D190B8447A3C9B6DA686642EB7452DFEC1580EE
        F306D4AE8D83C92E21F2B15EC4BDD883088788CE93104FBCA7F714FC532E3B14
        92CA44ED54741DDF399CF67720314C32EBA6FF71B4EE4F735E16324CCA7A9E45
        1AC600749A730522DCCDC1576740448AA042749D06AEEED6F7EEF804559F5D17
        8F368651465FD642DB19C4EF3ABAD7914C47CB3A656D2A5FE89C21CDB0AD918C
        48BC3D42E9250099CC85A8EF073D901A0FEABC67CAB89B9F1F91BF39E8972A3B
        6554D397CABFA21BE8E7487E3F00D5D5701E63D6DAF94DB9EF0A73ADD3C9999B
        9CDED4A1AB96136F9CE57A6ACECAEEAA6BF2B5A36EB9A629245FA2BDE822FDAE
        09DA96A494AD7C2F0703FA6B66E510BB3046BFD66CE246B6FA649F2720B7D786
        A52B3764B4C87DDB94E250D992FCF773FAC000EC529AB14DCBFC9DA387A220EE
        9C0C1FFCFA1F5207C54EF78B2A6C0000000049454E44AE426082}
    end
  end
  object LoadButton: TButton
    Left = 393
    Top = 151
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Load'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 151
    Width = 113
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Create New'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 393
    Top = 52
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Change'
    TabOrder = 3
    OnClick = Button3Click
  end
  object KeyEdit: TEdit
    Left = 120
    Top = 90
    Width = 257
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    PasswordChar = '*'
    TabOrder = 4
    OnChange = KeyEditChange
  end
  object MakeDefaultCheckBox: TJvCheckBox
    Left = 178
    Top = 157
    Width = 199
    Height = 17
    Alignment = taRightJustify
    Anchors = [akRight, akBottom]
    BiDiMode = bdLeftToRight
    Caption = 'Make this store the default'
    ParentBiDiMode = False
    TabOrder = 5
    LinkedControls = <>
    AutoSize = False
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
    Layout = tlTop
    LeftText = True
  end
  object SelectStoreDialog: TOpenDialog
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 252
    Top = 3
  end
  object CreateStoreDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 280
  end
end
