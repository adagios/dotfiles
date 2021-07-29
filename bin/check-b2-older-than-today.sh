#!/bin/bash

SERVERS=$(searcher --server dogfooding.cultofbits.com --def Máquina --query "funcionamento produção acessível:sim" --single "Nome Máquina" --size 100)

for server in $SERVERS; do
   ssh "root@$server" ". /etc/sysconfig/duplicity-duplicity-to-b2 2>/dev/null; printf \"%-50s : %s\" \"$server\" \"\$(. /opt/duplicity/.env/bin/activate &>/dev/null ; duplicity collection-status \${DUPLICITY_ARGUMENTS[*]} 2>&1 | tail -3 | head -1)\" " | grep -v "$(LC_ALL=us date +"%b %e")"
done
