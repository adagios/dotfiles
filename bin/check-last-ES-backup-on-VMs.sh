#!/bin/bash

# for jq
PATH="$PATH:/usr/local/bin"

SERVERS=$(./searcher --server dogfooding.cultofbits.com --def Máquina --query "funcionamento produção acessível:sim" --single "Nome Máquina" --size 100)

echo "# Detalhes do backup ES de $(date +'%Y-%m-%d')"
for server in $SERVERS; do
   echo "## $server"
   echo "==============="
   echo '```json'

   # older servers
   # see https://stackoverflow.com/questions/8063228/how-do-i-check-if-a-variable-exists-in-a-list-in-bash
   if [[ "diusframi-es bpopular" =~ (^|[[:space:]])$server($|[[:space:]]) ]]; then
      ssh "root@$server" -C "curl -sS --proxy '' -b /home/cob/.cob-cookie localhost:40790/_snapshot/es_backups/es_snapshot_$(date +'%Y-%m-%d')" | jq -c ".snapshots[].indices,.snapshots[].shards"

   # servidores sem backups
   elif [[ "alfcobdb01" =~ (^|[[:space:]])$server($|[[:space:]]) ]]; then
      echo "THIS SERVER DOES NOT BACKUP"
 
   else # normal, up to date servers
      ssh "root@$server" -C "curl -sS --proxy '' -b /home/cob/.cob-cookie localhost:9200/_snapshot/es_backups/es_snapshot_$(date +'%Y-%m-%d')*" | jq -c ".snapshots[].indices,.snapshots[].shards"
   fi
   echo '```'
   echo ""
done
