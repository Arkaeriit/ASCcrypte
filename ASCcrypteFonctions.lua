--Ces fonctions servent à l'encryption et au décodage de fichiers.

function encrypt(fichierIN,password,fichierOUT) --Permet d'encripter fichierIn avec le mdp password vers fichierOUT ou stdout
    if fichierIN and (isDir(fichierIN)) then
        cmp(fichierIN,"/tmp/ASCcrypte")
        fichierIN = "/tmp/ASCcrypte"
    end
    if fichierIN and fichierOUT and fichierOUT == fichierIN then --on décode fichier in dans fichier out
        os.execute("/bin/cp -f "..antiSlashing(fichierIN).." /tmp/ASCcrypteDoublon")
        fichierIN = "/tmp/ASCcrypteDoublon"
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
    local len = math.abs((1048576 * 500) / lenPL) * lenPL --créé un résultat multiple de lenPL
    if len < lenPL then
        return math.tointeger(lenPL)
    else
        return math.tointeger(len)
    end
    os.execute("/bin/rm -f /tmp/ASCcrypte /tmp/ASCcrypteDoublon")
end
