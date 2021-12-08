#!/bin/sh

bin_dir=$(dirname $0)
ymd=$(date "+%Y.%m.%d %H:%M:%S")

log_file="$bin_dir/umount_tool.log"
tmp_file="$bin_dir/umount_tool.tmp"

echo "$ymd" > $tmp_file

#force pkill all
index=0
for i in $(who |grep 'pts' |awk 'BEGIN{FS=" "}{print $1,$2}')
do
    if [ $((index % 2)) -eq 0 ]
    then
        user_name=$i
    else
	if mount |grep -q "/home/$user_name/"
	then
            pkill -kill -t $i
            echo pkill $user_name $i $? >> $tmp_file
	fi
    fi
    index=$((index + 1))
done

sleep 1

#force umount all
index=0
for i in $(mount |grep '//172.' |cut -d' ' -f1,3)
do
    if [ $((index % 2)) -eq 0 ]
    then
        url_path=$i
    else
	fuser -ck $i
        sudo umount -f $i
        echo umount $url_path $i $? >> $tmp_file
    fi
    index=$((index + 1))
done

echo "" >> $tmp_file
cat $log_file >> $tmp_file
mv $tmp_file $log_file

exit 0
