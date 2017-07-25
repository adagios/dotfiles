#!/bin/bash

. "$(dirname $0)/VMs.rc"

echo "# Detalhes do backup ES de $(date +'%Y-%m-%d')"
for server in "${SERVERS[@]}"; do
   echo "## $server"
   echo "==============="
   echo '```json'

   # older servers
   # see https://stackoverflow.com/questions/8063228/how-do-i-check-if-a-variable-exists-in-a-list-in-bash
   if [[ "diusframi-es bpopular galp galpdistribuicao" =~ (^|[[:space:]])$server($|[[:space:]]) ]]; then
      ssh "root@$server" -C "curl -sS --proxy '' -b /home/cob/.cob-cookie localhost:40790/_snapshot/es_backups/es_snapshot_$(date +'%Y-%m-%d')" | jq -c ".snapshots[].indices,.snapshots[].shards"

   # servidores sem backups
   elif [[ "galp-qual" =~ (^|[[:space:]])$server($|[[:space:]]) ]]; then
      echo "THIS SERVER DOES NOT BACKUP"

   #lidl
   elif [[ "prod2.lidl" =~ (^|[[:space:]])$server($|[[:space:]]) ]]; then
      ssh "root@$server" -C "curl -sS --proxy '' -b /home/cob/.cob-cookie localhost:40290/_snapshot/es_backups/es_snapshot_$(date +'%Y-%m-%d')" | jq -c ".snapshots[].indices,.snapshots[].shards"

   else # normal, up to date servers
      ssh "root@$server" -C "curl -sS --proxy '' -b /home/cob/.cob-cookie localhost:9200/_snapshot/es_backups/es_snapshot_$(date +'%Y-%m-%d')" | jq -c ".snapshots[].indices,.snapshots[].shards"
   fi
   echo '```'
   echo ""
done
