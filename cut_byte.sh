#!/bin/sh

if [ $# -ne 3 ]
then
    echo "input error, help info"
    echo "$0 file start_pos data_len"
    echo "start_pos=0 means the first byte"
    echo "data_len=0 means the total len"
    echo "eg: $0 xxx.bin 0 100"
    echo ""
    exit 0
fi

src_file=$1
start_pos=$2
data_len=$3
dest_file="$src_file.log"

#du need cut by '\t', not ' '
total_len=$(du -b $src_file |cut -f1)

tmp_len=$((start_pos + data_len))
if [ $tmp_len -gt $total_len ] || [ $data_len -le 0 ]
then
    data_len=$((total_len - start_pos))
fi

echo "start_pos=$start_pos, data_len=$data_len, total_len=$total_len"

if [ $data_len -le 0 ]
then
    echo "error, start_pos > total_len"
    exit 0
fi

dd if=$src_file of=$dest_file iflag=skip_bytes,count_bytes skip=$start_pos count=$data_len

echo "ok, dest_file=$dest_file"
exit 0
