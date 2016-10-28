#!/bin/bash

#formato do arquivo
#ORIGEM - - DATA “AÇÃO” STATUS TAMANHO

#descartar linhas
arq=access_log

contador=0
locais=0
remotas=0
horasLocais=0
horasRemotas=0
tamanhos=0

while read linha
do
    requisicao=()
    i=0
    for termo in $linha
    do
        requisicao[$i]=$termo
        i=$[$i+1]
    done

    if [ ${#requisicao[*]} -eq 10 ] && [ ${requisicao[1]} = - ] && [ ${requisicao[2]} = - ]
    then
        #echo ${requisicao[9]}
        case ${requisicao[0]} in
            local)
                hora=${requisicao[3]}
                let horasLocais=$[$horasLocais+${hora:13:2}]
                let locais=$[$locais+1];;
            remote)
                hora=${requisicao[3]}
                let horasRemotas=$[$horasRemotas+${hora:13:2}]
                let remotas=$[$remotas+1];;
            *)
                echo algo errado;;
        esac
    fi

    if [ ${requisicao[9]} != - ]
    then
        tamanhos=$[$tamanhos+${requisicao[9]}]
    fi
    
    contador=$[$contador+1]
    if [ $contador -eq 140 ]
    then
        break
    fi

    #echo $locais
done < $arq
#sumarizar dados
#-quantas requisicoes locais foram feitas
echo Requisicoes locais feitas: $locais

#-quantas requisicoes remotas foram feitas
echo Requisicoes remotas feitas: $remotas

#-em media, hora das requisicoes locais
media=$[$horasLocais / $locais]
echo Hora das requisicoes locais em media: $media

#-em media, hora das requisicoes remotas
media=$[$horasRemotas / $remotas]
echo Hora das requisicoes remotas em media: $media

#funcionalidade extra
#media do tamanho das requisicoes
media=$[$tamanhos / $contador]
echo Tamanho medio das requisicoes feitas: $media

