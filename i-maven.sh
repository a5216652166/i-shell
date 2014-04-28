#!/bin/sh
#
#
#安装Maven

echo "正在安装Maven..."
if [ ! -f "/download/apache-maven-3.2.1-bin.tar.gz" ]; then
    wget -P /download  "http://mirror.bit.edu.cn/apache/maven/maven-3/3.2.1/binaries/apache-maven-3.2.1-bin.tar.gz"
fi
tar zxf /download/apache-maven-3.2.1-bin.tar.gz -C /opt
grep -q "export M2_HOME" /etc/profile &&{
	echo "Maven config exits."
}||{
	echo "#AUTO_GEN_Maven" >>/etc/profile
	echo "export M2_HOME=/opt/apache-maven-3.2.1 #AUTO_GEN_Maven" >>/etc/profile
	echo "export PATH=\$PATH:\$M2_HOME/bin #AUTO_GEN_Maven" >>/etc/profile
}
sleep 1
. /etc/profile
mvn -version
echo "===========Maven ok==========="