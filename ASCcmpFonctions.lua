function convertFichTable(fichier)
	local tab={}
	local f=io.open(fichier,"r")
	local num=1
	local flag=true
	while f and flag do
		local lign=f:read()
		if lign==nil then
			flag=false
		else
			tab[num]=lign
		end
		num=num+1
	end
	if f then f:close() end
	return tab
end

function writeFile(s,fichier) --écrit la chaine de caractères s dans fichier
  local f = io.open(fichier,"w")
  f:write(s)
  f:close()
end

function count(base, pattern) --pas de moi
    return select(2, string.gsub(base, pattern, ""))
end

-----------------------------------------Doss/table pour l'encodage----------------------------------------------------
function exist(fichier)
    local f = io.open(fichier,"r")
    if f then
        f:close()
        return true
    else
        return false
    end
end

function ls(dossier)
  local dossierSafe = antiSlashing(dossier)
  local f = io.popen("ls -a "..dossierSafe,"r")
  local tab = {}
  local a = f:read()
  while a do
    if a~="." and a~=".." then  
      tab[#tab+1] = a
    end
    a = f:read()
  end
  f:close()
  return tab
end

function isDir(fichier)
  local fichierSafe = antiSlashing(fichier)
  local f = io.popen("ls -l "..fichierSafe,"r")
  local lig = f:read()
  f:close()
  local a = (lig):sub(1,1)
  if a=="l" then
    error("lien")
  else
    return a~="-"
  end
end

function antiSlashing(string) --renvoie une chaine qui est comme string mais avec un anti-slash avant chaque charctère qui causerait un problème
    local ret = ""
    for i=1,#string do
        local char = string:sub(i,i)
        if char == " " or char == '"' or char == "'" or char == "`" or char == "\\" or char == "(" or char == ")" or char == "&" or char == "|" or char == "#" or char == "$" or char == "*" or char == "^" or char == "?" or char == "~" or char ==  "!" then --On regarde si un des charactères pose problème. Si s'est le cas on met un \ devant
            ret=ret.."\\"..char
        else
            ret=ret..char
        end
    end
    return ret
end

function searchDir(dossier) --écrit le contenu du dossoer dans une table indéxée par le nom du fichier
  local ret = {}
  local doss = ls(dossier)
  for i=1,#doss do
    if isDir(dossier..doss[i]) then
      ret[doss[i]]=searchDir(dossier..doss[i].."/")
    else
      local f = io.open(dossier..doss[i])
      ret[doss[i]]=f:read("a")
      f:close()
    end
  end
  return ret
end

--------------------------------------------Création de l'archive----------------------------------------------------------------------

function archiveDir(dossTable,directoryList,currentDir) --on fait une liste de tout l'arbre que l'on doit archiver
  for a,v in pairs(dossTable) do
    if type(v)=="table" then
      directoryList[#directoryList+1]=currentDir..a.."/"
      archiveDir(v,directoryList,currentDir..a.."/")
    end
  end
end

function placeFile(str,nomFile,objetFichierArchive)  --str est une chainer contenant un fichier nomé nomFile et objetFichierArchive est ce vers quoi on archive,déja ouvert
  local lines = count(str,"\n")
  objetFichierArchive:write(nomFile,"\n",tostring(lines+1),"\n",str,"\n","\n")
end

function archiveFile(dossTable,currentDir,objetFichierArchive) --On écrit les fichiers à archiver dans le fichier
  for a,v in pairs(dossTable) do
    if type(v)=="table" then
      archiveFile(v,currentDir..a.."/",objetFichierArchive)
    else
      placeFile(v,currentDir..a,objetFichierArchive)
    end
  end
end


function cmp(dossier,fichierArchive)
	if dossier:sub(#dossier,#dossier)~="/" then
		dossier=dossier.."/"
	end
    local dossTable = searchDir(dossier)
    local directoryList={}
    archiveDir(dossTable,directoryList,"")
    local f = io.open(fichierArchive,"w")
    f:write("Debut de l'archive\n")
    f:write(tostring(#directoryList),"\n")
    for i=1,#directoryList do
        f:write(directoryList[i],"\n")
    end
    f:write("\n")
    archiveFile(dossTable,"",f)
    f:close()
end

--------------------------------------------Lecture de l'archive----------------------------------------------------------------------

function createDir(dir)
  local dossierSafe = antiSlashing(dir)
  os.execute("mkdir "..dossierSafe)
end

function uncmp(fichierArchive,destination)
    if destination:sub(#destination,#destination)~="/" then
        destination = destination.."/"
    end
    local arch = convertFichTable(fichierArchive)
    local pointeurLigne = 1
    while arch[pointeurLigne]~="Debut de l'archive" do
    pointeurLigne = pointeurLigne + 1
    if pointeurLigne > #arch then
        io.stderr:write("Error: ",fichierArchive," is not a archive file handeled by this software.\n")
        return nil
    end
    end
    pointeurLigne = pointeurLigne + 2
    for i=1,tonumber(arch[pointeurLigne-1]) do
        createDir(destination..arch[pointeurLigne])
        pointeurLigne = pointeurLigne + 1
    end
    pointeurLigne = pointeurLigne + 1
    while arch[pointeurLigne] and arch[pointeurLigne+1] and arch[pointeurLigne+2] do
        local file = arch[pointeurLigne]
        pointeurLigne = pointeurLigne + 1
        local nLigne = tonumber(arch[pointeurLigne])
        if not nLigne then
            break
        end
        pointeurLigne = pointeurLigne + 1
        local s = ""
        for i = pointeurLigne,pointeurLigne+nLigne-2 do
            s=s..arch[pointeurLigne].."\n"
            pointeurLigne = pointeurLigne + 1
        end
        s=s..arch[pointeurLigne]
        writeFile(s,destination..file)
        pointeurLigne = pointeurLigne + 2
    end
end

-----------------------------------------Interactions C----------------------------------------------------

function compress(dossier,archive)
    if archive then
        cmp(dossier,archive)
    else
        cmp(dossier,"/tmp/ASCtar")
        local f = io.open("/tmp/ASCtar","r")
        io.stdout:write(f:read("a"))
        f:close()
    end
end

function decompress(archive,destination)
    if archive then
        uncmp(archive,destination)
    else
        local f = io.open("/tmp/ASCcmpSTDIN","w")
        f:write(io.stdin:read("a"))
        f:close()
        uncmp("/tmp/ASCcmpSTDIN",destination)
    end
end

