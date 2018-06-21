#!/bin/bash

. "$(dirname $0)/VMs.rc"

for server in "${SERVERS[@]}"; do
   [ -t 1 ] || echo '```'
   echo "$server"
   echo "==============="
   ssh root@"$server" "df -lh|grep -v tmpfs | grep -v -F \"/boot\" | grep -v -F udev"
   [ -t 1 ] || echo '```'
   [ -t 1 ] && echo ""
   printf '\0' #divider when pasting to slack
done
