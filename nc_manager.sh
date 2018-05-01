#!/bin/bash

#nc utility for speeding things up 

##define regular expression##
re='^[0-9]+$'

echo  "<SEND>     1"
echo  "<RECEIVE>  2"
echo  "<QUIT>     Q"
read user_c


case "$user_c" in
   "1") echo "ip / port / file"
        read ipaddr 
        read port
        read file
        nc -nv $ipaddr $port < $file
   ;;
   "2") echo "port / file"
        read port
        read file
        nc -nvlp $port > $file
   ;;
   "Q") exit 0
   ;;
   *) echo "use defined values, ending the program now."
   ;;  
esac