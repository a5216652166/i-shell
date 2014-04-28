#!/bin/sh
#
#
#安装Ant

echo "正在安装Ant..."
if [ ! -f "/download/apache-ant-1.9.3-bin.tar.gz" ]; then
    wget -P /download  "http://apache.fayea.com/apache-mirror//ant/binaries/apache-ant-1.9.3-bin.tar.gz"
fi
tar zxf /download/apache-ant-1.9.3-bin.tar.gz -C /opt

grep -q "export AUTO_GEN_Ant" /etc/profile &&{
	echo "Ant config exits."
}||{
	echo "#AUTO_GEN_Ant" >>/etc/profile
	echo "export ANT_HOME=/opt/apache-ant-1.9.3 #AUTO_GEN_Ant" >>/etc/profile
	echo "export PATH=\$PATH:\$ANT_HOME/bin #AUTO_GEN_Ant" >>/etc/profile
}
sleep 1
. /etc/profile
ant -version
echo "===========Ant ok==========="