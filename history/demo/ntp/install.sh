#!/bin/sh
#
# 使用本脚本需要将安装文件复制到/soft目录
# 
# 参考资料：
# http://apps.hi.baidu.com/share/detail/180324
# 错误解决参考：
# http://bbs.chinaunix.net/thread-1977474-1-1.html
# xiaojinghai@kedacom

echo "=================Copy confige files..================" 

\cp -av ./ntp.conf /etc/ntp.conf
\cp -av ./ntpd /etc/sysconfig/ntpd

sudo chkconfig --add ntpd
sudo chkconfig --level 345 ntpd on

service ntpd restart
echo "=================ok================" 