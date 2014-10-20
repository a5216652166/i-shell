#!/bin/sh
#
#
#

#eth0(内网)若需限制某网卡的端口，请参考以下语句，,eth1(电信)，eth2(连通)只开放80端口，
#iptables -F
#iptables -A INPUT -i eth1 -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -i eth1 -p tcp -j REJECT
#iptables -A INPUT -i eth2 -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -i eth2 -p tcp -j REJECT
#service iptables save
#service iptables restart

#####初始化
cur_dir=$(cd "$(dirname "$0")"; pwd)
if [ ! -f "/etc/profile.old" ]; then
    \cp -a  /etc/profile /etc/profile.bak
fi
if [ ! -f "/etc/rc.d/rc.local" ]; then
    \cp -a  /etc/profile /etc/rc.d/rc.local.bak
fi
if [ ! -f "/root/.bash_profile" ]; then
    \cp -a  /etc/profile /root/.bash_profile.bak
fi
chkconfig iptables off
service iptables stop
yum -y remove java java-1.4.2-gcj-compat-1.4.2.0-40jpp.115
grep -q "ulimit -n 102400" /etc/rc.d/rc.local &&{
	echo "ulimit has been setted."
}||{
	echo "ulimit -n 102400" >> /etc/rc.d/rc.local
}
chmod +x /etc/rc.d/rc.local
grep -q "ulimit -n 102400" /root/.bash_profile &&{
	echo "ulimit has been setted."
}||{
	echo "ulimit -n 102400" >> /root/.bash_profile
}
chmod +x /root/.bash_profile

#####安装工具
yum install wget git  -y


#####安装JDK
if [ ! -f "/download/jdk-7u15-linux-x64.tar.gz" ]; then
    wget -P /download --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" "http://download.oracle.com/otn-pub/java/jdk/7u15-b03/jdk-7u15-linux-x64.tar.gz"
fi
if [ ! -d "/opt/" ]; then
    mkdir -p /opt
fi
echo "正在安装JDK..."
tar zxf /download/jdk-7u15-linux-x64.tar.gz -C /opt
grep -q "export JAVA_HOME" /etc/profile &&{
	echo "JDK config exits."
}||{
	echo "" >>/etc/profile
	echo "export JAVA_HOME=/opt/jdk1.7.0_15 #AUTO_GEN_JDK" >>/etc/profile
	echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar #AUTO_GEN_JDK" >>/etc/profile
	echo "export PATH=\$PATH:\$JAVA_HOME/bin #AUTO_GEN_JDK" >>/etc/profile
	echo "export JRE_HOME=\$JAVA_HOME/jre #AUTO_GEN_JDK" >>/etc/profile
}
sleep 1
. /etc/profile

#####安装Maven
if [ ! -f "/download/apache-maven-3.2.1-bin.tar.gz" ]; then
    wget -P /download  "http://mirror.bit.edu.cn/apache/maven/maven-3/3.2.1/binaries/apache-maven-3.2.1-bin.tar.gz"
fi
echo "正在安装Maven..."
tar zxf /download/apache-maven-3.2.1-bin.tar.gz -C /opt
grep -q "export M2_HOME" /etc/profile &&{
	echo "Maven config exits."
}||{
	echo "" >>/etc/profile
	echo "export M2_HOME=/opt/apache-maven-3.2.1 #AUTO_GEN_Maven" >>/etc/profile
	echo "export PATH=\$PATH:\$M2_HOME/bin #AUTO_GEN_Maven" >>/etc/profile
}
sleep 1
. /etc/profile


#####安装Tomcat
if [ ! -f "/download/apache-tomcat-7.0.52.tar.gz" ]; then
    wget -P /download  "http://mirror.bit.edu.cn/apache/tomcat/tomcat-7/v7.0.52/bin/apache-tomcat-7.0.52.tar.gz"
fi
echo "正在安装Tomcat..."
#tar zxf /download/apache-tomcat-7.0.52.tar.gz -C /opt

#catalina_home=/opt/apache-tomcat-7.0.52

#rm -rf ${catalina_home}/webapps/ROOT/*
#rm -rf ${catalina_home}/webapps/docs
#rm -rf ${catalina_home}/webapps/examples

#sed -i  "/stringKey/a\ $replace4" $path
#sed -i  "/stringKey.*/a\ $replace4" $path

#####安装Jetty
if [ ! -f "/download/jetty-distribution-9.1.2.v20140210.tar.gz" ]; then
    wget -P /download  "http://eclipse.org/downloads/download.php?file=/jetty/stable-9/dist/jetty-distribution-9.1.2.v20140210.tar.gz"
fi
#sudo wget  -O jetty.tar.gz
#tar -xf jetty.tar.gz

#rm -rf jetty.tar.gz
#mv jetty-* jetty

#sudo /usr/sbin/useradd jetty
#sudo mv jetty /srv/

#sudo chown -R jetty:jetty /srv/jetty
#sudo ln -s /srv/jetty/bin/jetty.sh /etc/init.d/jetty
#sudo /sbin/chkconfig --add jetty
#sudo /sbin/chkconfig jetty on

#sudo vi /etc/init.d/jetty

#add after comments
#JETTY_HOME=/srv/jetty
#JETTY_USER=jetty
#JETTY_PORT=8080
#JETTY_LOGS=/srv/jetty/logs/
#sudo mkdir -p /srv/logs
#sudo chown -R jetty:jetty /srv/logs

#sudo /sbin/service jetty start
#curl http://localhost:8080
#sudo /sbin/iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080

#####安装Nginx
#yum -y install nginx
#chkconfig nginx on

#####安装MySQL
if [ ! -f "/download/mysql-5.6.16-linux-glibc2.5-x86_64.tar.gz" ]; then
    wget -P /download  "http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.16-linux-glibc2.5-x86_64.tar.gz"
fi
echo "正在安装Mysql..."
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
	echo "Maven config exits."
}||{
	echo "" >>/etc/profile
	echo "export PATH=\$PATH:/opt/mysql-5.6.16-linux-glibc2.5-x86_64/bin #AUTO_GEN_MYSQL" >>/etc/profile
}
sleep 1
. /etc/profile

${installPath}/bin/mysqladmin -S${sockFile} -uroot password "${password}"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password} -e "GRANT all on *.* to '$remoteUser'@'%' identified by \"${password}\";"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password} -e "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%' identified by 'repl';"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password} -e "GRANT Select ON *.* TO 'readonly'@'localhost' identified by 'readonly';"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password}  -e "delete from mysql.user where user='';"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password}  -e "delete from mysql.user where password='';"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password}  -e "flush privileges;"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password}  -e "drop database if exists ipet;create database ipet;"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password} -e "INSTALL PLUGIN rpl_semi_sync_master SONAME 'semisync_master.so';"
${installPath}/bin/mysql -S${sockFile} -uroot -p${password} -e "INSTALL PLUGIN rpl_semi_sync_slave SONAME 'semisync_slave.so';"
service ${serviceName} restart

echo "===========install ok==========="