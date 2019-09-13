--Ces fonctions servent à la compression en un seul fichier archive de dossier et à la décompression de ces archives

function copieFileToFile(descripteurIN,size,descripteurOUT) --ecrit les size prochain octes de descripteurIN vers descripteurOUT; prend en compte RAM_USAGE_BASE
    if size > 0 then
        local pointeur = 0
        while pointeur < size do
            if pointeur + RAM_USAGE_BASE > size then
                descripteurOUT:write(descripteurIN:read(size - pointeur))
                pointeur = size
            else
                descripteurOUT:write(descripteurIN:read(RAM_USAGE_BASE))
                pointeur = pointeur + RAM_USAGE_BASE
            end
        end
    end
end


-----------------------------------------Doss/table pour l'encodage----------------------------------------------------

function searchDir(dossier) --écrit le contenu du dossoer dans une table indéxée par le nom du fichier. Si le fichier est un dossier on recommence sinon on met un 1 pour dire que c'est un fichier.
  local ret = {}
  local doss = ls(dossier)
  for i=1,#doss do
    if isDir(dossier..doss[i]) then
      ret[doss[i]]=searchDir(dossier..doss[i].."/")
    else
      ret[doss[i]] = 1
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

function placeFile(dossierSource,nomFile,objetFichierArchive)
    local size = fileSize(dossierSource..nomFile)
    local fIN = io.open(dossierSource..nomFile,"r")
    objetFichierArchive:write(nomFile,"\n",tostring(size),"\n")
    copieFileToFile(fIN,size,objetFichierArchive)
    fIN:close()
    objetFichierArchive:write("\n\n")
end

function archiveFile(dossier,dossTable,currentDir,objetFichierArchive) --On écrit les fichiers à archiver dans le fichier
  for a,v in pairs(dossTable) do
    if type(v)=="table" then
      archiveFile(dossier,v,currentDir..a.."/",objetFichierArchive)
    else
      placeFile(dossier,currentDir..a,objetFichierArchive)
    end
  end
end

function cmp(dossier,fichierArchive)
	if dossier:sub(#dossier,#dossier)~="/" then
		dossier=dossier.."/"
	end
    local dossTable = searchDir(dossier) --on récupère la liste des dossiers et des fichiers
    local directoryList={}
    archiveDir(dossTable,directoryList,"") --on récupère la liste des dossiers à créer
    local f = io.open(fichierArchive,"w")
    f:write("Debut de l'archive\n") --on indique le début
    f:write(tostring(#directoryList),"\n") --on indique le nombre de dossier à créer
    for i=1,#directoryList do 
        f:write(directoryList[i],"\n") --on indique le nom des dossiers à créer
    end
    f:write("\n")
    archiveFile(dossier,dossTable,"",f) --on écrit les fichiers
    f:close()
end

--------------------------------------------Lecture de l'archive----------------------------------------------------------------------

function uncmp(fichierArchive,destination)
    if destination:sub(#destination,#destination) ~= "/" then
        destination = destination.."/"
    end
    local arch = io.open(fichierArchive,"r")
    local line = arch:read("l")
    while line ~= "Debut de l'archive" do --on cherche l'indication que l'on commence l'archive
        line = arch:read("l")
        if not line then --Si ce n'est pas une bonne  archive on arrête tout
            io.stderr:write("Error: ",fichierArchive," is not an archive file handeled by this software.\n")
            return nil
        end
    end
    local n = tonumber(arch:read("l")) --nombre de dossier à créer
    for i=1,n do
        createDir(destination..arch:read("l"))
    end
    arch:read("l") --espace vide
    local file = arch:read("l") --fichier que l'on va remplir
    local nChar = tonumber(arch:read("l")) --taille du fichier
    while file and nChar do
        local f = io.open(destination..file,"w")
        copieFileToFile(arch,nChar,f) --On copie notre fichier là où  il faut
        f:close()
        arch:read(2) --les deux \n que l'on a mis à la fin du fichier
        file = arch:read("l") --fichier que l'on va remplir
        nChar = tonumber(arch:read("l")) --nombre de ligne du fichier
    end
    arch:close()
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

