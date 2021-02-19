#!/bin/sh
### BEGIN INIT INFO
# Provides:          xxxer
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: self define auto start
# Description:       self define auto start
### END INIT INFO

#上面的部分必须写上，后面放上需要开机执行的命令

/home/mango/src/sh_tools/mail_ip.sh
