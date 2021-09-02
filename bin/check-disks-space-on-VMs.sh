#!/bin/bash

SERVERS=$(./searcher --server dogfooding.cultofbits.com --def Máquina --query "funcionamento produção acessível:sim" --single "Nome Máquina" --size 100)

for server in $SERVERS; do
   [ -t 1 ] || echo '```'
   echo "$server"
   echo "==============="
   ssh root@"$server" "df -lh|grep -v tmpfs | grep -v -F \"/boot\" | grep -v -F udev"
   [ -t 1 ] || echo '```'
   [ -t 1 ] && echo ""
   printf '\0' #divider when pasting to slack
done
