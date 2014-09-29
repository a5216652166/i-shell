#!/bin/sh
#

set -e
source ./config.conf
cur_dir=$(cd "$(dirname "$0")"; pwd)

wget -P /tmp http://downloads.sourceforge.net/project/webadmin/webmin/1.700/webmin-1.700-1.noarch.rpm
rpm -ivh /tmp/webmin-1.700-1.noarch.rpm
rm -rf /tmp/webmin-1.700-1.noarch.rpm
# /usr/libexec/webmin
# http://localhost:10000/


cd $cur_dir

