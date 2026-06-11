#!/bin/bash

BASE_QUERY="funcionamento produção acessível:sim hosting:linode"

SERVERS=$(~/.bin/searcher --server dogfooding.cultofbits.com --def Máquina --query "$BASE_QUERY -iac:ansible" --single "Nome Máquina" --size 100 | sed "s/.com/.pt/")

for server in $SERVERS; do
   ssh -F ~/.ssh/config_cron "root@$server" ". /etc/sysconfig/duplicity-duplicity-to-b2 2>/dev/null; printf \"%-50s : %s\" \"$server\" \"\$(. /opt/duplicity/.env/bin/activate &>/dev/null ; duplicity collection-status \${DUPLICITY_ARGUMENTS[*]} 2>&1 | tail -3 | head -1)\" " | grep -v "$(LC_ALL=us date +"%b %e")"
done

SERVERS=$(~/.bin/searcher --server dogfooding.cultofbits.com --def Máquina --query "$BASE_QUERY iac:ansible" --single "Nome Máquina" --size 100 | sed "s/.com/.pt/")

for server in $SERVERS; do
   ssh -F ~/.ssh/config_cron "root@$server" "printf \"%-50s : %s\" \"$server\" \"\$(duplicity-status 2>/dev/null| grep -F \"Chain end time\"| tail -1)\" " | grep -v "$(LC_ALL=us date +"%b %e")"
done
