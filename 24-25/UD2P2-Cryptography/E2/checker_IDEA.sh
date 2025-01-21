#!/bin/bash

echo "Pega el ARMOR y pulsa Control+D para continuar"
read -r -d '' ENCRYPTED_MESSAGE << EOM
$(cat)
EOM

PASSPHRASE="UD2P1_shared_key"

echo "$ENCRYPTED_MESSAGE" | gpg --batch --passphrase "$PASSPHRASE" --decrypt > decrypted_content.txt 2> decryption.log

if grep -q "gpg: descifrado fallido" decryption.log; then
    echo "Desencriptación fallida"
    exit 1
fi

if grep -q "IDEA" decryption.log; then
    echo "El archivo está cifrado con IDEA"
    cat decrypted_content.txt
else
    echo "El archivo no está cifrado con IDEA"
    exit 1
fi

rm decrypted_content.txt decryption.log
