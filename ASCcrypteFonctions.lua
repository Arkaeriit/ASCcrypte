function readFile(fichier)  --lit l'intégralitée de fichier et nous renvoie son contenu dans une chaine de charactère
  local f = io.open(fichier,"r")
  local s = f:read("a")
  f:close()
  return s
end

function writeFile(s,fichier) --écrit la chaine de caractères s dans fichier
  local f = io.open(fichier,"w")
  f:write(s)
  f:close()
end

function encrypt(fichierIN,password,fichierOUT) --Permet d'encripter fichierIn avec le mdp password vers fichierOUT ou stdout
    --TODO : vérifier si fichier est un dossier
    local stringIn = readFile(fichierIN)
    local passwordLong = passwordGenerator(password,#password,#stringIn)
    local stringOut = C_cryptage(stringIn,passwordLong,#stringIn,#passwordLong)
    if fichierOUT then
        writeFile(stringOut,fichierOUT)
    else
        io.stdout:write(stringOut)
    end
end
