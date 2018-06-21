#!/bin/bash

. "$(dirname $0)/VMs.rc"

echo "# heapdumps"
for server in "${SERVERS[@]}"; do
   ssh "root@$server"\
      -C "find /var/log -name '*.hprof*' -printf '$server: [%CY-%Cm-%Cd %CH:%CM] %k Kb %p\\n' | egrep '.*'"
done
