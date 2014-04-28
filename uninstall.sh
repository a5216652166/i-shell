#!/bin/sh
#
# 
# 


yum -y remove wget git

sed -i "/ulimit -n 102400/d" /etc/rc.d/rc.local 
chmod +x /etc/rc.d/rc.local

sed -i "/ulimit -n 102400/d" /root/.bash_profile 
chmod +x /root/.bash_profile

#####卸载JDK
sed -i "/AUTO_GEN_JDK/d" /etc/profile 
sleep 1
. /etc/profile
rm -rf /opt/jdk1.7.0_15

#####卸载Maven
sed -i "/AUTO_GEN_Maven/d" /etc/profile 
sleep 1
. /etc/profile
rm -rf /opt/apache-maven-3.2.1

#####卸载MySQL
installPath=/opt/mysql-5.6.16-linux-glibc2.5-x86_64
serviceName=mysqld
service ${serviceName} stop
chkconfig --del ${serviceName}
rm -rf /etc/init.d/${serviceName}
rm -rf ${installPath}
sed "/AUTO_GEN_MYSQL/d" /etc/profile
sleep 1
. /etc/profile
echo "===========clear ok===========" 