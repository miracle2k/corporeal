object ItemPropertiesForm: TItemPropertiesForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Item Properties'
  ClientHeight = 409
  ClientWidth = 348
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    348
    409)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 60
    Top = 61
    Width = 24
    Height = 13
    Alignment = taRightJustify
    Caption = 'Title:'
  end
  object Label2: TLabel
    Left = 32
    Top = 88
    Width = 52
    Height = 13
    Alignment = taRightJustify
    Caption = 'Username:'
  end
  object Label4: TLabel
    Left = 34
    Top = 115
    Width = 50
    Height = 13
    Alignment = taRightJustify
    Caption = 'Password:'
  end
  object Label6: TLabel
    Left = 45
    Top = 142
    Width = 39
    Height = 13
    Alignment = taRightJustify
    Caption = 'Repeat:'
  end
  object Label3: TLabel
    Left = 52
    Top = 221
    Width = 32
    Height = 13
    Caption = 'Notes:'
  end
  object Bevel1: TBevel
    Left = 0
    Top = 367
    Width = 348
    Height = 42
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 317
  end
  object Bevel2: TBevel
    Left = 0
    Top = 41
    Width = 348
    Height = 11
    Align = alTop
    Shape = bsTopLine
  end
  object Label7: TLabel
    Left = 61
    Top = 196
    Width = 23
    Height = 13
    Alignment = taRightJustify
    Caption = 'URL:'
  end
  object TogglePasswordCharButton: TPngSpeedButton
    Left = 307
    Top = 112
    Width = 23
    Height = 22
    Hint = 'Toggle Hide/Show Passwords'
    AllowAllUp = True
    GroupIndex = 1
    Down = True
    OnClick = TogglePasswordCharButtonClick
    PngImage.Data = {
      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
      610000000774494D45000000000000000973942E0000001774455874536F6674
      7761726500474C44504E472076657220332E347185A4E10000000874704E4747
      4C4433000000004A80291F000002E64944415478DA75935D4893611480CFF6CD
      6D2A73D36D31982365A4BBD0320469118425821715F443505097B130AC46358A
      416584374598232C86FD5CA81114D1922C57D394B9564BA74E71CE4D5DD34DDD
      9CBA3FF7D3597EEAB4FAE0B978CF7BCEF39EEFFDA1C096AFA5A545C0E7F3E55C
      2EB78A46A365F6F5F5BD52ABD50FB55AAD0BA7A34822359F923A686A6A129797
      976B44B9B985A1580C964261882CF8E09D46F35126939DC3945F48F8BF02BD5E
      DF51565676C0EE7245544AA58E32E7A356ABEA0F8E5A2C4B72B9BCA6BFBF5F83
      69EED42ED605FAEE6E3A572070A4A7B305DA279746F5ED2F4C953B8BC4922B6D
      A523665350A1B85667B1585E62AA95FC952D02458138F398DA1426382C21BD32
      26C87311DEE81E98986885A1E1DE48E3E51A956ECAF50C538790954D829EFDBC
      A305B5BEFA19FE7BA1C7CD8692A223C0664E83CF2601A3F339B8DD2690FCB83E
      37D8E36D3E6388D762C9FC5A177F04F35FE83E463E853D60FB00D3013A487927
      809FE384B81360F25B1E26514190EF00CB4F62ACE44EE42C960C22BE7581D798
      E6CFDAB1C232EB6530EBE6C06E50418EC80F10C0492AC2C49E7D54F8DEC59892
      DE0B5EC5888E3C11B2834E863F7B5F9805B338B023CB4808494708240D05612A
      18B50CE7DE5B4125463E21931B82761494A22059A45D5D35C1C6253AB381424F
      03C1290FC430D5F816058A7F08BC6F187E4E110AA264632C8C0D3061EC810878
      D2188894363C78ECE035DD29AD0EFD2D987DCAF4738B43AB820C240B6071840E
      56A508B2764541DCE880E03801BA0686BDEA7EE026D9E786E0F3214E83F4A4FF
      3C4318A7400106B201FC7D0C703EE202EFF03250B72F461FDF250CCD1D0983D9
      1F4D16F7923772FD22716F17665EB85813BCC13A9EA0C571D3421E4ADCDE452C
      7D6EA359D5DA88C1341F1BC6BC316404994282A9022C015E6B45465DF1E95885
      CD4C04BA8DB171E374D4F6D51AB704E30907793EC91D5A40226BEF21F531250F
      6C1B224184E44D9B4366104F72AFC997B8E939FF06B5353B205D6151BB000000
      0049454E44AE426082}
  end
  object TntSpeedButton2: TPngSpeedButton
    Left = 307
    Top = 138
    Width = 23
    Height = 22
    Hint = 'Generate Password'
    OnClick = TntSpeedButton2Click
    PngImage.Data = {
      89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
      610000000774494D45000000000000000973942E0000001774455874536F6674
      7761726500474C44504E472076657220332E347185A4E10000000874704E4747
      4C4433000000004A80291F0000038F4944415478DA75937F4C137718C69FABB0
      969603A4D8DA229B05A485B94DCC9C2E828BA40B1B5934D9B2649A255317EA36
      C56C664074414D9C328D9D1BC66858FC319D824134CEA845B7302322024522B2
      CA0A25A5058BADD0BBFEA43FEEF63D53FE31F1924FEE9B7BEF79EF79F3DE43E1
      25578EFEEA7C86099628E459A5DE2074DC74DF99A981EA3F49294888CFBE47CD
      1E96ACBB9D3431E15999ADCA782F452A7D57AD522F9749D2E6BA3D61D847EDA8
      D0B4F06B947F5D3DD46AADBE620EDA892442E02955D995326D817C8BAE40F98E
      4A2D5751A2D439636361B09E289EB13C461D1E6C2FDC8B2D35731015E563EC62
      535FBEC1F219113B0861CA70C8EAFAB0225FD9D5C9E25F4B00CE91FFB04E7709
      2BB4711C685F8F61BF064BE93F707E7F1720CBC5E91F9A6F6D3CEA3412712FE1
      19557D629C4DA264F4852627A2906001DF0E93B11569790B71DF548887E2ADC8
      4BB7A134B30D3DFD935CC361E3990BE6600B11938E98A2361DB4B1B119293D34
      E843F19B19D02802D854741259340B87C4006BA81069A9C0AB39C09E9FCCBEE3
      BB96D7F37CFC6F221E2084A84F760CB194289DD62F1661F3073E202317718E87
      2F0C5CBBC743921A85D8370C26C4E372FB347BE9D7B23A9E8BB511B195C051E5
      551696E2C574A5A6011F973830F3DA1E708AC50804801BDD71745CFF0DACCD09
      95A208772DF77C3D1DC776F25CFC3A118F3EDFC2CA0D0FD964899CFE3CAF115F
      EA6DF02B77209259088A2CB8EDB60B0DBBBF41769606058B2AE070F4E2DACD1F
      4F4C317E63C2418C5AF2A999CDCC54D2DFAF9742FF36B1CEA562867B05315275
      79C9DCDB2AC1B83C2829AFC4AAD525686D39E6BD78CEF835CBB88531BC94EEA3
      6E56314F41EFFC4A8955CB24F093D9631C5930E9303105FCBCEF085292FCA8AA
      FD8E8C21C1F8D3204E9FEDED3435D7D78E594C7D94E6FD2E3667819ADE55351F
      6F6893F16824827E0BC3F53F1A0F7776743FF1BA473CFB0E6E5D9AABCD490E87
      00390D44431CCE9F6B6F6DDCABAFA5E8E2DF8F68F25EDF5C5C24E31F5B06DC43
      837D0ED675DF0AFF031B17F1BA894DC6D8E2AC5BB12CBB409A0CA4890109B9DF
      FC67D8BE71ED22839005B9685EF95A51D8AE8AF91EFB85B9843F8CE0214C13FC
      35BF0CD6546D28DA962E055288F84ECF2453B7FBC0ADBB370E37090DC823CC15
      1A25721548400C6346D8F55BA506F51795DF36CAC422DD53F764A4F954FD9D41
      B3C94C6A0F66D3284A804454F917D22D7C249BA0256409AE084222EDFF030B70
      802D4FCBAB810000000049454E44AE426082}
  end
  object Label8: TLabel
    Left = 46
    Top = 169
    Width = 38
    Height = 13
    Alignment = taRightJustify
    Caption = 'Quality:'
  end
  object QualityLabel: TLabel
    Left = 327
    Top = 175
    Width = 3
    Height = 13
    Alignment = taRightJustify
  end
  object TitleEdit: TTntEdit
    Left = 90
    Top = 58
    Width = 240
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object UsernameEdit: TTntEdit
    Left = 90
    Top = 85
    Width = 240
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object PasswordEdit: TTntEdit
    Left = 90
    Top = 112
    Width = 215
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    PasswordChar = '*'
    TabOrder = 2
    OnChange = PasswordEditChange
  end
  object PasswordRepeatEdit: TTntEdit
    Left = 90
    Top = 139
    Width = 215
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    PasswordChar = '*'
    TabOrder = 3
  end
  object NotesMemo: TTntMemo
    Left = 90
    Top = 221
    Width = 240
    Height = 139
    TabOrder = 5
  end
  object Button1: TButton
    Left = 255
    Top = 377
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 174
    Top = 377
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 348
    Height = 41
    Align = alTop
    BevelEdges = [beLeft, beTop, beBottom]
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 8
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
        B18F0BFC6105000008794944415478DABD57095454D719FEDE1B0606664056D9
        828262C4624204E29AA03655A354E352B7B44D8DD1546B229A16CDA946B3B846
        6353B527A235D83421A656A335C6256A405110ADCA268C6CC3322C0303B333CE
        F25EFF3B43D24445488EED3DE7328FBBFDDFFDFEEFFFEFBD1C1E6289954AB8AC
        94213B2F37EBCB5694D6675253674F73B88709606DB062D8F2CCA5793517CA1A
        C66DFBE239B25E4ECDCEFF0B8025018A80C51362F6277E36678655D58E3F8CF9
        70F7BE46FD261BD0F43F0330CB5F1EF2136FAF9190E19159C3FDC7F55F3128D5
        7F64A45CA4BEB2BDC59A13FB5427B5CD8E8B0E9BA8BA6CB1E6E799ACE6870620
        71E0AC90B76355FB7FBABD70AA57B41F784528202AA8C78B2A41E098FBF5B06B
        35D0673B91BE44B2E6409B710F35B6FF6800314F2C94DAF8C1C3E5C149A305AF
        C87111D6BA27B7FF2C2D24E9E572F07D98719F2E00AC586875334C250E216B95
        F7EDD5A74DEFEA04F114EE7249AF01FC714FC7F3556AE7067DAB21262C90C7F0
        C77D20F01E70A89BF194E565242DCB053C68A0A46B0249CFD9CA61D3CF7DAFBD
        5B6ACC32413C46AD75541D3F18405ADAF28461A99B4F373473A1939FE41014E4
        814E51028D5E444E8115FDAEEDC26F5E781DE84383F9AE49E405DD15199EFAB5
        B0BDD461FB8C5A6EDE6DBC570096ACDE9ABCE5AD5507AED608F1379502A2A324
        9079719090212FDA714707AD79701D664DDCEC62DF41B2E7A98FF7044C15523C
        B742BAE9BCD9B21BDD44C303014C99B7CC7BDBFBBB4F0C0E11534E153B2537CA
        053C36580A5F05E7669BE8EED018E0F7C98B783AE1089AAA7C51E19849E94783
        E4FEA7E0E30B2C5C2FCF3CD0627A8786D7FC20004929A9013B333FDF312C4ABA
        C08376F48F8B6654D4F3189528839F9C034F33A584A2B6520B9FACD5802200DA
        A445F0888A45768111FAE33BD4933BDFD39F50E1F2418DE53DB89352EF01EC3D
        92B771CEB32357E83AE11324073E3AA983BA5D8A09A37DE0E74B0C102819D17C
        A3D88CEA0A031481FE1899244374A08853B9266CDF73ACA4F9CC928C4E7BE72D
        A32096D2922DBD02101414E2B175DFB145BF983CEA031F4F117AB3089DC1810D
        7F6D4578B81F268C91BB04A6D60868EB1061B2085078F38889E4113F80475F3F
        0E45B72DD892915B9993B570B559AFFE8296B5BB65D90B0027CF5C983862D4E8
        BD463BDFBFAED58142A515952A1BB4943E8282E5F095F3F0A69D87F7E5101E28
        416408B14F2E91493997096F29C55AD31DACFFA0B0F1C2272FBDA16D2AF99896
        B575C7F4B7003E3F9EEDF9BB37950366CC9D961D171F10CA91C274ED0E188D80
        AF8F840CF2880802FA85F3F43F0729EF9ECCD1AFD329C260124813C4803F47DF
        0EACCDA8357C95B960ABBA3277270D33F508E0E27573BF0DFB1A5F8B1D189C96
        92AC808C76EA4361E54942F3279FCB65243A09F99E94CF42D0E110D16110A1AC
        13D0D0C25C212269088FB1091E0448C0BA0F5B6D5F65A5EF2BB9F4F775B82BFD
        DE17C0B9FCD6F0357FBAB572F0A331E95BD2C2A017A49030A57765369B8DED52
        84BA5540539B00ADDEDD1713C961608404FDC3DC6E1004404EC0771C3622E7EC
        91ECE3190B5EA4E9B53D6AE07C7E739F55DBFE3D3776D0D08CCDAF84C14912E7
        684AB5DA81FA66118D6494A7D88B08E2C8EF1CA24379F4A17C209371AEECCB92
        8FC4E50E376B872E58F0F515657DC6EAC4E9D45D84FB64C1EF01F8F2CC3549FA
        96ECF84189736EAE5F1CCC85857BC3D429E25C81035124B8C1FD25082057B0C5
        4502C677CDBC43CCE8891955B3803A72C584640F122745428D1D47AF5885CCB7
        A7FCB6B63CF760773AF85E14440DFDA52261C23BAA95F3FB060D1B2A8795B4EB
        41063D38F70E59EC73F46D25A3B5C44A55831335F4CB680F63020DE1911C2781
        37A5EA7683130773EFE0C4A7DBFE7626EBCDB5B47C43AFC230354D99336D6C48
        CA8269013074328302AC773834B7931B5A9D2EC3266AF7A7D08B8EE0F018C57E
        701FC68C3B0C193B2E67D347CE2D3B4E5DAAACFD78EBDC154DAA927F51ABD033
        8057AFFFF989F84796BFB53804164A1F652A27CE5E73424151104EFE1F448751
        A83F10E0C74291EB8A45B74BD8A74627529E105DC9A99D42F3408ED99E737457
        E6F1FD6BD2A9DBD023801153B7CD8A4B9E9FF9FECA305F4F2F09EED8058802E7
        121C1B2C746999B982F9BF9D8EE4169D80F27AFAD58A2E069E1D21417CB43B7C
        0AAA1CC8BF6D31EF4C9FF47C5569FE69269B0702888C1D17FFF4FCCC7FA6FF2A
        2C6EE800998B33B63BC63033DA6967AE105152ED449D462480C4065D861E8DE2
        89211EA1812C67881411EE8B8185409E2F13905770E572E995D33B8EED7FFB28
        BE7353BE07806F403FCFB1F3F7FC65DAE4D18B5E98E447463997E8728B9C50B7
        89D01A044A501CE2FAF188A5FC1F1D4A27A3E4DE338D3161A3644587196E3608
        68D4090EB3BEB5EED52991A9870E1DAA9C3D7BB6E3BE005819337DE3CC715397
        1E5E3ACD1761811E6454C4C5420719932082723F0B47967444EEDE056C9496B5
        46110D745069CD1C74246007B9505576B5F6EB63FBB3CF1FC9D845008A0880BD
        5B00FE21B15EF35E3F5B303E29F8F13963E52EBF3342BF9BCA983B04EA305959
        05DB219A09688B51144D668BD5A055EB340D4A4D6561AE927CAFAC28CA2BA169
        95542BA81ABB75C13765C6B24F7F3F2469D2C6D766FA7905FA49FE3B98FE30A3
        B51492CD2440562D761E964EF39DD6A66A4DF9D5D3CAAAE24BAA96864AA55653
        A7B2755A581A666781962A7B17D81F28C26F4A48E490A819AF7C94999810F7CC
        F804194502DD013A04A8E82CE8303B9DFAF6568351A7D6D729F36B1AAB0BAB8A
        F3BEBC61A66DD35456DBA876C0FD36ECF6287E200026FE94E9AB529F99F7C661
        1F2F5E4A234503DDC9EB6E17D4541767ABEA6E5F2BD7B7A955BA3635A3B5B5AB
        326AAD5D2A17D18BD2D3AD981F3EF1A5D90ABFE0F11545E79A1B2AAF578B8250
        DF654C03D7EBC355859E0CFD5800ACB0E74E30DC4F0E96C9D8A1E2400FAFDEDE
        96FF00024FAD4E83D0DF540000000049454E44AE426082}
    end
    object FormHeaderLabel: TLabel
      Left = 45
      Top = 11
      Width = 105
      Height = 18
      Caption = 'Add New Item'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object URLEdit: TTntEdit
    Left = 90
    Top = 194
    Width = 240
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object BalloonHint: TJvBalloonHint
    Left = 8
    Top = 48
  end
end
