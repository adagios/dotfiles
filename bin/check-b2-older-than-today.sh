#!/bin/bash

. "$(dirname $0)/VMs.rc"

for server in "${SERVERS_LINODE[@]}"; do
   ssh "root@$server" ". /etc/sysconfig/duplicity-duplicity-to-b2 2>/dev/null; printf \"%-50s : %s\" \"$server\" \"\$(. /opt/duplicity/.env/bin/activate &>/dev/null ; duplicity collection-status \${DUPLICITY_ARGUMENTS[*]} 2>&1 | tail -3 | head -1)\" " | grep -v "$(LC_ALL=us date +"%b %e")"
done
