object AboutForm: TAboutForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 318
  ClientWidth = 284
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClick = FormClick
  OnCreate = FormCreate
  DesignSize = (
    284
    318)
  PixelsPerInch = 96
  TextHeight = 13
  object AppNameLabel: TLabel
    Left = 88
    Top = 8
    Width = 59
    Height = 16
    Caption = 'Patronus'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object VersionLabel: TLabel
    Left = 88
    Top = 25
    Width = 65
    Height = 16
    Caption = 'Version 1.0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object WebsiteLink: TLabel
    Left = 88
    Top = 59
    Width = 139
    Height = 13
    Cursor = crHandPoint
    Caption = 'elsdoerfer.info/patronus'
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
  object Image1: TImage
    Left = 12
    Top = 8
    Width = 64
    Height = 64
    AutoSize = True
    Picture.Data = {
      0A54504E474F626A65637489504E470D0A1A0A0000000D494844520000004000
      0000400806000000AA6971DE0000000774494D45000000000000000973942E00
      00001774455874536F66747761726500474C44504E472076657220332E347185
      A4E10000000874704E47474C4433000000004A80291F0000000467414D410000
      B18F0BFC6105000016CC4944415478DAE55B09781CE5797EE7D01EBA56F769D9
      20D99665235B3E30C6D8C61CC68124B4010C24A4B44993923694D034290F2471
      5368D23449439327E1489D3CD03C09E060CC51303EB02D30583E2563C992255B
      B757D74ADA5D69EF9D9D7EDF3FB3D2DA08B06CF1C869C7FEB5B3B3B333F3BEFF
      FB5DFFFFAF84FFE79BF449DFA0224F7614A427DD9A9766591F8E61811643AEA6
      4B76FA684491F55E494743872BB0DBE9896EEBF763E8FF0C0155336CD9553352
      367A22D2572D6A92BD38CB82428715E93615165546201A83C71F458F3B442D8C
      50241A92746DEBB1AE911FB60F46EAE912FA9F2C01B72C48DF60B35936A5DAAD
      E95797A66146B60D8A2223A64B90655934499209628C8E69D0A21ACE0C0771A8
      7504FDDE90E6F5859E3AD036B23110D1873F6922A69C80F50B1C0F5B2DD61F2E
      2F4DC7A29214687C0BFA2F43211214C80AEDCB2A14DA8911015A348A881681AE
      E950C81E3A0683D8D3E4A1E391A6DD8D43777B02315683F62741C0FAF98E6F59
      6DD69FACAFCC4471A6159A264122C0041DC67FEA7D5525022471639DFEC63443
      01820C2D2AAE138BC5F0C671378647820344C21D44C27E3A1CB9A40920D9AF56
      2CD6EA1B2A32A5992479727490643D01BC426448088542B0D9ECC20C18A80138
      4A4D17EF355282444A9089906D0D6EB8DCC1DE1D0D837FE60BEBB59F04095342
      405EAA6259332FABB1343FA57405493F42206489ED9CE52F91F48D1E97C80442
      A12075BD2E48603FA0D3BE466009BDA1063E8F8EF1719988D87A7408831E7FCD
      9B0DEE7BE8A376E6EB9223E0A6F98E7F4C4BB1FFF4CE65397445991108704CC0
      B92D4A20118D204AAECD6AB1D0E90A81D59813EA7DC6A60B7390621274BA8E3F
      ACE1B53A179A9D9E1F3738433FA1135C971401F9698ABCAA3CAB7D6189A3646E
      21857792B2CE9E9E1E5E2712880E216F49284111AF6C06F3F364340D10503A57
      5154D1E30611BA8816122B82BF43DF3FE11CC5C96EF7E08B4787EF2071D5D0A1
      E025434065B16D5D59A163C76D4B72C8B3CBA2D71876FC957B3C3F954053977B
      C3D4CB314928A4384D468943221234B8098E4A4A109191A5A01B8E90C9D2E87D
      798E8CDF543BF1EEE9914D0D3DA147E9B65D970C017F7155CE53F664FB7D6BE7
      65105898DE9DC053DC17019C805C59A20A2530182F811DF469881211E5798A38
      DF45EFDB877450A648CE1166E49784728A89A4B26C053B4FB8F166BDFBCCD63A
      E10B5805A14B8280DB97E59E5838D35171598ECD7872FECF26C03DC9364F042C
      2B924522347653F3AE0C9037990EF09ECBAFC1176295907F5081EC6419F624E3
      334F208A27773B2932781F728D6ACFD0A1FE692760D10C7BC6CCDC54D74D95D9
      4A2A3F313FA96C2A000660766C8B8B152429E77F2B4345676FFCF5A7F63AB1BB
      69644BBD33F8CF74E804A6204BBC28021616DBAACA0A1CB5372FCA16F63FB6E9
      06051CB1B8E31717AA93BA937ECE83B19854F286DB8E0D6267A3BB7E67E3E837
      E8F0BB980233B84802EC37CF2972BCF1A9CA6CF2DC71C810490E6F1AC9BF204D
      C2CC0CC58C0417F3A012EACFF8F072ADCBF552ADE77E3AF42635CFF4125064BB
      63DECCAC3FDEBB228B921FA077C4F0DCC293D3966A057970EA3A7DF2B7896B7B
      EC9BB4E31C0EE1F9037D81CD47DCDF24A25FC214F8818B35817BD755A43F7BCF
      CA0204233A8EF5682286F3C68A989BAB20CD2A7D004CA28DEBE69FB83AE2F2A7
      8A192AED44CDBC8F5208B87D11FCF6ED5EEDA563EEEF06C2FA1FE870E7B41250
      966BBF2D272B73CBDA790E7CEE0A1547BBA3C2F6F96139E15B904F890C153EF4
      5F38317740C7A05FC7482806BB454626058E9C1459F8898151CAFA2231CCCA54
      2824C650DD1645B32B46E71A3EC09E0414A64B088F0CEBDBEB5DFF42B5C1EFE9
      114E4D2B01375C7FE3E60595951BB66E7D057F77B5150D7D31F48EC6842F70D8
      252C2E52313B5B4207017AB9314A26A2538FC6FB98CB5F0959C912E6D2392A31
      E42042EAE91A6D941324C9664E90B0890C91BEDADED1F6837024FA3B3A7472DA
      08484B49917EFAF87FF6A4A53BF27FF58B5FC012E8C3436B2D383DA40BD906A9
      372DE4FC4FF6EBD8D6ACC1C68160022FC8D5DFF21219F7AFB40807FA744D18FB
      3B634239136DE45FF4D6F6F67F8B4405014DD346406A72B2FA8B5F3DD19F64B1
      65BEF0DCEFD175EA04FEE3D37651E4F016EFBCD1B08E6FBF11FAD03C204C5FD8
      50A9E0863949E2615E6F8AE0B5466DC2F3593CC9723870ACB9E35F69F7453AD4
      3C6D04F076FFDF3F505736BB7CD1AEED6FA0A7BD093FFA948DD261FDACAB7296
      F7F09B21B2EF736FA71B191FD9F60F6FB21260C33446433A36EEE231C2848C91
      3E623F91658FA1286978F095BAE1C7E8F0564CB7132C9F33E7BBEB3F7DEB637B
      76ED44554E109FAF4A42584BB8AA6ED8F1E9C118FE782C0A77C800CDE6904ED1
      A12C47C28D652AD26D9251E49BE78728A2B01FF0458C4BB16F600778CAE9C59E
      93EEE6B79A46B92C7E15D31D06CB67CFDE1209876E53540B1EA35EB4A81FBC9C
      6E82A2941EE4168CF79291D971CFB2BF48CCFCF48490183723268715B0E3FD01
      54377B77532AFC6B3AB48D9A77DA08A8AC5C98535555D5E6F57A53874F1DC45F
      5E998CF4640B264CCF751364C2DDCC5C69FC983E71626F7C2E2148A5E6AEE303
      78FDB8671315432FD0C177309DA9F0DAB5D77D6DFDCDB73C79B2F9947FE0D0E6
      A10585B6194BCB3285C43FEEA2893D3EF66A0C1EC31C4513FBAC8E78D4ECE8F7
      E370AB7BF8C55AF7E330E47F1C53303C76C104DC75E7DD4F5D7DCD35F7BDFAEA
      AB6DCD8777F160E85FADAEC8A532561EEFDE0F01CF63849EA08E3324605F3846
      BDCB61937BD9DC0F53235F322383728D521549E433F635BA70B0DDB7FF68A7FF
      19BAC4FF50735E2CF88B2260C386BBFE9D08F8A7BDBB77BB5E7DF5E587EF5CE2
      7860566E4AE515250E4305135C395ED5ED3A15C5BE0E43F322DC4BE73C8864D8
      3F2BA0381DB8AD2286C3A787225B6A3D4F0722FAEBF45135B5C0B41230776EF9
      BACFDD76FB0E2E7CFEB879F32F7577C7C135E5E9CF565D9629A571DE3AB145A3
      C545E7D76BA41449C89B6B0631286C9EC18470E3686A21A5B0E35C9EE341FB80
      AF767FAB8FD35FEEFD664CD18CD1051360B158E45B3FFBE787D65E7FDD920307
      0E84B66FDF7E7F6586F7A6D25CFB86C5A5D91FC8FAF86939BD7DF66814033E49
      A8213359C7BC5C5984C4942423DFE710692195F48E52A06FA0E28A1E714EDAA8
      B6A7BEF7A96054DF4197D9436D642AC05F1401BC6564642EFAF4673EFBF6EAD5
      ABD36B6A6A82FBAAABBD4BB3DD7979690ACA8B33A867CFEE2489BAF6A9031AF5
      AA84D4241D5F59AE0873193B2BE1F42422E1891A8D7C01D50912F98688D6EFEC
      E9F97A30147A0D53341E78D104D0A66465655FBF6EDD4DBFEBEE6CCF1F1A1E86
      A44550953184EC540BCA8A32CEF68774B74D878C01D174AB8E7B971883A28629
      404C9004C2927080EFF7C4D0382089E175555561B3DB31E2F5FA7AFBFABEEC1D
      1D7D65AA48B8E841D1AC8C8C45991919CF26592C8B8A4B4AE01A1880DD6AC142
      87077278189717668A74385EF43F732426086062522CBAC8F2FCECF5C9FB8734
      6340D4487D2591FCE8E62C52F1AC9918E8ED85C7EDF6F7F6F77FCD3B32B2792A
      48B86002EC369B9C9B9DFD687272F243B1584CCD2F2A82D56A134EADBDE524EE
      7EF0C718D9FF24DCAD875152984B49925528FC77B5BA7070CCC944D1F2DCE8C1
      04A4A6A5A1A0A8587CBFCF7906A3232318191D7DD2D9DBFB308C6CF0821DE205
      1190939535333B2BEB155951AA8C1EB221373FDF4C621478C814467D013CB6F9
      004EBDF104DEDFF203A8B10872B31DD8D3698337247DE8F8607C384D4C9446A3
      48494B474A4A8AB8BE317324A1FD548B9870094722EF757577DF4BFBEDB8C029
      F4491330ABB8F83AB2C7AD569BCD91919D8DDEEE6E141617C34A328558F8A08B
      B9FFD3271B71DD67BE80AF7DF731F887BD38BEED37A8DFF5DFE8EE68C3D1013B
      548BCD1C3C35264523E1A8983CB5242521232B074525B3F0D56F7C1B3F7BF43B
      641611381C197CA6882EAEBE7EF60742428140A0B1BDAB6B83A6693C3812FD44
      0920F05F24E0CFA4A6A72BE919ECE563707675E1B2D23228E4A8C40428FFA3F8
      1D0C8470AAA901BF7969274A67CF173DAE5098F30FF6A3A7FB34766C7F0B7DDD
      ADF04933513C6336D65F5B82DCC222E4E41623392519C403825443AF595A81CB
      67CF117E809F76787050DC33AFB010E90E07BADADAE00F04EADB3A3B6FE3B192
      C92AE1BC0920F05F22F0BFCDC8CA42726AAAF82AA7B4CEAE6ED8C94367921AAC
      362BF5AA32B60CA6BBA3038E8C4C6CD9B64BA4B7B269FBDCF1742A5EAF01DEDA
      558390AF0F25F3D6E3E695362C2AD349DEC66375B536E2E6753762D98A154468
      005DEDED884422607F939EEE2001F07A020D9D4482C7EB7DFD4C4FCF7D3052E4
      F3F609E7450081BF95C0BF4CE0A564B24746C0B3B6E40310253B6549068301A1
      000E591411904224E5E4E6E1785D2DBEFDC877F0E5AFFC0D425123CB8B50BDFF
      C4560D4D35BF46A47FB7613AB2156EE96A2CBFF14BB877BD15A545329E7BEE05
      7CFF7B8F60E9F215683C7E1C7EBF4F981B936A4C9C6A22856472BA3B3BD0D7DF
      BFD1EDF5FE921E6D78CA082087379F1CDE21925B720A7963DEC43C9F2CD67E08
      BBE55921F6FEBCD4254A3D140E8730D0D787BCFC023061A79B4FA27A7F0D72F3
      0AE0F5E978F215093B9FB91B317F1B2E2B2B17D76470876BDEC1F6BD87F1E6B1
      42CC2A4CC2EEE7BE8E83070EA274CE1C71DDBEDE1E61027C7D2637B7A0402880
      410CF4F763D0E5729F6E6FFF1C99E6794FA17F240136ABD53EABA4A4819CDEE5
      2C715ED3231639411543DFAC039EDF174B602445647AEC00CF908D7A3C6ECC9B
      BF00F6E4649C3CD1808A8A0AFCD7B3CFE3D16742F8D65D56F474D6E29EBBBE00
      958C3D39251543832E14925DEFAEAE16F7DE5B07DC7767154ACB0A919199654E
      B7199BD7E3414BE309CC9E370F16AB55649CBCA8A2ADA505032ED71F0606071F
      A1D33A2E9A808AB9737F4952FB3A336DF4FCB87D1B66208FADFF11D3E19C03B4
      9E16BD35B7623EF9049B21553293A307DFC3AA3B7E8E9F6EBC1DB90EE3FA9FBD
      E516387B7AC9E125194A6969C65B7BF762F6ECD9682207BAFE869BB072CDB5C2
      D4C6568DD0BFC1C10174B4B6A2A272A1B88E4E2A6072581DBD3DCEA1536D6D9F
      873160F2B115E3871240D25F929599792487E22F153E09044842FE2A8C712DB1
      F24BAC05D029F49DA473AD985D5E6EAC06A1CF7895984C7FFA49BEBDCE4EECAB
      39281CD800658CCB972EC59265CB854A783B567B045FBCE78B78E89187F1F8CF
      7E86DF6EDA84A557AD107E4600653323B075870F912F9881ECDC5CB1C04AACAC
      A188C4B9412B995B97D3F9239FCFC7BEE0CC0513306FCE9C6AEAC13586F44DF0
      60ECAA316121AB62FA4AF80249A6B8EC411779FDAA65CB04603607A3CE57C4AC
      10F762ED9143B8E69A6BF0E4D34FE395975FC6371F7C102BAE593DB61A64A0BF
      0FFE110FDE25BB5FB36A15ECA48AC2A21922018AF1C22BBA7163C371844341CC
      5B5029D61E700E61A820263AA1A3AD958876EEED75B9BE4587C9903E3A2C4E48
      404E66E655E4F86A38D6727C1772978D058E892488F7BC264A367280E6867AD8
      925348FE15E23AB2A900FEA388B54141ECABDE8B3F3CFF3CB6BCF822F693639C
      3DB77C8C00EEE903EFEDC3E33FFF39FEE1810770ED8DEB8CFB1338891E807D4B
      2B6581554B9789E3BAB9AA0CE2D518546012CF747777B57776FE2D8CD2D93F69
      02C8F67F4FA1EC0B593939D025691CBC69FFB2297BB1CF0B7B14D9880404A4A9
      FEB89034F79022C29B911E0B2D906438668F9083E473B373F3914979455CDEAC
      B213EFD7814A5E4A7232B070C9522225221ED2EBF1A2F6F041949363CD24A728
      1656F23A434D4037D71A422891FCC328F9019E42E7C193C14911909E9A6A2DC8
      CF1F20FB4A6327266C5F002702D473086074AAF15E31091124901218D0C2AAC5
      C2110A1392E3242838F0EE3B08F8FDD493578ABC2171EB39D38D2E8AE9CBC8F6
      990496752814C6817D6FA368C60CCCBABC54AC2835C08B44DAA81B62C65A433F
      5DB7B5E5A4D67CBA951751F0E489735204A4A5A4DC505C54B48BB32D015E91C7
      7B5F320930C18F112206F6E4B128C1723E450E71686810575CB1103905F9A2C7
      44A8A4CFFC3E1F6A0810AB242D3D7D4C01FC5D06EF2585AC5CB3D6583849ADE6
      DDB7A9204AC382850B4DF01066310E5E133534EF07027E4AC19B62CDADADEC03
      B6E063668F3E4040E9AC598F5248FA5E4E5E9E78D838405996CF368331022471
      3C313B94CDB57F3DCE6E4A829A515C3253E404C6DD288B2015B434350AB0558B
      97190E5398B286A3870E081BCF2B2814B5460DA9850B4456449464CEC91F3163
      82D74DF0E3CB6D39A16A696C8CB6B4B53D6412D03129022E9F39F335AAF23EE3
      7018C1DA58DC4C0F2D8F831D27401A7384F1DC80FFA98A216BC59204FFE828EA
      8FD50A321711D88CCC4C91C373CDF0F69EB744CA5C5A36479809E71001DF2856
      5D7FA37070FB49259CF571A4E0473556926A30D4CE3D1F35C1C7C608E004EC74
      4BCBE8E9B6B68D302650BB264BC011AABD9770626200354072C617EF71D5EC71
      553A471DAAB9364C3845D518E13515D1D2D4244254295576C241D2391ECAE8DE
      7E6B27497B11254316D41D3D8455D75E4F8E319BA2C56E8483415C4DA6C0DF8F
      E7FD71677736F89820870BAD8ED65338E374B6777677FFC4F4013D9325A035BF
      B0F0721B7972C994BB1AEF79D30748AA2400C63F8F93223E1776A09A8E130651
      6C12AA450C94D41D3D2CEC9D13202E6C8ED7D5A1B3BD8D526255005F4CF2DFBB
      6B873867E51878DD584C7D4ED3441E40F15F8F0A285C7F74B6B5C63A9DCE1702
      8100CF1EF1422AF76409682B282ABA8C072145EFF2A2E7B1089000943F53C77D
      82248FFF1A4449F415A669A83C5660164ECD64FFDC0AC9D12EBEF22ABC57BD87
      929B10AE5A752DEDEF461A79FF15AB568BFCFF43C16B9AB9BE3826F2070EAF94
      6DEA0343437B87DDEE9D04653BB5F7F131832413117022AFA0A0826B7E91C8A8
      7105B039A863C025D33C846F50CF067C96AF48204136EB07D5A28A30584B296D
      7F5F2F11512C4A6856421999C8A225CB28AD8D1A00D9E125C85C2CA68E191390
      110A8F3DCE33A2140E85429E9EFEFE9D1406F97705FC038B23388FD9E38908A8
      A61C600D8FB6E01CF94BEA38116A8202E2BDAF4A8652440EA89A6A398B189308
      73E578929A244ADCDA430785F7BE8A9C1DC77A2DC25E5E130BADC4EF8A4C02F8
      69A39130DC644ACEEE6EB828EB0B45225EB7DB5D37E4F11C20764ED3379880A6
      F3013F210154FE6EA208F0D75C041969AF01585213E4AF8EF7308317C0E5B38F
      1BA6631296A010E52C8518592247081EE9E1AA90431FE70CF1C1511E63F08D8E
      C035D08F3E528B311E108E0483C14EB7D7FBFEA8CFD700A3E8E115633C65D687
      490C977F808064BB7D554971F13B9C06F370B4F8E18362DA303BB784D83F063E
      21211264C9E728C0FC2E7FCE99A071EEF8AB6A7E3F42B61CF0F9452234E87209
      D06EF730428100229A364CA0CFF8FCFE5354E935C774BDCF04CE894E378C1F52
      4C7AC274A25A402ACCCFFF7E7A5ADA46CEE9790C901DA22AC29962F6AA32DE9B
      096304E2B812EF65652C33E4A4280E1C42D5BA88EFEC074646BC3CD901D231F5
      F4A82898C8FE03512DC6807B02C16017D5065DA4100E67FCC3CA016ABD664F73
      9E3F8A0B180DFE2802784B2325DC9E9B9DFDA0D56AADA4CA4BB6DBACA2D2E37A
      9F476158AE0C50A157768462A1B8642CF667671523E7C5DE39120E8B5F888428
      A633B870308430D931D5EE14D2A37EF2F25E02371C0A870748DAFDE148A48F5F
      61D830AF051E368132780E693C311ABC18D0E743006F3CF45B46C5CA52226365
      B2CD3697C8282239A7905D24494689476F256E528C1143E4F4A44EFE1520384E
      69F426A4115092B78780BA09B8978819A2FD21A28041FACC366A821E4978E552
      96651D9A2AC09321803706C9D54A0EB55C6AD9E67B2B35CE7765B325ACF4196B
      31B3313111B3D70209A00226F038406E6113680C97E04F6719B0C56C4909C013
      9B3E418B93104D68B184CFA675FBC47F3D7EA96FFF0BEC4BDBD7628077F10000
      000049454E44AE426082}
  end
  object ScrollingCredits: TScrollingCredits
    Left = 12
    Top = 88
    Width = 260
    Height = 193
    Credits.Strings = (
      '&b&uPatronus Password Store'
      '2006 by Michael Elsd'#246'rfer <elsdoerfer.info>'
      ''
      ''
      ''
      '&bFor inspiration'
      ''
      'KeePass Password Safe'
      ''
      ''
      ''
      '&bBuilt in Delphi'
      ''
      ''
      ''
      '&bComponents && Libraries'
      ''
      'Toolbar 2000, TBX && SpTBX'
      'VirtualTreeView'
      'Indy'
      'DCPCiphers'
      'Tntware Unicode Controls'
      'PngDelphi'
      'ScrollingCredits'
      'JVCL && JCL'
      'Open XML'
      ''
      ''
      '&bApplication & Toolbar Icons'
      ''
      'iconaholic.com'
      ''
      ''
      ''
      ''
      ''
      ''
      '"&iI saved Latin. What did you ever do?"')
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
  end
  object OKButton: TButton
    Left = 197
    Top = 287
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
end
