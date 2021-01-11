#!/bin/sh

if [ $# -ne 2 ]
then
    echo "input error, help info"
    echo "$0 file line"
    echo "eg: $0 01-01-log.txt 100"
    echo ""
    exit 0
fi

src_file=$1
line=$2
total_line=$(wc -l $src_file |cut -d' ' -f1)

if [ $line -ge $total_line ]
then
    echo "error, line=$line >= total_line=$total_line"
    exit 0
fi


dest_file="$src_file.tail"
dest_line=$((total_line - line))

tail -n $dest_line $src_file > $dest_file

echo "ok"
