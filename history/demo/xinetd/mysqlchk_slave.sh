#!/bin/bash 
# 
# /opt/mysqlchk_slave.sh
# 
# 如果mysql服务正常且复制进程已启动，则返回http成功
# return: 
# 
# "HTTP/1.x 200 OK\r" (if mysql is running smoothly) 
# 
# – 否则 – 
# 
# "HTTP/1.x 503 Internal Server Error\r" (else) 
# 

MYSQL_HOST="127.0.0.1"
MYSQL_PORT="3306"
MYSQL_USERNAME="admin"
MYSQL_PASSWORD="itserver"


ERROR_MSG=`mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -e "show databases;" 2>/dev/null`
# 
# Check the output. If it is not empty then everything is fine and we return 
# something. Else, we just do not return anything. 
# 
if [ "$ERROR_MSG" != "" ] 
then 
        # 检查Slave_IO_Running和Slave_SQL_Running进程是否为Yes
	mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -e "show full processlist;" >/tmp/processlist.txt
	mysql -h$MYSQL_HOST -P$MYSQL_PORT -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -e "show slave status\G;" >/tmp/rep.txt
	iostat=`grep "Slave_IO_Running" /tmp/rep.txt  |awk '{print $2}'`
	sqlstat=`grep "Slave_SQL_Running" /tmp/rep.txt |awk '{print $2}'`
	result=$(cat /tmp/processlist.txt|wc -l)
	
	# if [ "$result" -lt "20" ] && [ "$iostat" = "Yes" ] && [ "$sqlstat" = "Yes" ];
	if [ "$iostat" = "Yes" ] && [ "$sqlstat" = "Yes" ];
	then
		# mysql is fine, return http 200
		/bin/echo -e "HTTP/1.1 200 OK\r\n"
		
	else
		# mysql is down, return http 503
		/bin/echo -e "HTTP/1.1 503 Service Unavailable\r\n"
		
	fi
else 
        # mysql is down, return http 503 
        /bin/echo -e "HTTP/1.1 503 Service Unavailable\r\n" 
fi