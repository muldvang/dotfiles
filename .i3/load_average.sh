#!/usr/bin/sh

load_int=$(cat /proc/loadavg | cut -c 1)
cpu_cores=$(grep -c pro /proc/cpuinfo)

if test $load_int -ge $cpu_cores
then
    load=$(cat /proc/loadavg | cut -d ' ' -f 1 | rev | cut -c 2- | rev)
    echo $load
    echo $load
    echo "#A52A2A"
fi
