#!/bin/bash 
# 
# /usr/sbin/mysqlchk_master.sh
# 
# This script checks if a mysql server is healthy running on localhost. It will 
# return: 
# 
# "HTTP/1.x 200 OK\r" (if mysql is running smoothly) 
# 
# – OR – 
# 
# "HTTP/1.x 500 Internal Server Error\r" (else) 
#

MYSQL_USERNAME="root" 
MYSQL_PASSWORD="itserver"
# 
# We perform a simple query that should return a few results 
ERROR_MSG=`mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -e "show databases;" 2>/dev/null`
# 
# Check the output. If it is not empty then everything is fine and we return 
# something. Else, we just do not return anything. 
# 
if [ "$ERROR_MSG" != "" ] 
then 
    # mysql is fine, return http 200 
    echo -e "200" 
else 
    # mysql is down, return http 503 
    echo -e "503" 
fi