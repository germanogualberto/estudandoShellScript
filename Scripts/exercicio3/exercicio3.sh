#!/bin/bash


#CASOS DE TESTES ELABORADOS ---------------------------------------#

#EXERCICIO 1
#RECEBE UM INTEIRO N E IMPRIME "guardians rules" N VEZES
#EXERCICIO 2
#RECEBE 3 INTEIROS A B C E IMPRIME A+B C VEZES

#JEREMIAS E MURALHA RESPONDEM CORRETAMENTE
#TOCADOR DE TERROR ERRA SO O CASO 2 DO EXERCICIO 1 E O EXERCICIO 2

#------------------------------------------------------------------#

#Uso:
#exercicio3.sh <NUMERO DO EXERCICIO> <NOME DO ALUNO>
#-se receber nenhum parametro, executa todos os exercicios de todos os alunos
#-se receber apenas o numero do exercicio, executa a resposta de todos os alunos
#para aquele exercicio

#OBS:
#para meu script funcionar melhor, o formato dos aquivos deveria ser
#EXERCICIO-1-NOME_DO_ALUNO.sh


#Saida:
#Para cada resposta de aluno do exercicio

#EXERCICIO_<NUMERO DO EXERCICIO>_<NOME_DO_ALUNO>
#-SAIDA ENTRADA <NUMERO DO CASO DE TESTE>
#
#<SAIDA AQUI>
#
#-DIFERENCA PARA SAIDA ESPERADA:
#
#-SAIDA DAS OUTRAS ENTRADAS
#
#SAIDA DE EXERCICIOS DE OUTROS ALUNOS
#
#PROVAVEL SAIDA PARA OUTROS EXERCICIOS

imprimeTeste(){
    echo ${dados[0]}_${dados[1]}_${dados[2]}
    testes=`echo *_${dados[1]}_*.in`
    #echo ${testes[*]}

    numero=0
    IFS=' '
    for teste in ${testes[*]}
    do
        gabarito=${teste/in/out}
        echo -SAIDA PARA ENTRADA $[$numero+1]
        #execucao marota
        ./$i `cat $teste` > resposta
        echo `cat resposta`
        echo
        echo -DIFERENCA PARA A SAIDA ESPERADA
        #diff maroto
        diff resposta $gabarito
        echo
        numero=$[$numero+1]
    done
    rm resposta
    
}

case $# in
    2)
        n=$1
        nome=$2;;
    1)
        n=$1
        nome=ALL;;
    0)
        n=ALL
        nome=ALL;;
    *)
        echo vish;;
esac

arquivos=(`echo *.sh`)
#echo ${arquivos[*]}

for i in ${arquivos[*]}
do
    
    dados=()
    indice=0;
    #pega o arquivo
    IFS=-
    for str in $i
    do
        #echo $str
        dados[indice]=$str
        indice=$[$indice+1]
    done
    #echo ${dados[0]}
    #testa se eh uma resposta
    if [ ${dados[0]} = EXERCICIO ]
    then
        #testa se o numero do exercicio pode ser executado
        if [ $n = ${dados[1]} ] || [ $n = 'ALL' ]
        then
            dados[2]=${dados[2]/'.sh'/''}
            #testa se o nome do aluno pode ser executado
            if [ $nome = ${dados[2]} ] || [ $nome = 'ALL' ]
            then
                imprimeTeste
            fi
        fi
    fi
    
    #executa os casos para a respostas
    #exibe resultados
    IFS=' '
done

