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

To install this just use 
```bash
make && sudo make install
```

### RAM usage

By default, even if it often doesn't need a lot of RAM, this program will use up to 2 GiB of RAM while compressing or encrypting big files. You can change this by modifying RAM\_USAGE\_BASE in the file the file RAMusage.lua before compilation. By reducing the default value you will make the program less RAM-needy but a tad slower when compressing or encrypting big files. You can also, if you have a lot of RAM, increasing the value.

