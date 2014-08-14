#!/bin/sh
#http://goaccess.io/download

yum install gcc ncurses-devel glib2-devel tokyocabinet-devel -y

wget http://tar.goaccess.io/goaccess-0.8.3.tar.gz
tar -xzvf goaccess-0.8.3.tar.gz
cd goaccess-0.8.3/
./configure --enable-utf8
make
make install