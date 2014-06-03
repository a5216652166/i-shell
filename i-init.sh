#!/bin/sh
#
#
#初始化

#eth0(内网)若需限制某网卡的端口，请参考以下语句，,eth1(电信)，eth2(连通)只开放80端口，
iptables -F
iptables -A INPUT -i eth1 -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -i eth1 -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -i eth1 -p tcp -j REJECT
#iptables -A INPUT -i eth2 -p tcp --dport 80 -j ACCEPT
#iptables -A INPUT -i eth2 -p tcp -j REJECT
service iptables save
service iptables restart
chkconfig iptables on


echo "正在初始化..."
cur_dir=$(cd "$(dirname "$0")"; pwd)
if [ ! -f "/etc/profile.old" ]; then
    \cp -a  /etc/profile /etc/profile.bak
fi
if [ ! -f "/etc/rc.d/rc.local" ]; then
    \cp -a  /etc/profile /etc/rc.d/rc.local.bak
fi
if [ ! -f "/root/.bash_profile" ]; then
    \cp -a  /etc/profile /root/.bash_profile.bak
fi
chkconfig iptables off
service iptables stop
yum -y remove java java-1.4.2-gcj-compat-1.4.2.0-40jpp.115
grep -q "ulimit -n 102400" /etc/rc.d/rc.local &&{
	echo "ulimit has been setted."
}||{
	echo "ulimit -n 102400" >> /etc/rc.d/rc.local
}
chmod +x /etc/rc.d/rc.local
grep -q "ulimit -n 102400" /root/.bash_profile &&{
	echo "ulimit has been setted."
}||{
	echo "ulimit -n 102400" >> /root/.bash_profile
}
chmod +x /root/.bash_profile

#####安装工具

yum install wget git ntp zip unzip -y


grep -q "SYNC_HWCLOCK=yes" /etc/sysconfig/ntpd &&{
	echo "ntpd has been setted."
}||{
	echo "SYNC_HWCLOCK=yes" >> /etc/sysconfig/ntpd
}

chkconfig ntpd on
service ntpd start
sleep 3
ntpstat

echo "===========init ok==========="