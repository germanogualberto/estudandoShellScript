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

contarChamadas() {
     
     #echo $syscall
     num=0
     #posicao impar = nome da syscall
     #posicao impar+1 = quantidade de chamadas da syscall
     for element in ${chamadas[*]}
     do
        if [ $element = $syscall ]
        then
            #achou o elemento na lista
            chamadas[$num+1]=$[${chamadas[$num+1]}+1]
            achou=sim
            break
        else
            achou=nao
        #    chamadas[$num]=$syscall
        #    chamadas[$num+1]=1
        fi
        #echo ${chamadas[*]}
        #read abbbbb
        num=$[$num+1]
     done
     if [ $achou = nao ]
     then
        chamadas[$num]=$syscall
        chamadas[$num+1]=1
     fi
}

maiorChamada(){
    #quantBigger=0
    cont=2
    while [ $cont -lt ${#chamadas[*]} ] || [ $cont -eq ${#chamadas[*]} ]
    do
        if [ ${chamadas[cont]} -gt $quantBigger ]
        then
            quantBigger=${chamadas[cont]}
            sysMaisChamada=${chamadas[cont-1]}
        fi
        cont=$[$cont+2]
    done
}


chamadas=(entao)

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

        syscall=${linha/(*/''}
        if [ ${syscall:0:1} != ')' ]
        then
            #echo $syscall
            contarChamadas
        fi
        
    fi
    
done < traces
done
echo -------------------------------------------------------------------
echo Chamadas:
for i in 0 1 2
do
    echo ${maioresLinhas[$i]}
done


#funcionalidade extra
quantBigger=0
sysMaisChamada=null
maiorChamada
echo
echo Syscall mais chamada: $sysMaisChamada $quantBigger vezes
echo -------------------------------------------------------------------

rm traces
