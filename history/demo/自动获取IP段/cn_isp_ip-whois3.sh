#!/bin/bash
# date:	  2011-10-28
# Author: vinson
# Blog:	  http://m114.org

#获取网通IP
whois3 -h whois.apnic.net -l -i mb MAINT-CNCGROUP |grep "descr" |grep "Reverse" | awk -F "for" '{if($2!="") print$2}' |sort -n | awk 'BEGIN{print "acl \"CNC\" '{'"}{print $1";"}END{print "'}';"}' > cnc_acl.conf

#获取电信IP
whois3 -h whois.apnic.net -l -i mb MAINT-CHINANET |grep "descr" |grep "Reverse" | awk -F "for" '{if($2!="") print$2}' |sort -n | awk 'BEGIN{print "acl \"CTC\" '{'"}{print $1";"}END{print "'}';"}' > ctc_acl.conf

#获取铁通IP
whois3 -h whois.apnic.net -l -i mb MAINT-CN-CRTC |grep "inetnum" |sed 's/inetnum: //g' |sort -n |

awk -F'[.-]' '
{
        print $1"."$2"."$3"."$4,(255-($(NF-3)-$1))"."(255-($(NF-2)-$2))"."(255-($(NF-1)-$3))"."(255-($NF-$4))
}' |

while read ip mask
do
        a=$(ipcalc -p $ip $mask |awk -F= '{print$2}')
        echo $ip/$a >>temp
done
more temp |awk 'BEGIN{print "acl \"CRTC\" '{'"}{print $1";"}END{print "'}';"}' > crtc_acl.conf
rm -f temp
