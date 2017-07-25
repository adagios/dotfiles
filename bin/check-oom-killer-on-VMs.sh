#!/bin/bash

. "$(dirname $0)/VMs.rc"

echo "OOM Killer, last 5 days:"
for server in "${SERVERS[@]}"; do
   if [[ "$server" == "prod2.lidl" ]]; then
      ssh "root@$server" -C "printf  \"%-30s : \" $server; (grep Killed /var/log/messages) || echo \"Nothing killed\""
   else
      ssh "root@$server" -C "printf  \"%-30s : \" $server; (journalctl --since '5 days ago' -k | grep Killed) || echo \"Nothing killed\""
   fi
done
