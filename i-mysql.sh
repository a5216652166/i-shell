#!/bin/sh
#
#
#安装MySQL

echo "正在安装Mysql..."
if [ ! -f "/download/mysql-5.6.16-linux-glibc2.5-x86_64.tar.gz" ]; then
    wget -P /download  "http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.16-linux-glibc2.5-x86_64.tar.gz"
fi
tar zxf /download/mysql-5.6.16-linux-glibc2.5-x86_64.tar.gz -C /opt

installPath=/opt/mysql-5.6.16-linux-glibc2.5-x86_64
dataPath=/home/data/mysql
sockFile=/tmp/mysql.sock

systemGroupName=mysql
systemUserName=mysql
dataBackPath=/home/backup/mysql
password=itserver
port=3306
serviceName=mysqld
remoteUser=admin

mkdir -p ${installPath}
groupadd ${systemGroupName}
useradd -r -g ${systemGroupName} ${systemUserName}


mkdir -p ${dataPath}
mkdir -p ${dataBackPath}
chown -R ${systemUserName} ${installPath}
chgrp -R ${systemGroupName} ${installPath}
chown -R ${systemUserName} ${dataPath}
chgrp -R ${systemGroupName} ${dataPath}
chown -R ${systemUserName} ${dataBackPath}
chgrp -R ${systemGroupName} ${dataBackPath}

${installPath}/scripts/mysql_install_db --basedir=${installPath} --datadir=${dataPath} --user=${systemUserName}
#chown -R root $installPath
#chown -R $systemUserName $dataPath

\cp -a ./my.cnf /etc/my.cnf
\cp -a ${installPath}/support-files/mysql.server ./mysql.server.tmp
sed -i "/^basedir=/c\basedir=$installPath" ./mysql.server.tmp
sed -i "/^datadir=/c\datadir=$dataPath" ./mysql.server.tmp
\cp ./mysql.server.tmp /etc/init.d/${serviceName}
chmod +x /etc/init.d/${serviceName}
chkconfig --add ${serviceName}
chkconfig ${serviceName} on
service ${serviceName} start

grep -q "AUTO_GEN_MYSQL" /etc/profile &&{
	echo "Mysql config exits."
}||{
	echo "#AUTO_GEN_MYSQL" >>/etc/profile
	echo "export PATH=\$PATH:/opt/mysql-5.6.16-linux-glibc2.5-x86_64/bin #AUTO_GEN_MYSQL" >>/etc/profile
}
sleep 1
. /etc/profile

sleep 5

${installPath}/bin/mysqladmin -S${sockFile} -uroot password "${password}"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password} -e "GRANT all on *.* to '$remoteUser'@'%' identified by \"${password}\";"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password} -e "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' identified by 'repl';"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password} -e "GRANT Select ON *.* TO 'readonly'@'localhost' identified by 'readonly';"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password}  -e "delete from mysql.user where user='';"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password}  -e "delete from mysql.user where password='';"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password}  -e "flush privileges;"
#${installPath}/bin/mysql -S${sockFile} -uroot -p${password}  -e "drop database if exists ipet;create database ipet;"
#${installPath}/bin/mysql -S${sockFile} -uroot -p${password} -e "INSTALL PLUGIN rpl_semi_sync_master SONAME 'semisync_master.so';"
#${installPath}/bin/mysql -S${sockFile} -uroot -p${password} -e "INSTALL PLUGIN rpl_semi_sync_slave SONAME 'semisync_slave.so';"

#service ${serviceName} restart

echo "===========MySQL ok==========="