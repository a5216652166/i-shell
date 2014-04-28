#!/bin/sh
#
# 
# 
echo "正在卸载Ant..."


sed -i "/AUTO_GEN_Ant/d" /etc/profile 
sleep 1
. /etc/profile
rm -rf /opt/apache-ant-1.9.3


echo "===========卸载Ant ok===========" 