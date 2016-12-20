#!/bin/bash

SERVERS=(df)

# linodes prod
SERVERS+=(bpopular galp galpdistribuicao multipla sinergi vodafone)
# linodes qual
SERVERS+=(diusframi diusframi-es galp-qual sinergi-qual)

# onprem prod
SERVERS+=(prod2.lidl dius.es-prod)

for server in "${SERVERS[@]}"; do
   echo ""
   echo "$server"
   echo "==============="
   ssh root@"$server" "df -h|grep -v tmpfs"
   echo ""
done
