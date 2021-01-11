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
dest_file="$src_file.head"

head -n $line $src_file > $dest_file

echo "ok"
