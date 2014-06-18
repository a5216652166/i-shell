#!/bin/sh
#
#
chomod +x ./*
./change-yum.sh
./i-init.sh
./i-jdk.sh
./i-ant.sh
./i-maven.sh
./i-androidsdk.sh
./i-mysql.sh
./i-tomcat.sh
./get_api_code.sh
./get_client_code.sh
./get_server_code.sh
./pub_server.sh
./pub_server_unlock.sh