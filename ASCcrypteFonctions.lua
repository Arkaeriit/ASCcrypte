--Cette fonction sert à l'encryption et au décodage de fichiers.

--[[function encrypt(fichierIN,password,fichierOUT) --Permet d'encripter fichierIn avec le mdp password vers fichierOUT ou stdout
    if fichierIN and (isDir(fichierIN)) then
        cmp(fichierIN,"/tmp/ASCcrypte")
        fichierIN = "/tmp/ASCcrypte"
    end
    local stringIn
    if fichierIN then
        stringIn = readFile(fichierIN)
    else
        stringIn = io.stdin:read("a")
    end
    local passwordLong = passwordGenerator(password,#password,#stringIn)
    local stringOut = C_cryptage(stringIn,passwordLong,#stringIn,#passwordLong)
    if fichierOUT then
        writeFile(stringOut,fichierOUT)
    else
        io.stdout:write(stringOut)
    end
end]]


function encrypt(fichierIN,password,fichierOUT) --Permet d'encripter fichierIn avec le mdp password vers fichierOUT ou stdout
    if fichierIN and (isDir(fichierIN)) then
        cmp(fichierIN,"/tmp/ASCcrypte")
        fichierIN = "/tmp/ASCcrypte"
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
    local strCripte = input:read(#passwordLong)
    while strCripte do
        output:write(strCripte)
        strCripte = input:read(#passwordLong)
    end
end

