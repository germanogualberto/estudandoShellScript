#!/bin/bash

capturarProgramas(){
    #USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
    echo psaux executado pela $contador vez
    dados=()
    ps aux > processos
    while read linha
    do
        if [ $P_USER = ${linha:0:${#P_USER}} ]
        then
            retornouAlgo=1
            indice=0
            echo $linha
            for i in $linha
            do
                dados[$indice]=$i
                #echo $indice $i ${dados[$indice]}
                indice=$[$indice+1]
            done
            #echo ${dados[3]}
            MEM=` echo $MEM+${dados[3]}  | bc`
            CPU=` echo $CPU+${dados[2]}  | bc`
            if (( $(echo "${dados[2]} > $maiorValorCPU" | bc -l) ))
            then
                maiorValorCPU=${dados[2]}
            fi
            if (( $(echo "${dados[2]} < $menorValorCPU" | bc -l) ))
            then
                menorValorCPU=${dados[2]}
            fi
            if (( $(echo "${dados[3]} > $maiorValorMEM" | bc -l) ))
            then
                maiorValorMEM=${dados[3]}
            fi
            if (( $(echo "${dados[3]} < $menorValorMEM" | bc -l) ))
            then
                menorValorMEM=${dados[3]}
            fi

        fi
    done < processos
    #CPU=2
    echo
}

#receber em 3 linhas ou uma linha com 3 parametros
#ler numero de observacoes N
#ler intervalo de tempo S
#ler um comeco de nome de usuario P_USER
case $# in
    3)
        N=$1
        S=$2
        P_USER=$3;;
    2)
        N=$1
        S=$2
        read P_USER;;
    1)
        N=$1
        read S
        read P_USER;;
    *)
        read N
        read S
        read P_USER;;
esac

#teste maroto das entradas
#echo 'S# :' $#
#echo N: $N
#echo S: $S
#echo P_USER: $P_USER

#se N ou S <=0 ou se uma das entradas for vazia: exit 1
if [ -z $N ] || [ -z $S ] || [ -z $P_USER ] 
    then
        echo Algumas das entradas dadas estaao vazias
        exit 1
elif [ $N = 0 ] || [ $S = 0 ]
    then
        echo Algumas das entradas dadas estaao nulas
        exit 1
fi

#dados a serem exibidos posteriormente
CPU=0
MEM=0
maiorValorCPU=0
menorValorCPU=100
maiorValorMEM=0
menorValorMEM=100
retornouAlgo=0

tempoinicial=$SECONDS
contador=0
#parar depois de executar N vezes
while [ $contador -lt $N ]
    do
        #a cada S segundos executar ps aux
        if [ $SECONDS -ge $[$tempoinicial+$S] ]
        then        
            contador=$[$contador+1]
            #capturar os programas dos usuarios q comecem com P_USER
            capturarProgramas
            tempoinicial=$SECONDS
        fi
    done

#se nada for listado: exit 2
if [ $retornouAlgo -eq 0 ]
then
    exit 2
fi

#se algo for encontrado exibir:
#somatorio de %CPU dos processos
#somatorio de %MEM dos processos
#maior e menor valor de CPU encontrado
#maior e menor valor de MEM encontrado

echo
echo Resultado para usuario que comeca com: $P_USER
echo Somatorio de %CPU dos processos: $CPU
echo Somatorio de %MEM dos processos: $MEM
echo Maior valor de CPU encontrado: $maiorValorCPU
echo Menor valor de CPU encontrado: $menorValorCPU
echo Maior valor de MEM encontrado: $maiorValorMEM
echo Menor valor de MEM encontrado: $menorValorMEM
rm processos

#adcionar funcionalidade extra
