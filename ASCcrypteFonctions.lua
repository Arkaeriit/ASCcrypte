--Ces fonctions servent à l'encryption et au décodage de fichiers.

function encrypt(fichierIN,password,fichierOUT) --Permet d'encripter fichierIn avec le mdp password vers fichierOUT ou stdout
    if fichierIN and (isDir(fichierIN)) then
        cmp(fichierIN,"/tmp/ASCcrypte") --Si on veut crypter tout un dossier il faut en premier en faire un archive
        fichierIN = "/tmp/ASCcrypte"
    end
    if fichierIN and fichierOUT and fichierOUT == fichierIN then --on décode fichier in dans fichier out
        local tmpFileName = "/tmp/ASCcrypteDoublon" --Fichier tampon par défault
        if fichierIN == tmpFileName then --si on veux s'occuper d'un fichier qui as le nom par default on peut le faire (c'est pas forcément utile)
            tmpFileName = "/tmp/ASCcrypteDoublon2"
        end   
        local f1 = io.open(fichierIN,"r")
        local f2 = io.open(tmpFileName,"w")
        copieFileToFile(f1,fileSize(fichierIN),f2)  --on copie le fichierIN dans le fichier tampon
        fichierIN = tmpFileName
        f1:close()
        f2:close()
    end
    if fichierIN and fichierOUT then
        print("opencr")
        crypte_file(fichierIN,fichierOUT,password)
        print("closecr")
    else
        local input
        local output
        if input then
            input = io.open(fichierIN)
        else 
            input = io.stdin
        end
        if fichierOUT then
            output = io.open(fichierOUT,"w")
        else
            output = io.stdout
        end
        local str = input:read("a")
        output:write(C_cryptage(str, password, #str))
    end
    rm("/tmp/ASCcrypte")
    rm("/tmp/ASCcrypteDoublon")
    rm("/tmp/ASCcrypteDoublon2")
end

