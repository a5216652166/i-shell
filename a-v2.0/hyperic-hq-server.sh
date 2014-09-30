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
  mkdir -p /home/hyperic
  unzip -oq $GLOBAL_DOWNLOAD_DIR/hyperic-hq-installer-noJRE-zip-5.8.2.1.zip -d /tmp
  cd /tmp/hyperic-hq-installer-5.8.2.1
  groupadd hq 
  useradd -g hq hq
  chown -R hq /home/hyperic
  chgrp -R hq /home/hyperic
  chown -R hq /tmp/hyperic-hq-installer-5.8.2.1
  chgrp -R hq /tmp/hyperic-hq-installer-5.8.2.1
  su hq
  #su -c /tmp/hyperic-hq-installer-5.8.2.1/setup.sh hq
  /tmp/hyperic-hq-installer-5.8.2.1/setup.sh
  rm -rf /tmp/hyperic-hq-installer-5.8.2.1
}

#/var/lib/pgsql/9.3/data/postgresql.conf
#
#/var/lib/pgsql/9.3
#default user:postgres
#client:sudo -u postgres psql -c "ALTER USER postgres with password 'postgres';"
#
#psql -U postgres
#http://www.postgresql.org/download/linux/redhat/#yum
function installPostgresql93(){
  yum install http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-1.noarch.rpm -y
  yum install postgresql93-server postgresql93-contrib -y
  service postgresql-9.3 initdb
  chkconfig postgresql-9.3 on
  #TODO:config /var/lib/pgsql/9.3/data/postgresql.conf  #listen_addresses = 'localhost'-->listen_addresses = '*'
  service postgresql-9.3 restart
  #sudo -u postgres psql -c "ALTER USER postgres with password 'postgres';"
  #sudo -u postgres createdb HQ
  sudo -u postgres psql -c "CREATE USER hqadmin WITH ENCRYPTED PASSWORD 'hqadmin'"
  sudo -u postgres psql -c "drop DATABASE "HQ""
  sudo -u postgres psql -c "CREATE DATABASE "HQ" OWNER hqadmin ENCODING 'UTF8'"
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

/home/hyperic/server-5.8.2.1/bin/hq-server.sh start
/home/hyperic/agent-5.8.2.1/bin/hq-agent.sh start

cd $cur_dir

