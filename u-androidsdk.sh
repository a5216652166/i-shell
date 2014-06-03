#!/bin/sh
#
# 
# 
echo "正在卸载Android SDK..."

sed -i "/AUTO_GEN_ANDROID/d" /etc/profile 
sleep 1
. /etc/profile
rm -rf /opt/adt-bundle-linux-x86_64-20140321

echo "===========卸载Android SDK ok===========" 