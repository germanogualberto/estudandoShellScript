#!/bin/bash

adicionarElemento(){
    echo $tempo
}
maioresLinhas=(hey teacher leaves) #us kids alone
maioresTempos=(0.0 0.0 0.0)


contador=0
comandos=()
while [ $# -gt 0 ]
do
    comandos[$contador]=$1
    #echo ${comandos[$contador]}
    contador=$[$contador+1]
    shift
done

`strace -T ${comandos[*]} &> traces`


while read linha
do
    for termo in ${linha[*]}
    do
        tempo=$termo
    done
    #echo ${tempo:0:1}
    if [ ${tempo:0:1} = '<' ]
    then
        adicionarElemento
    fi
    
done < traces

rm traces
