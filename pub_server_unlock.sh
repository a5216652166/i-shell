#!/bin/sh
#
#
#

lock_file=/home/backup/server/pub_server.lock

if [ -f "$lock_file" ]; then
    rm -rf $lock_file
fi

echo "===========commit(unlock) ok==========="