#!/bin/bash

adicionarElemento(){
    #echo $tempo
    if (( $(echo "$tempo > ${maioresTempos[$j]} " | bc -l) ))
    then
        b=$[$j-1]
        if (( $(echo "$j > 0 " | bc -l) )) 
        then
            if (( $(echo "$tempo < ${maioresTempos[$b]} " | bc -l) ));then
                maioresTempos[$j]=$tempo
                maioresLinhas[$j]=$linha
            fi
        else
            maioresTempos[$j]=$tempo
            maioresLinhas[$j]=$linha
        fi
        #echo ${maioresLinhas[0]}
        #echo ${maioresTempos[0]}
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

for j in 0 1 2; do
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
done

echo Chamadas:
for i in 0 1 2
do
    echo ${maioresLinhas[$i]}
done

#funcionalidade extra

rm traces
