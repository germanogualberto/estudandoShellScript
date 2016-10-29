#!/bin/bash
#receber em 3 linhas ou uma linha com 3 parametros
#ler numero de observacoes N
#ler intervalo de tempo S
#ler um comeco de nome de usuario P_USER

capturarProgramas(){
    echo psaux executado
}

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

#a cada S segundos executar ps aux
#ps aux
#parar depois de executar N vezes
#capturar os programas dos usuarios q comecem com P_USER
#se nada for listado: exit 2

#USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND

tempoinicial=$SECONDS
contador=0
while [ $contador -lt $N ]
    do
        if [ $SECONDS -ge $[$tempoinicial+$S] ]
        then        
            contador=$[$contador+1]
            capturarProgramas
            tempoinicial=$SECONDS
        fi
    done

#se algo for encontrado exibir:
#somatorio de %CPU dos processos
#somatorio de %MEM dos processos
#maior e menor valor de CPU encontrado
#maior e menor valor de MEM encontrado

#adcionar funcionalidade extra
