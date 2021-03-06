﻿# ASCcrypte
A program made to encrypt files or directories

Disclaimer: I am in no way an expert on cryptography so don't expect to find any incredible algorithm here.

Nonetheless, you can still use this program to encrypt your files with a password and you will need the password to decrypt them.

For example this file:
![Alt text](https://i.imgur.com/7afNExc.png "A file from this software")
Can become this once it is encrypted with the password "Lua and C are very cool":
![Alt text](https://i.imgur.com/x67DJSJ.png "Lua and C are indeed very cool!")

## User manual

Usage: `ASCcrypte <option> <input file/directory> [password] [output file/directory]`

Available options:
* encryption: Encrypt or decrypt the input file or directory. If the input is a directory it will be compressed first. You need to give a password for this to function.
* compress: Compress the input directory in a single file.
* decompress: Decompress a directory from a file. You need to give an output directory for  this function.
* encryptionSTDIN: same as encryption but the source is stdin instead of an input file.
* decompressSTDIN: same as decompress but the source is stdin instead of an input file.

If you don't give an output file the result will be written on stdout.

Example: if you want to encrypt the file test.txt into the file out.crypted with IloveCandLua as a password you have to do:
```bash
ASCcrypte encryption test.txt IloveCandLua out.crypted
```

## Installation
To install ASCcrypte you need the library ASCgestionFS, available here: https://github.com/Arkaeriit/ASCgestionFS.

When the library is installed, this just use: 
```bash
make && sudo make install
```

### RAM usage

By default this program don't use a lot of RAM. If you want to use more RAM for a slight speed improvement or to use even less RAM you can change RAM\_USAGE\_BASE in the file the file RAMusage.lua before compilation.

