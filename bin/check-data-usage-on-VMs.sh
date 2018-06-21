#!/bin/bash

. "$(dirname $0)/VMs.rc"

for server in "${SERVERS[@]}"; do
   echo ""
   echo "$server"
   echo "==============="
   ssh root@"$server" "du -shc /var/lib/mysql /var/lib/elasticsearch /var/lib/{userm,logm,recordm,integrationm,confm,workm} 2>/dev/null"
   echo ""
done
