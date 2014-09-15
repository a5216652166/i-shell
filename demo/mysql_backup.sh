#!/bin/sh 

name=$(date +%Y-%m-%d) 
/usr/local/mysql/bin/mysqldump -uroot -pitserver --all-databases |gzip>/data/db_$name.sql.gz 
#Delete backup files some days ago.
find /data/db*.gz -mtime +14 -exec rm {} \;
