#!/bin/sh
#
# xiaojinghai@kedacom

service memcached stop
rm -rf ./memcached-1.4.7
rm -rf /usr/local/memcached

echo "============OK============"