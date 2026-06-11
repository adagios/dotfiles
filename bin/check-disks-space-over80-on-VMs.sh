#!/bin/bash

SERVERS=$(~/.bin/searcher --server dogfooding.cultofbits.com --def Máquina --query "funcionamento produção acessível:sim" --single "Nome Máquina" --size 100 2> /tmp/searcher.log)

arr=($SERVERS)
echo "servers: ${#arr[@]}"
for server in $SERVERS; do
   ssh -F ~/.ssh/config_cron root@"${server/.com/.pt}" -o "ConnectTimeout=3" \
      "df -l -h -xsquashfs -xtmpfs -xdevtmpfs| awk '0+\$5 >= 80 {printf \"%-40s: %-30s @ %-30s [%3s] free: %5s \n\", \"$server\", \$1, \$6, \$5, \$4 }'"
done
