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
function ls(dossier)
  local f = io.popen("ls "..dossier,"r")
  local tab = {}
  local a = f:read()
  while a do
    tab[#tab+1] = a
    a = f:read()
  end
  f:close()
  return tab
end

function isDir(fichier)
  local f = io.popen("ls -l "..fichier,"r")
  local tab = {}
  local a = (f:read()):sub(1,1)
  if a=="l" then
    error("lien")
  else
    return a~="-"
  end
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
  os.execute("mkdir "..dir)
end

function uncmp(fichierArchive)
  local arch = convertFichTable(fichierArchive)
  local pointeurLigne = 1
  while arch[pointeurLigne]~="Debut de l'archive" do
    pointeurLigne = pointeurLigne + 1
  end
  pointeurLigne = pointeurLigne + 2
  for i=1,tonumber(arch[pointeurLigne-1]) do
    createDir(arch[pointeurLigne])
    pointeurLigne = pointeurLigne + 1
  end
  pointeurLigne = pointeurLigne + 1
  while arch[pointeurLigne] and arch[pointeurLigne+1] and arch[pointeurLigne+21] do
    local file = arch[pointeurLigne]
    pointeurLigne = pointeurLigne + 1
    local nLigne = tonumber(arch[pointeurLigne])
		if not nLigne then
			break
		end
    print(arch[pointeurLigne-1],arch[pointeurLigne],nLigne)
    pointeurLigne = pointeurLigne + 1
    local s = ""
    for i = pointeurLigne,pointeurLigne+nLigne-2 do
      s=s..arch[pointeurLigne].."\n"
      pointeurLigne = pointeurLigne + 1
    end
    s=s..arch[pointeurLigne]
    writeFile(s,file)
    pointeurLigne = pointeurLigne + 2
  end
end

-----------------------------------------Test----------------------------------------------------

function test1()
  local tab = searchDir("/home/maxime/Programation/lua/Autre/")
  local listeDoss={}
  archiveDir(tab,listeDoss,"")
  convertTableFich(listeDoss,"/home/maxime/Programation/lua/Autre/ASCcrypte/test.acm")
end --test1()

--cmp("/home/maxime/Programation/lua/Autre/","/home/maxime/Programation/lua/Autre/ASCcrypte/test.acm")
--uncmp("/home/maxime/Programation/lua/Autre/ASCcrypte/test.Atar")
