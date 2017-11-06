#!/bin/bash
if test $(hostname) = "laptop-110"
then
    color=$(curl "http://jenkins-ivd:8080/jenkins-ivd/view/HIV/api/json?pretty=true" 2> /dev/null | grep color | cut -d \" -f 4 | sort -r | uniq | head -n 1)
    if test "$color" != "blue" -a "$color" != "blue_anime" -a "$color" != "notbuilt"
    then
        echo
        echo
        echo "#A52A2A"
    fi
fi
