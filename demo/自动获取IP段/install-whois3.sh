#!/bin/bash
# date:	  2011-10-28
# Author: vinson
# Blog:	  http://m114.org

wget http://ftp.apnic.net/apnic/dbase/tools/ripe-dbase-client-v3.tar.gz

tar xzvf ripe-dbase-client-v3.tar.gz

cd whois-3.1

./configure

make && make install