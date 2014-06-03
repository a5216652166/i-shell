#!/bin/sh
#
# 
# 卸载MySQL
echo "正在卸载MySQL..."
installPath=/opt/mysql-5.6.19-linux-glibc2.5-x86_64
serviceName=mysqld
service ${serviceName} stop
chkconfig --del ${serviceName}

sed -i "/AUTO_GEN_MYSQL/d" /etc/profile
sleep 1
. /etc/profile

rm -rf /etc/init.d/${serviceName}
rm -rf ${installPath}
echo "===========卸载MySQL ok===========" 