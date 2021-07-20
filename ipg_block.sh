#!/bin/sh

if [ $# -ne 1 ]
then
    echo "input error, help info"
    echo "$0 0/1"
    echo "0 means nonblock, 1 means block"
    echo ""
    exit 0
fi

ipg_ip="172.16.2.15"
flag="-I"
is_block="0"

sudo iptables -L INPUT |grep -q $ipg_ip
if [ $? -eq 0 ]
then
    is_block="1"
    flag="-D"
fi
echo "current ipg block=$is_block"

if [ $1 -eq $is_block ]
then
    echo "ipg block same, exit"
    exit 0
fi

sudo iptables $flag INPUT -s $ipg_ip -j DROP

#sudo iptables -L INPUT
#netstat -an |grep 8237

echo "set ipg block=$1"

exit 0
