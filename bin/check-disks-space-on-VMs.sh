#!/bin/bash

SERVERS="df galp galpdistribuicao bpopular vodafone diusframi diusframi-es prod2.lidl everis"

for server in $SERVERS; do
   echo ""
   echo "$server"
   echo "==============="
   ssh root@"$server" "df -h|grep -v tmpfs"
   echo ""
done
