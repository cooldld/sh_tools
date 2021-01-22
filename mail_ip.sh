#!/bin/sh

sleep 10

info=$(ifconfig)

echo $info |mailx -s 'ub13 ip' ding.luo@dinglicom.com

exit 0
