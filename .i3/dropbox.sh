#!/bin/bash

status=$(dropbox-cli status | head -n 1)
if test "$status" != "Up to date"
then
   echo $status
fi
