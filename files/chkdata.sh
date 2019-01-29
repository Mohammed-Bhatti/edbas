#!/bin/bash

PGDATA=/var/data/edb/as9.6/data
CURRENT=$(df ${PGDATA?} | grep / | awk '{ print $5}' | sed 's/%//g')
THRESHOLD=75
HOSTNAME=`/bin/hostname`

if [ "$CURRENT" -gt "$THRESHOLD" ]
then
/bin/mutt -s "Disk Space Alert - $HOSTNAME" mohammed.k.bhatti.ctr@mail.mil<<EOF
The data directory volume is almost full.  Used:  $CURRENT
EOF
fi
