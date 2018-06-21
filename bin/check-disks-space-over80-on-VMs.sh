#!/bin/bash

. "$(dirname $0)/VMs.rc"

for server in "${SERVERS[@]}"; do
   ssh root@"$server" "df -h| awk '0+\$5 >= 80 {printf \"%-30s: %-30s @ %-30s [%3s] free: %5s \n\", \"$server\", \$1, \$6, \$5, \$4 }'"
done
