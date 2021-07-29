#!/bin/bash

SERVERS=$(searcher --server dogfooding.cultofbits.com --def Máquina --query "funcionamento produção acessível:sim" --single "Nome Máquina" --size 100)

for server in $SERVERS; do
   ssh root@"$server" "df -l -h| awk '0+\$5 >= 80 {printf \"%-40s: %-30s @ %-30s [%3s] free: %5s \n\", \"$server\", \$1, \$6, \$5, \$4 }'"
done
