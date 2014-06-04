#!/bin/sh
#
#
#初始化

# 参考：http://lesca.me/archives/iptables-examples.html , http://www.badnotes.com/2013/10/03/iptables/

# 清除规则
#iptables -F

#设置默认拒绝
#iptables -P INPUT DROP
#iptables -P FORWARD DROP
#iptables -P OUTPUT ACCEPT

# 允许SSH连接请求
#iptables -A INPUT -i eth1 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -o eth1 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT

# 允许来自外部的ping测试
#iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
#iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT

# 允许从本机ping外部主机
#iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
#iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

# 允许环回(loopback)访问
#iptables -A INPUT -i lo -j ACCEPT
#iptables -A OUTPUT -o lo -j ACCEPT

# 允许HTTP连接：80端口
#iptables -A INPUT -i eth1 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -o eth1 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT

# 允许HTTPS连接：443端口
#iptables -A INPUT -i eth1 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -o eth1 -p tcp --sport 443 -m state --state ESTABLISHED -j ACCEPT

# 允许出站DNS连接
#iptables -A OUTPUT -p udp -o eth1 --dport 53 -j ACCEPT
#iptables -A INPUT -p udp -i eth1 --sport 53 -j ACCEPT

#service iptables save
#service iptables restart
#chkconfig iptables on

service iptables stop
iptables -F
iptables -A INPUT -i eth1 -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -i eth1 -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -i eth1 -p tcp --dport 443 -j ACCEPT
# DNS
iptables -A INPUT -i eth1 -p tcp --dport 53 -j ACCEPT
# Ping
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
# 允许允许本机主动向外发出任何请求
iptables -A OUTPUT -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
# 拒绝网卡1上除已有开放规则以外的所有其它请求
iptables -A INPUT -i eth1 -j REJECT
iptables -A FORWARD -i eth1 -j REJECT
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