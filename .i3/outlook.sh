#!/bin/bash

if test $(hostname) = "laptop-110"
then
   first=$(xwininfo -root -tree | grep -P 'Outlook Web App' | grep Navigator | cut -d ' ' -f 10)

   if test "$first" = ""
   then
       echo "Error"
       echo "Error"
       echo "#f92672"
   fi

   if test "$first" = "\"Torben"
   then
       exit
   fi

   arr=($(echo $first | tr -s [:punct:] ' '))
   mail=${arr[0]}
   cal=${arr[1]}

   if test $mail -gt 0 -a $cal -gt 0
   then
       echo "Mail and cal"
       echo "Mail and cal"
       echo "#f92672"
   elif test $mail -gt 0
   then
       echo "Mail"
   elif test $cal -gt 0
   then
       echo "Cal"
       echo "Cal"
       echo "#f92672"
   fi
fi
