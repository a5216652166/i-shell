#!/bin/sh

echo "===========install mysql-proxy=========="

rpm -Uvh xinetd-2.3.14-16.el5.x86_64.rpm

\cp ./mysqlchk_slave /etc/xinetd.d/
\cp ./mysqlchk_slave.sh /opt/
chmod 777 /opt/mysqlchk_slave.sh

grep -q "mysqlchk_slave*" /etc/services &&{
	echo "mysqlchk_slave has been registed."
}||{
	echo "mysqlchk_slave        3308/tcp                        # mysqlchk_slave" >>/etc/services
}

chkconfig xinetd on
service xinetd start

echo "===================ok==================" 
