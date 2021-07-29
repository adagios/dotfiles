#!/bin/bash

SERVERS=$(searcher --server dogfooding.cultofbits.com --def Máquina --query "funcionamento linode produção" --single "Nome Máquina" --size 100)

echo "OOM Killer, last 5 days:"
for server in $SERVERS; do
   if [[ "$server" == "prod2.lidl" ]]; then
      ssh "root@$server" -C "printf  \"%-40s : \" $server; (grep Killed /var/log/messages) || echo \"Nothing killed\""
   else
      ssh "root@$server" -C "printf  \"%-40s : \" $server; (journalctl --since '5 days ago' -k | grep Killed) || echo \"Nothing killed\""
   fi
done
