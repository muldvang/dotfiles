#!/bin/bash

if test $(hostname) = "laptop-110"
then
   first=$(xwininfo -root -tree | grep -P 'Outlook Web App' | grep Navigator | cut -d ' ' -f 10)

   if test "$first" = ""
   then
       echo "Error"
       echo "Error"
       echo "#A52A2A"
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
       echo "Mail and appointment"
       echo "Mail and appointment"
       echo "#A52A2A"
   elif test $mail -gt 0
   then
       echo "Mail"
   elif test $cal -gt 0
   then
       echo "Appointment"
       echo "Appointment"
       echo "#A52A2A"
   fi
fi
