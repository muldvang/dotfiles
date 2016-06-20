#!/bin/bash
if test $(hostname) = "laptop-110"
then
    color=$(curl "http://jenkins-ivd:8080/jenkins-ivd/view/HIV/api/json?pretty=true" | grep color | cut -d \" -f 4 | sort -r | uniq | head -n 1)
    if test "$color" = "aborted"
    then
        echo Aborted
        echo Aborted
        echo "#f92672"
    elif test "$color" != "blue" -a "$color" != "blue_anime"
    then
        echo "Plugin"
        echo "Plugin"
        echo "#A52A2A"
    else
        color=$(curl "http://jenkins-ivd:8080/jenkins-ivd/view/Platform/api/json?pretty=true" | grep color | cut -d \" -f 4 | sort -r | uniq | head -n 1)
        if test "$color" = "aborted"
        then
            echo Aborted
            echo Aborted
            echo "#f92672"
        elif test "$color" != "blue" -a "$color" != "blue_anime"
        then
            echo "Platform"
            echo "Platform"
            echo "#A52A2A"
        fi
    fi
fi
