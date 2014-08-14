#!/bin/sh
#
#
yum install curl -y
curl -s get.gvmtool.net | bash
source "$HOME/.gvm/bin/gvm-init.sh"
gvm install groovy
groovy -version