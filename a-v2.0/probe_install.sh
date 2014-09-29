#!/bin/sh
#

set -e
source ./config.conf
cur_dir=$(cd "$(dirname "$0")"; pwd)

function downloadProbe(){
  mkdir -p $GLOBAL_DOWNLOAD_DIR
  if [ ! -f "$GLOBAL_DOWNLOAD_DIR/probe-${PROBE_VER}.zip" ]; then
    export http_proxy="http://202.171.253.134"
    export https_proxy="https://202.171.253.134"
    #export http_proxy="http://211.144.81.68:18000"
    #export https_proxy="https://211.144.81.68:18000"
    #export http_proxy="http://173.201.95.24"
    #export https_proxy="https://173.201.95.24"
    set +e
    wget -P $GLOBAL_DOWNLOAD_DIR  "http://psi-probe.googlecode.com/files/probe-${PROBE_VER}.zip"
    if [ "$?" -eq "1" ]; then
      rm -rf $GLOBAL_DOWNLOAD_DIR/probe-${PROBE_VER}.zip 
    fi
    set -e
    export http_proxy=
    export https_proxy=
  fi
}

function deployProbe(){
  unzip -oq $GLOBAL_DOWNLOAD_DIR/probe-${PROBE_VER}.zip -d /tmp
  mkdir -p $TOMCAT_HOME/webapps/probe
  rm -rf $TOMCAT_HOME/webapps/probe/*
  unzip -oq /tmp/probe.war -d $TOMCAT_HOME/webapps/probe
  rm -rf /tmp/probe.war
}

#�û����� ���� �û��ı� Ĭ��ֵ
function prompt(){
  variable=$1
  prompt_text=$2
  default_value=$3

  if [ -z "$variable" ]; then
    echo "Variable name was not given!" && exit 1
  fi

  read -p "$prompt_text [$default_value]: " $variable

  if [ -z "${!variable}" ]; then
    eval "$variable=$default_value"
  fi

}

function configyProbe(){
  #TODO:�����û�������

  if [ ! -f "$TOMCAT_USER_BACKUP_FILE" ]; then
    \cp -av $TOMCAT_USER_FILE $TOMCAT_USER_BACKUP_FILE
  fi

  prompt probeUser 'Probe System User' 'admin'
  prompt probeUserPassword 'Probe User Password' 'admin'

  echo "<?xml version='1.0' encoding='utf-8'?>" > $TOMCAT_USER_FILE
  echo '<tomcat-users>' >> $TOMCAT_USER_FILE
  echo '<role rolename="manager"/>' >> $TOMCAT_USER_FILE
  echo '<role rolename="tomcat"/>' >> $TOMCAT_USER_FILE
  echo '<role rolename="poweruser"/>' >> $TOMCAT_USER_FILE
  echo '<role rolename="poweruserplus"/>' >> $TOMCAT_USER_FILE
  echo '<role rolename="probeuser"/>' >> $TOMCAT_USER_FILE
  echo "<user username=\"$probeUser\" password=\"$probeUserPassword\" roles=\"tomcat,manager,probeuser,poweruserplus,poweruser\"/>" >> $TOMCAT_USER_FILE
  echo '</tomcat-users>' >> $TOMCAT_USER_FILE

#  (cat > $TOMCAT_USER_FILE <<EOF
#  <?xml version='1.0' encoding='utf-8'?>
#  <tomcat-users>
#    <role rolename="manager"/>
#    <role rolename="tomcat"/>
#    <role rolename="poweruser"/>
#    <role rolename="poweruserplus"/>
#    <role rolename="probeuser"/>
#    <user username="admin" password="itserver" roles="tomcat,manager,probeuser,poweruserplus,poweruser"/>
#  </tomcat-users>
#  EOF)
}

downloadProbe
deployProbe
configyProbe
service tomcat restart

cd $cur_dir

