#!/bin/sh
#

set -e
source ./config.conf
cur_dir=$(cd "$(dirname "$0")"; pwd)

ICLIENT_PROJECT_NAME=i-client
ICLIENT_PAKAGE_NAME=i-client-release.apk

function downloadAndroidSDK(){
  mkdir -p $GLOBAL_DOWNLOAD_DIR
  if [ ! -f "$GLOBAL_DOWNLOAD_DIR/adt-bundle-linux-x86_64-20140321.zip" ]; then
    set +e
    wget -P $GLOBAL_DOWNLOAD_DIR  "http://dl.google.com/android/adt/22.6.2/adt-bundle-linux-x86_64-20140321.zip"
    if [ "$?" -eq "1" ]; then
      rm -rf $GLOBAL_DOWNLOAD_DIR/adt-bundle-linux-x86_64-20140321.zip
    fi
    set -e
  fi
}

function installAndroidSDK(){
  yum install -y  compat-libstdc++-296.i686 compat-libstdc++-33.i686 zlib.i686 libstdc++.so.6 
  if [ ! -d "/opt/" ]; then
    mkdir -p /opt
  fi
  unzip  $GLOBAL_DOWNLOAD_DIR/adt-bundle-linux-x86_64-20140321.zip -d /opt
  Android_SDK_Home=/opt/adt-bundle-linux-x86_64-20140321/sdk
  grep -q "export AUTO_GEN_ANDROID" /etc/profile &&{
	echo "ANDROID config exits."
  }||{
	echo "#AUTO_GEN_ANDROID" >>/etc/profile
	echo "export ANDROID_HOME=$Android_SDK_Home #AUTO_GEN_ANDROID" >>/etc/profile
  }
  /opt/adt-bundle-linux-x86_64-20140321/sdk/tools/android list targets	
  #/opt/adt-bundle-linux-x86_64-20140321/sdk/tools/android list targets			#检查已安装的SDK版本
  #/opt/adt-bundle-linux-x86_64-20140321/sdk/tools/android list sdk				#列出所有SDK
  #/opt/adt-bundle-linux-x86_64-20140321/sdk/tools/android update sdk -t 1,2,4 -u 		#更新SDK
  #ant -f /src/xxyyzz/project/IPet clean release
}

function getIclientCode(){
  mkdir -p $GLOBAL_SOURCECODE_DIR
  if [ ! -d $GLOBAL_SOURCECODE_DIR/$ICLIENT_PROJECT_NAME ]
  then
    cd $GLOBAL_SOURCECODE_DIR
    git clone https://github.com/ipetty/i-client
  else
    cd $GLOBAL_SOURCECODE_DIR/$ICLIENT_PROJECT_NAME
    git pull
  fi
}

function compileIclinet(){
  . /etc/profile
  #rm -rf $GLOBAL_SOURCECODE_DIR/$ICLIENT_PROJECT_NAME/local.properties
  #ant -f $GLOBAL_SOURCECODE_DIR/$ICLIENT_PROJECT_NAME -Dkey.alias=$ipetty_key_alias -Dkey.alias.password=$ipetty_key_alias_password -Dkey.store.password=$ipetty_key_store_password  -Dkey.store=$ipetty_key_store_path clean release
  ant -f $GLOBAL_SOURCECODE_DIR/$ICLIENT_PROJECT_NAME clean debug
}


downloadAndroidSDK
installAndroidSDK
getIclientCode
compileIclinet

cd $cur_dir

