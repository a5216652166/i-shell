#!/bin/sh
#
# 
# 
echo "正在卸载JDK..."

sed -i "/AUTO_GEN_JDK/d" /etc/profile 
sleep 1
. /etc/profile
rm -rf /opt/jdk1.7.0_15

echo "===========卸载JDK ok===========" 