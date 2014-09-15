#!/bin/bash 
# 
# /opt/mysqlchk.sh
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
MYSQL_HOST="127.0.0.1" 
MYSQL_PORT="3306" 
MYSQL_USERNAME="admin" 
MYSQL_PASSWORD="itserver" 
# 
# We perform a simple query that should return a few results 
ERROR_MSG=`mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -e "show databases;" 2>/dev/null`
#ERROR_MSG=`mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -e "show databases;"`
# 
# Check the output. If it is not empty then everything is fine and we return 
# something. Else, we just do not return anything. 
# 
if [ "$ERROR_MSG" != "" ] 
then 
        # mysql is fine, return http 200 
        /bin/echo -e "HTTP/1.1 200 OK\r\n" 
        #/bin/echo -e "Content-Type: Content-Type: text/plain\r\n" 
        #/bin/echo -e "\r\n" 
        #/bin/echo -e "MySQL is running.\r\n" 
        #/bin/echo -e "\r\n" 
else 
        # mysql is down, return http 503 
        /bin/echo -e "HTTP/1.1 503 Service Unavailable\r\n" 
        #/bin/echo -e "Content-Type: Content-Type: text/plain\r\n" 
        #/bin/echo -e "\r\n" 
        #/bin/echo -e "MySQL is *down*.\r\n" 
        #/bin/echo -e "\r\n" 
fi