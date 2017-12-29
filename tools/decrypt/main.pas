program Hello;

uses PWStoreModel, SysUtils, DCPrijndael, DCPsha512, Classes;

var 
  PWItemStore: TPWItemStore;
  MemoryStream: TMemoryStream;
  AESCipher: TDCP_rijndael;
  FStoreFileStream: TFileStream;


begin
	PWItemStore := TPWItemStore.Create;
	PWItemStore.LoadFromFile(ParamStr(1), ParamStr(2));
	writeln('Items in Store: ', PWItemStore.Count);
	PWItemStore.Close;
	writeln('Now decrypting...');


	FStoreFileStream := TFileStream.Create(ParamStr(1), fmOpenReadWrite or fmShareExclusive);
    MemoryStream := TMemoryStream.Create;
    AESCipher := TDCP_rijndael.Create(nil);

    try
		AESCipher.InitStr(AnsiString(ParamStr(2)), TDCP_sha512);
		AESCipher.DecryptStream(FStoreFileStream, MemoryStream, FStoreFileStream.Size);
		MemoryStream.Position := 0;
		MemoryStream.SaveToFile('output.corporeal')
	finally
		MemoryStream.Free;
      	AESCipher.Free;
    end;	

    writeln('written to: output.corporeal');
end.

