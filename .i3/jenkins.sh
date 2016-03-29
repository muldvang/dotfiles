#!/bin/bash
if test $(hostname) = "laptop-110"
then
    color=$(curl "http://jenkins-ivd-centos7:8080/jenkins-ivd-centos7/view/HIV/api/json?pretty=true" | grep color | cut -d \" -f 4 | sort -r | uniq | head -n 1)
    if test "$color" = "aborted"
    then
        echo Aborted
        echo Aborted
        echo "#f92672"
    elif test "$color" != "blue" -a "$color" != "blue_anime"
    then
        echo "Error"
        echo "Error"
        echo "#f92672"
    fi
fi
