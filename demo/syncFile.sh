#!/bin/sh
#
# 使用本脚本需要将安装文件复制到/soft目录
# 


echo "=================sync feedAttachment================"
scp -r root@172.16.3.1:/usr/local/apache-tomcat-6.0.33/webapps/ROOT/feedAttachment ./

echo "=================sync photos================"
scp -r root@172.16.3.1:/usr/local/apache-tomcat-6.0.33/webapps/ROOT/photos ./

echo "=================ok================" 