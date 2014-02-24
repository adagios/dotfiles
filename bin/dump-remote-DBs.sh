#!/bin/bash

HOST=$1
BDs=$2
DEST=$3


IFS=: read -a arrBDs <<< "$BDs"

echo "Backing up BDs [${arrBDs[@]}] to $DEST"

for bd in ${arrBDs[@]}
do
   echo "backing up $bd"
   ssh -C $HOST mysqldump -u root --hex-blob $bd | gzip > $DEST/$bd.sql.gz
done
