#!/bin/sh
#
#
#Ipet项目编译打包

cur_dir=$(cd "$(dirname "$0")"; pwd)

file_path=/home/data/files/update/android

mkdir -p $file_path

ant -f /src/xxyyzz/project/IPet -Dkey.alias=ipetty.alias -Dkey.store.password=ipetty.keystore -Dkey.alias.password=ipetty.alias -Dkey.store=$cur_dir/ipetty.keystore clean release


\cp -a /src/xxyyzz/project/IPet/bin/IPet-release.apk $file_path