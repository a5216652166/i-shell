#!/bin/sh
#

set -e
source ./config.conf
cur_dir=$(cd "$(dirname "$0")"; pwd)

function downloadProbe(){
  mkdir -p $GLOBAL_DOWNLOAD_DIR
  if [ ! -f "$GLOBAL_DOWNLOAD_DIR/probe-${PROBE_VER}.zip" ]; then
    set +e
    export http_proxy="http://202.171.253.134"
    export https_proxy="https://202.171.253.134"
    wget -P $GLOBAL_DOWNLOAD_DIR  "http://psi-probe.googlecode.com/files/probe-${PROBE_VER}.zip"
    if [ "$?" -eq "1" ]; then
      rm -rf $GLOBAL_DOWNLOAD_DIR/probe-${PROBE_VER}.zip 
    fi
    export http_proxy=
    export https_proxy=
    set -e
  fi
}

function deployProbe(){
  unzip -oq $GLOBAL_DOWNLOAD_DIR/probe-${PROBE_VER}.zip -d /tmp
  mkdir -p $TOMCAT_HOME/webapps/probe
  unzip -oq /tmp/probe.war -d $TOMCAT_HOME/webapps/probe
}

function configyProbe(){
  #TODO:输入用户名密码
  TOMCAT_USER_FILE=$TOMCAT_CONFIG_DIR/tomcat-users.xml
  TOMCAT_USER_BACKUP_FILE= $TOMCAT_CONFIG_DIR/tomcat-users.xml.bak

  if [ ! -f "$TOMCAT_USER_BACKUP_FILE" ]; then
    \cp -av $TOMCAT_USER_FILE $TOMCAT_USER_BACKUP_FILE
  fi

  cat >> $TOMCAT_USER_FILE <<EOF
  <?xml version='1.0' encoding='utf-8'?>
  <tomcat-users>
    <role rolename="manager"/>
    <role rolename="tomcat"/>
    <role rolename="poweruser"/>
    <role rolename="poweruserplus"/>
    <role rolename="probeuser"/>
    <user username="admin" password="itserver" roles="tomcat,manager,probeuser,poweruserplus,poweruser"/>
  </tomcat-users>
  EOF
}

#downloadProbe
#deployProbe
configyProbe
service tomcat restart

cd $cur_dir

