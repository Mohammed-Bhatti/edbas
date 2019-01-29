#!/bin/bash

rm -rf $PGDATA
pg_basebackup -R -D $PGDATA --host=$1 --port=5444 --username=repuser --password
cp -rfp /data/edb/as9.6/temp/* $PGDATA
