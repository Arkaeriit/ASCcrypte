--Ce fichier sert à définir la taille de la RAM nécéssaire aux opérations de cryptage et de compression. La taille par défaut est 500 Mio et peut être résuie ou augmentée si besoin ou envie. Cependant l'utilisation d'un mot de passe trop long lors du cryptage peux entrainer un utilisation de ram avoisinant 500 Mo quel que soit les informations indiquées ici.

--This file is used to set the RAM size needed for compressing and encryption. The default size is 500 MiB and can be increased or decreased in this file. Be carefull: if you use a password too long while ecrypting you will need around 500 MB even if you asked for less in this file.

local GiB = 1073741824
local MiB = 1048576
local KiB = 1024

RAM_USAGE_BASE = 500 * MiB

