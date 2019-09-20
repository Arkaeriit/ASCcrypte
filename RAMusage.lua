--Ce fichier sert à définir la taille de la RAM nécessaire aux opérations de cryptage et de compression. La taille par défaut est 16 Mio et peut être réduite ou augmentée si besoin ou envie. Cependant l'utilisation d'un mot de passe trop long lors du cryptage peux entraîner un utilisation de RAM avoisinant 500 Mo quel que soit les informations indiquées ici.

--This file is used to set the RAM size needed for compressing and encryption. The default size is 16 MiB and can be increased or decreased in this file. Be careful: if you use a password too long while encrypting you will need around 500 MB even if you asked for less in this file.

local GiB = 1073741824
local MiB = 1048576
local KiB = 1024

RAM_USAGE_BASE = 16 * MiB -- <- modify this line

