#!/bin/bash

SERVERS=$(~/.bin/searcher --server dogfooding.cultofbits.com --def Máquina --query "funcionamento acessível:sim -iac:ansible" --single "Nome Máquina" --size 100)

for server in $SERVERS; do
   printf "%-40s: " "$server"
   ssh -F ~/.ssh/config_cron -o "BatchMode yes" -o "ConnectTimeout 5" -o "StrictHostKeyChecking accept-new" "root@${server/.com/.pt}" "ls -ld chef-solo 2>&1" 2>&1
done | grep -iv "no such file"
