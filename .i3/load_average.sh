#!/usr/bin/sh

load=$(uptime | grep -P "[0-9]+\.[0-9][0-9]" -o | head -n 1)
load_int=$(echo $load | cut -d "." -f 1)
cpu_cores=$(grep -c processor /proc/cpuinfo)

echo $load
echo $load
if test $load_int -ge $cpu_cores
then
    echo "#f92672"
fi
