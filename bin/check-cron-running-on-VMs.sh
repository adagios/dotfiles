#!/bin/bash

. "$(dirname $0)/VMs.rc"

echo "Last update to cob-current-health.txt was less than 10 min ago (cron running):"
for server in "${SERVERS[@]}"; do
   if [[ "$server" == "prod2.lidl" || "$server" == "alfcobdb01" ]]; then
      printf  "%-30s : SKIPPED\n" $server

   else
      ssh "root@$server" -C "printf  \"%-35s : \" $server; (find /usr/share/nginx/html/cob-current-health.txt -mmin -10 -printf \"%CY-%Cm-%Cd %CH:%CM\\n\") || echo \"cob-current-health.txt older than 10m (CRON STOPPED??)\""
   fi
done
