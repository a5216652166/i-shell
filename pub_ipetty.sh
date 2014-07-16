#!/bin/sh
#
#
#Ipet项目编译打包

. ./config

cur_dir=$(cd "$(dirname "$0")"; pwd)

output_path=/home/data/files

mkdir -p $output_path

ant -f /src/i-client -Dkey.alias=$ipetty_key_alias -Dkey.alias.password=$ipetty_key_alias_password -Dkey.store.password=$ipetty_key_store_password  -Dkey.store=$ipetty_key_store_path clean release

D:\GitHub\Android-PullToRefresh\library


\cp -a /src/i-client/bin/i-client-release.apk $output_path/ipetty.apk



