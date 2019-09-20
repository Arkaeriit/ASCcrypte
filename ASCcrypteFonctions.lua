--Ces fonctions servent à l'encryption et au décodage de fichiers.

function encrypt(fichierIN,password,fichierOUT) --Permet d'encripter fichierIn avec le mdp password vers fichierOUT ou stdout
    if fichierIN and (isDir(fichierIN)) then
        cmp(fichierIN,"/tmp/ASCcrypte")
        fichierIN = "/tmp/ASCcrypte"
    end
    if fichierIN and fichierOUT and fichierOUT == fichierIN then --on décode fichier in dans fichier out
        local f1 = io.open(fichierIN,"r")
        local f2 = io.open("/tmp/ASCcrypteDoublon","w")
        copieFileToFile(f1,fileSize(fichierIN),f2)
        fichierIN = "/tmp/ASCcrypteDoublon"
        f1:close()
        f2:close()
    end
    local input
    local output
    if fichierIN then
        input = io.open(fichierIN,"r")
    else
        input = io.stdin
    end
    if fichierOUT then
        output = io.open(fichierOUT,"w")
    else
        output = io.stdout
    end
    local passwordLong = passwordGenerator(password,#password)
    local lenPass = #passwordLong
    local sizeRead = sizeBlock(lenPass)
    local strCripte = input:read(sizeRead)
    while strCripte do
        output:write(C_cryptage(strCripte,passwordLong,#strCripte,lenPass))
        strCripte = input:read(sizeRead)
    end
end

function sizeBlock(lenPL) -- permet de connaitre une taille de block d'eviron 500 MiO
    local len = math.abs(RAM_USAGE_BASE / lenPL) * lenPL --créé un résultat multiple de lenPL
    if len < lenPL then
        return math.tointeger(lenPL)
    else
        return math.tointeger(len)
    end
    os.execute("/bin/rm -f /tmp/ASCcrypte /tmp/ASCcrypteDoublon")
end
