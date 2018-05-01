#!/bin/bash
#author : rektosauruz
#version : v0.1
#


echo  "<PacK>     1"
echo  "<UnPacK>   2"
echo  "<QUIT>     Q"
read user_c

case "$user_c" in
   "1") echo "name the packed file"
	      echo "path/filename"
        read file_p1
        read file_p2
        tar -czvf /root/Desktop/"$file_p1".tar.gz --directory $file_p2 .
    
   ;;
   "2") echo "path/filename"
        read dir1
        tar -xzvf "$dir"
   ;;
   "Q") return 1 #exit 0
   ;;
   *) echo "use defined values, ending the program now."
   ;;  
esac


