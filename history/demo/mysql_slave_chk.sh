#!/bin/bash 
# 
# /opt/mysqlchk_slave.sh
# 
# This script checks if a mysql server is healthy running on localhost. It will 
# return: 
# 
# "HTTP/1.x 200 OK\r" (if mysql is running smoothly) 
# 
# – OR – 
# 
# "HTTP/1.x 503 Internal Server Error\r" (else) 
# 

MYSQL_USERNAME="root"
MYSQL_PASSWORD="itserver"

ERROR_MSG=`mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -e "show databases;" 2>/dev/null`
# 
# Check the output. If it is not empty then everything is fine and we return 
# something. Else, we just do not return anything. 
# 
if [ "$ERROR_MSG" != "" ] 
then 
    mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -e "show full processlist;" >/tmp/processlist.txt
    mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -e "show slave status\G;" >/tmp/rep.txt
    iostat=`grep "Slave_IO_Running" /tmp/rep.txt  |awk '{print $2}'`
    sqlstat=`grep "Slave_SQL_Running" /tmp/rep.txt |awk '{print $2}'`
    result=$(cat /tmp/processlist.txt|wc -l)
	
    # if [ "$result" -lt "20" ] && [ "$iostat" = "Yes" ] && [ "$sqlstat" = "Yes" ];
    if [ "$iostat" = "Yes" ] && [ "$sqlstat" = "Yes" ];
    then
	# mysql is fine, return http 200
	echo -e "200"	
    else
	# mysql is down, return http 503
	echo -e "503"
		
    fi
else 
    # mysql is down, return http 503 
    /bin/echo -e "503" 
fi