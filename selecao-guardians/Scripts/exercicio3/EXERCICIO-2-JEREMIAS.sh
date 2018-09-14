#!/bin/bash

controle=0
while [ $controle -lt $3 ]
do
    echo $[ $1 + $2 ]
    controle=$[$controle+1]
done
