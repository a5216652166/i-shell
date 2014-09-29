#!/bin/sh
#

set -e
source ./config.conf
cur_dir=$(cd "$(dirname "$0")"; pwd)

#http://sourceforge.net/projects/hyperic-hq/files/Hyperic%205.8.2/
#http://sourceforge.net/projects/hyperichq-zh-cn/

function downloadHyperic(){
  mkdir -p $GLOBAL_DOWNLOAD_DIR
  if [ ! -f "$GLOBAL_DOWNLOAD_DIR/hyperic-hq-installer-noJRE-zip-5.8.2.1.zip" ]; then
    set +e
    wget -P $GLOBAL_DOWNLOAD_DIR  "http://downloads.sourceforge.net/project/hyperichq-zh-cn/hq-5.8.2.1-simplified-chinese/hyperic-hq-installer-noJRE-zip-5.8.2.1.zip"
    if [ "$?" -eq "1" ]; then
      rm -rf $GLOBAL_DOWNLOAD_DIR/hyperic-hq-installer-noJRE-zip-5.8.2.1.zip
    fi
    set -e
  fi
}

function installHyperic(){
  unzip -oq $GLOBAL_DOWNLOAD_DIR/hyperic-hq-installer-noJRE-zip-5.8.2.1.zip -d /tmp
  cd /tmp/hyperic-hq-installer-5.8.2.1
  ./setup.sh
  rm -rf /tmp/hyperic-hq-installer-5.8.2.1
}

#/var/lib/pgsql/9.3/data/postgresql.conf
#/var/lib/pgsql/9.3
#http://www.postgresql.org/download/linux/redhat/#yum
function installPostgresql93(){
  yum install http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-1.noarch.rpm -y
  yum install postgresql93-server postgresql93-contrib -y
  service postgresql-9.3 initdb
  chkconfig postgresql-9.3 on
  service postgresql-9.3 restart
}

function installPostgresql(){
  yum install postgresql-server postgresql-contrib -y
  service postgresql initdb
  chkconfig postgresql on
  service postgresql restart
}


installPostgresql93
downloadHyperic
installHyperic




cd $cur_dir

