#!/bin/bash

SERVERS=$(searcher --server dogfooding.cultofbits.com --def Máquina --query "estado:funcionamento hosting:linode função:(produção OR qualidade)" --single "Nome Máquina" --size 100)

for server in $SERVERS; do
   if ! cob uptimerobot -l -s "${server/.cultofbits.com/}" | jq '.monitors | map(select(.status == 2)) | length == 2' --exit-status >/dev/null; then
      echo "$server missing active uptimerobot monitors"
   fi
done
