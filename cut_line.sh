#!/bin/sh

if [ $# -ne 3 ]
then
    echo "input error, help info"
    echo "$0 file start_line end_line"
    echo "start_line=1 means the first line"
    echo "end_line=0 means the last line"
    echo "eg: $0 01-01-log.txt 20 100"
    echo ""
    exit 0
fi

src_file=$1
start_line=$2
end_line=$3
dest_file="$src_file.log"

total_line=$(wc -l "$src_file" |cut -d' ' -f1)
if [ $end_line -gt $total_line ] || [ $end_line -le 0 ]
then
    end_line=$total_line
fi

echo "start_line=$start_line, end_line=$end_line, total_line=$total_line"

if [ $start_line -gt $end_line ]
then
    echo "error, start_line > end_line"
    exit 0
fi

if [ $start_line -eq 1 ]
then
    head -n $end_line "$src_file" > "$dest_file"
elif [ $end_line -eq $total_line ]
then
    tail -n $((total_line - start_line + 1)) "$src_file" > "$dest_file"
else
    bak_file="$src_file.bak"
    head -n $end_line "$src_file" > "$bak_file"
    total_line=$end_line
    tail -n $((total_line - start_line + 1)) "$bak_file" > "$dest_file"
    rm -f "$bak_file"
fi

echo "ok, dest_file=$dest_file"
exit 0
