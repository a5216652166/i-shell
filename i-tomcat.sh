#!/bin/sh
#
#
#安装Tomcat
#JAVA_OPTS="-server -Xms2048m -Xmx2048m -XX:MaxNewSize=512m -XX:PermSize=128M -XX:MaxPermSize=512m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/usr/local/moooo/logs/ -Dfile.encoding=UTF-8"
#sed -i  "/stringKey/a\ $replace4" /opt/apache-tomcat-7.0.54/bin/catalina.sh
#catalina_home=/opt/apache-tomcat-7.0.54

echo "正在安装Tomcat..."
if [ ! -f "/download/apache-tomcat-7.0.54.tar.gz" ]; then
    wget -P /download  "http://apache.dataguru.cn/tomcat/tomcat-7/v7.0.54/bin/apache-tomcat-7.0.54.tar.gz"
fi
tar zxf /download/apache-tomcat-7.0.54.tar.gz -C /opt

#sed -i "1 a # chkconfig: 2345 64 36" /opt/apache-tomcat-7.0.54/bin/catalina.sh
#sed -i  "/stringKey/a\ $replace4" $path

CATALINA_HOME=/opt/apache-tomcat-7.0.54

\cp -a ./tomcat /etc/init.d/tomcat
sed -i "/^CATALINA_HOME=/c\CATALINA_HOME=$CATALINA_HOME" /etc/init.d/tomcat
chmod +x /etc/init.d/tomcat

#sed -i "1 a # chkconfig: 3 99 99" /opt/apache-tomcat-7.0.54/bin/catalina.sh
#sed -i "2 a # description: Tomcat 7 webserver" /opt/apache-tomcat-7.0.54/bin/catalina.sh
#sed -i '4 a JAVA_OPTS="-server -Xms2048m -Xmx2048m -XX:MaxNewSize=512m -XX:PermSize=128M -XX:MaxPermSize=512m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/opt/apache-tomcat-7.0.54/logs/"' /opt/apache-tomcat-7.0.54/bin/catalina.sh
#sed -i '5 a CATALINA_PID="/opt/apache-tomcat-7.0.54/tomcat.pid"' /opt/apache-tomcat-7.0.54/bin/catalina.sh

chkconfig --add tomcat
chkconfig tomcat on


sed -i '/<Context>/c\<Context allowLinking="true">' $CATALINA_HOME/conf/context.xml
sed -i '/<Connector port="8080"/a\ enableLookups="false" ' $CATALINA_HOME/conf/server.xml
sed -i '/<Connector port="8080"/a\ maxThreads="1024" ' $CATALINA_HOME/conf/server.xml
sed -i '/<Connector port="8080"/a\ URIEncoding="UTF-8" ' $CATALINA_HOME/conf/server.xml
sed -i '/<Connector port="8080" protocol="HTTP\/1.1"/c\<Connector port="80" protocol="HTTP\/1.1"' $CATALINA_HOME/conf/server.xml
sed -i '/unpackWARs="true" autoDeploy="true"/c\unpackWARs="false" autoDeploy="false">' $CATALINA_HOME/conf/server.xml


rm -rf ${CATALINA_HOME}/webapps/ROOT/*
echo "" > ${CATALINA_HOME}/webapps/ROOT/health.html
echo "OK" > ${CATALINA_HOME}/webapps/ROOT/index.html
rm -rf ${CATALINA_HOME}/webapps/docs
rm -rf ${CATALINA_HOME}/webapps/examples


service tomcat start
echo "===========Tomcat ok==========="