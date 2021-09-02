#!/bin/bash

SERVERS=$(./searcher --server dogfooding.cultofbits.com --def Máquina --query "funcionamento produção acessível:sim" --single "Nome Máquina" --size 100)

echo "# heapdumps"
for server in $SERVERS; do
   ssh "cob@$server"\
      -C "find /var/log -name '*.hprof*' -printf '$server: [%CY-%Cm-%Cd %CH:%CM] %k Kb %p\\n' 2>/dev/null | egrep '.*'"
done
