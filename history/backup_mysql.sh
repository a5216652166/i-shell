#!/bin/sh 
. /etc/profile

password=itserver
name=`date '+%Y%m%d%H%M%S'`
mysqldump -uroot -p${password} --all-databases |gzip>/home/backup/mysql/db_$name.sql.gz 
#Delete backup files some days ago.
find /home/backup/mysql/db*.gz -mtime +30 -exec rm {} \;