#!/bin/sh
#
# 
# 反初始化
echo "正在反初始化..."

yum -y remove wget git ntp zip unzip

sed -i "/ulimit -n 102400/d" /etc/rc.d/rc.local 
chmod +x /etc/rc.d/rc.local

sed -i "/ulimit -n 102400/d" /root/.bash_profile 
chmod +x /root/.bash_profile

echo "===========uninit ok===========" 