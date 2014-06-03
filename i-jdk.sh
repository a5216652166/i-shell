#!/bin/sh
#
#
#安装JDK

echo "正在安装JDK..."
##参考https://ivan-site.com/2012/05/download-oracle-java-jre-jdk-using-a-script/
if [ ! -f "/download/jdk-7u51-linux-x64.tar.gz" ]; then
    wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.tar.gz"
fi
if [ ! -d "/opt/" ]; then
    mkdir -p /opt
fi
tar zxf /download/jdk-7u51-linux-x64.tar.gz -C /opt
grep -q "export JAVA_HOME" /etc/profile &&{
	echo "JDK config exits."
}||{
	echo "#AUTO_GEN_JDK" >>/etc/profile
	echo "export JAVA_HOME=/opt/jdk1.7.0_51 #AUTO_GEN_JDK" >>/etc/profile
	echo "export CLASSPATH=.:\$JAVA_HOME/lib:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar #AUTO_GEN_JDK" >>/etc/profile
	echo "export PATH=\$PATH:\$JAVA_HOME/bin #AUTO_GEN_JDK" >>/etc/profile
	echo "export JRE_HOME=\$JAVA_HOME/jre #AUTO_GEN_JDK" >>/etc/profile
}
sleep 1
. /etc/profile

java -version
echo "===========JDK ok==========="