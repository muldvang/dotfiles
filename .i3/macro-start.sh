#!/usr/bin/env bash

xmacrorec2 -k 9 > /tmp/xmacro.txt &
echo $! > /tmp/xmacro.pid
