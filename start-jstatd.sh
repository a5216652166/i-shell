#!/bin/sh
#
#
#

#http://blog.csdn.net/fenglibing/article/details/17323515

hostname localhost  
hostname -i

jstatd -p 1099 \
-J-Djava.rmi.server.hostname=10.233.211.3 \
-J-Djava.security.policy=jstatd.all.policy \
-J-Dcom.sun.management.jmxremote.ssl=false \
-J-Dcom.sun.management.jmxremote.authenticate=false  &

netstat -an|grep 1099