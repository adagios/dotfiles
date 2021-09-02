#!/bin/bash

SERVERS=$(./searcher --server dogfooding.cultofbits.com --def Máquina --query "funcionamento linode" --single "Nome Máquina" --size 100)

for server in $SERVERS; do
   ssh root@"$server" "sar | tail -1 | sed 's/ \+/;/g'| cut -d';' -f7 | awk '{printf \"%-40s: %5s \n\", \"$server\", \$1 }'"
done
