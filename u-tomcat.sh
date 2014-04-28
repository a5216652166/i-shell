#!/bin/sh
#
# 
# 卸载Tomcat
echo "正在卸载Tomcat"

installPath=/opt/apache-tomcat-7.0.52
serviceName=tomcat

service ${serviceName} stop
chkconfig --del ${serviceName}

rm -rf /etc/init.d/${serviceName}
rm -rf ${installPath}

echo "===========卸载Tomcat ok===========" 