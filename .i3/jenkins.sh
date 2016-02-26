#!/bin/bash
if test $(hostname) = "laptop-110"
then
    color=$(curl "http://jenkins-ivd:8080/jenkins-ivd/view/Plugins%20and%20bioinformatics/api/json?pretty=true" | grep color | cut -d \" -f 4 | sort -r | uniq)
    if test "$color" != "blue"
    then
        echo "Error"
        echo "Error"
        echo "#f92672"
    fi
fi
