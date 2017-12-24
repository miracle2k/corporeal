Purpose
-------

Decrypt a .corporeal file (remove the AES encryption). Maybe other helpers.


How to compile
--------------

Using Free Pascal:

	$ export DCPCRYPT=/Users/michael/Downloads/dcpcrypt2_2
	$ fpc main.pas -Fu../src/ -Fu$DCPCRYPT/Ciphers -Fu/$DCPCRYPT -Fu$DCPCRYPT/Hashes -MDelphi 
	$ ./main /Users/michael/Dropbox/Personal/passwords.patronus PASSWORD
	$ cat output.patronus

Note that the regular DCPCrypt didn't work for me (EDCP_cipher: Unable to allocate sufficient memory for hash digest during InitKey's hashing code). What did work was:

- https://bitbucket.org/wpostma/dcpcrypt2010/downloads/
- Commit: 21a28047abb896f3fa5e18a6b08e26d13266f978
- Remove all the {IFDEF} calls that raise errors.