#!/bin/bash

controle=0

if [ $1 -eq 5 ]; then
echo nao vai da nao
exit 0
fi


while [ $controle -lt $1 ]
do
    echo guardians rules
    controle=$[$controle+1]
done
