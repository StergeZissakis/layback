#!/bin/bash

echo "Cleaning up old chrome instances..."
rm -f /tmp/killold
touch /tmp/killold
for name in python python3 chromium chrom
do
    ps -eo pid,etimes,comm | awk '$2 > 7200 && $3~/'$name'/ { print $1 }' >>  /tmp/killold
done
cat /tmp/killold | xargs kill -9
