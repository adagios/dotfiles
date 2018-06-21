#!/bin/bash

. "$(dirname $0)/VMs.rc"

echo "# Detalhes dos backups BD de $(date +'%Y-%m-%d')"
for server in "${SERVERS[@]}"; do
   if [[ "$server" != "alfcobfe01" && "$server" != "alfcobfe02" ]]; then
      echo "## $server"
      echo "==============="
      echo '```json'

      ssh "root@$server" -C "(find /var/backups/ -name \"*.sql.gz\" -ctime -1 | sort | egrep \".*\") || echo \"No backups found for $(date +'%Y-%m-%d')\""

      echo '```'
   fi
   echo ""
done
