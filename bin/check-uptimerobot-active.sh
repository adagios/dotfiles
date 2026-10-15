#!/bin/bash

SERVERS=$(searcher --server dogfooding.cultofbits.com --def Máquina --query "estado:funcionamento hosting:linode função:(produção OR qualidade)" --single "Nome Máquina" --size 100)

for server in $SERVERS; do
   if [[ $(cob uptimerobot -l -s "${server/.cultofbits.com/}" | jq 'select(.status == "UP") | .id' | wc -l ) -lt 2 ]]; then
      echo "$server missing active uptimerobot monitors"
   fi
done
