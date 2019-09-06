--Ces fonctions servent à l'itéraction avec le système de fichier. Elles ont été faite pour archer sous Linux.

--------------------------------------------Écriture/lecture-------------------------------------------------------------

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

function createDir(dir)
  local dossierSafe = antiSlashing(dir)
  os.execute("mkdir "..dossierSafe)
end

--------------------------------------------Analyse des fichires-------------------------------------------------------------

function ls(dossier)
  local dossierSafe = antiSlashing(dossier)
  local f = io.popen("ls -a "..dossierSafe,"r")
  local tab = {}
  local a = f:read("l")
  while a do
    if a~="." and a~=".." then  
      tab[#tab+1] = a
    end
    a = f:read("l")
  end
  f:close()
  return tab
end

function isDir(fichier)
  local fichierSafe = antiSlashing(fichier)
  local f = io.popen("ls -l "..fichierSafe,"r")
  local lig = f:read("l")
  f:close()
  local a = (lig):sub(1,1)
  if a=="l" then
    error("lien")
  else
    return a~="-"
  end
end

function exist(fichier)
    local f = io.open(fichier,"r")
    if f then
        f:close()
        return true
    else
        return false
    end
end

-------------------Gestion des charactères spéciaux lors avec la commande os.execute ou io.popen----------------

function antiSlashing(string) --renvoie une chaine qui est comme string mais avec un anti-slash avant chaque charctère qui causerait un problème
    local ret = ""
    for i=1,#string do
        local char = string:sub(i,i)
        if char == " " or char == '"' or char == "'" or char == "`" or char == "\\" or char == "(" or char == ")" or char == "&" or char == "|" or char == "#" or char == "$" or char == "*" or char == "^" or char == "?" or char == "~" or char ==  "!" or char == "<" or char == ">" or char == ";" then --On regarde si un des charactères pose problème. Si s'est le cas on met un \ devant
            ret=ret.."\\"..char
        else
            ret=ret..char
        end
    end
    return ret
end
