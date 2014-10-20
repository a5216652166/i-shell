#!/bin/sh
#
# xiaojinghai@kedacom.com
#

echo "=================install erlang================"

rpm -ivh libexpat1-2.0.1-87.1.x86_64.rpm
rpm -ivh libexpat-devel-2.0.1-87.1.x86_64.rpm
rpm -ivh unixODBC-2.2.12-93.1.x86_64.rpm
rpm -ivh tcl-8.4.13-4.el5.x86_64.rpm
rpm -ivh tk-8.4.13-5.el5_1.1.x86_64.rpm
rpm -ivh erlang-R12B-5.10.el5.x86_64.rpm

tar xvzf badlop-badlop-ejabberd-multicast-2.1.x.tar.gz
cd ejabberd-badlop-ejabberd/src
./configure
 make

\cp -av ./mod_multicast.beam /opt/ejabberd-2.1.10/lib/ejabberd-2.1.10/ebin/
\cp -av ./ejabberd_router_multicast.beam /opt/ejabberd-2.1.10/lib/ejabberd-2.1.10/ebin/


echo "=================OK================" 