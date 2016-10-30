#!/bin/bash

adicionarElemento(){
    #echo $tempo
    if (( $(echo "${maioresTempos[0]} < $tempo" | bc -l) ))
    then
        maioresTempos[0]=$tempo
        maioresLinhas[0]=$linha
        echo $linha
        echo $tempo
    fi
    
}
maioresLinhas=(hey teacher leave) #those kids alone
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
        tempo=${tempo/</''}
        tempo=${tempo/>/''}
        adicionarElemento
    fi
    
done < traces

rm traces
