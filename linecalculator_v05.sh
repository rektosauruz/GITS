#!/bin/bash -   
    #title          :linecalculator.sh
    #description    :counts the total number of folders and total line for each file and total for the whole folder
    #author         :rektosauruz
    #date           :20180111
    #version        :v0.5      
    #usage          :./linecalculator.sh (dir)
    #notes          :locating the sub folders using find, wc -l folder error is handled by 2> /dev/null  
    #bash_version   :4.4.11(1)-release
    #Donation XMR   :46Jh7aZkVCLKAjFiyNYD6vhrEFtwswVSbVsqMyGsrUUV1bjmQJv4EwFb2xWNqS3x7aWnMNM1UWKyfZd6ZcscqncSQEFpZtXs
    #Donation BTC   :13MWtnPZPy54q3qhxgbYA14m89fZkn6noK
    #================================================================================



#get the first parameter if not exist then ask for the directory 
if [ -z "$1" ]; then
    echo "please give the path to directory / Enter "Q" to abort"
    read user_input
    path=$user_input
else
    path=$1
fi

if [ "$user_input" = "Q" ]; then
    exit 0
fi


#create the temporary file for listing the sub folders and files
touch /root/filenames.txt
chmod 755 /root/filenames.txt
temp=/root/filenames.txt
find $path | cat >> $temp ##/root/filenames.txt


#define a counter for the line count   
inc=0
sum=0
total=0 


#loop for the wc -l command to read from the temporary file 
for ccb in $(cat $temp); do
    fl_count=$(wc -l $ccb 2> /dev/null | cut -d ' ' -f1)
    sum=$fl_count
    total=$(( sum + total ))
done


echo "total number of lines in $path = $total"
rm $temp





