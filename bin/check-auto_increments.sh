#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

SERVERS=$(searcher --server dogfooding.cultofbits.com --def Máquina --query "funcionamento produção acessível:sim" --single "Nome Máquina" --size 100)

for server in $SERVERS; do
   CMD="mysql --skip-column-names -uroot 2>/dev/null"
   ssh "$server" -C "$CMD" < "$SCRIPT_DIR/check_auto_increments_all.sql" \
      | awk "{printf \"%-35s: %s\n\", \"$server\", \$0}"
done
