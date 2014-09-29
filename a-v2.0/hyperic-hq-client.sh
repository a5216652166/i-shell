#!/bin/sh
#

set -e
source ./config.conf
cur_dir=$(cd "$(dirname "$0")"; pwd)

#http://sourceforge.net/projects/hyperic-hq/files/
#PostgreSQL±È½Ïhttp://bbs.chinaunix.net/thread-1688208-1-1.html
#http://www.php100.com/manual/PostgreSQL8/
#http://www.postgresql.org/
#http://www.postgresql.org/download/linux/redhat/#yum
#yum install http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-1.noarch.rpm -y
yum install postgresql-server -y
service postgresql initdb
chkconfig postgresql on
cd $cur_dir

