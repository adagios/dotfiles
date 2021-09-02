#!/bin/bash

SERVERS=$(./searcher --server dogfooding.cultofbits.com --def Máquina --query "funcionamento produção acessível:sim" --single "Nome Máquina" --size 100)

for server in $SERVERS; do
   ssh root@"$server" "sar | tail -1 | sed 's/ \+/;/g'| cut -d';' -f7 | awk '0+\$1 >= 5 {printf \"%-30s: %5s \n\", \"$server\", \$1 }'"
done
