#!/bin/bash

HOST=$1
BDs=$2
SRCDIR=$3


IFS=: read -a arrBDs <<< "$BDs"

echo "Restoring BDs [${arrBDs[@]}] from $SRCDIR"

for bd in ${arrBDs[@]}
do
   echo "restoring $bd"
   gzcat $SRCDIR/$bd.sql.gz | ssh -C $HOST mysql -u root $bd
done
