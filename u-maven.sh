#!/bin/sh
#
# 
# 
echo "正在卸载Maven..."


#####卸载Maven
sed -i "/AUTO_GEN_Maven/d" /etc/profile 
sleep 1
. /etc/profile
rm -rf /opt/apache-maven-3.2.1


echo "===========卸载Maven ok===========" 