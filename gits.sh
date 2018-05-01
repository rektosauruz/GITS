#!/bin/bash
#author : rektosauruz
#version : v2.1
#
#
#
#

### | Declerations          | ====================================================#

# Color Decleratins.
ESC="["
RESET=$ESC"39m"
RED=$ESC"31m"
GREEN=$ESC"32m"
LBLUE=$ESC"36m"
BLUE=$ESC"34m"
BLACK=$ESC"30m"
YELLOW=$ESC"33m"

#[*] Status Indicator with different colors.
RLS=${RED}"[*]"${RESET}
BLS=${BLUE}"[*]"${RESET}
GLS=${GREEN}"[*]"${RESET}
RES=${RED}"[!]"${RESET}




while :
do
    clear
    cat<<EOF
    `echo "${BLUE}==========================${RESET}${RED}=========================${RESET}${YELLOW}=======================${RESET}"`
    `echo -e "       ${BLUE}_               _${RESET}    ${RED}_       _   _                ${YELLOW}_          _ _${RESET} "` 
    `echo -e "  ${BLUE}__  | |__   ___  ___| |_${RESET} ${RED}(_)_ __ | |_| |__   ___   ${YELLOW}___| |__   ___| | |${RESET}"`
    `echo -e " ${BLUE}/ _\_| '_ \ / _ \/ __| __${RESET} ${RED}| | '_ \| __| '_ \ / _ \ ${YELLOW}/ __| '_ \ / _ \ | |${RESET}"`
    `echo -e "${BLUE}| (_| | | | | (_) \__ \ |_${RESET} ${RED}| | | | | |_| | | |  __/ ${YELLOW}\__ \ | | |  __/ | |${RESET}"`
    `echo -e " ${BLUE}\__, |_| |_|\___/|___/\__${RESET} ${RED}|_|_| |_|\__|_| |_|\___|${YELLOW} |___/_| |_|\___|_|_|${RESET}"`
    `echo -e " ${BLUE}|___/${RESET}                                       													 "`
    `echo "${BLUE}==========================${RESET}${RED}=========================${RESET}${YELLOW}=======================${RESET}"`
 
    ${GREEN}=========================================================================${RESET}
    `echo -e "                           ${YELLOW}<<<<<${RESET}${RED}  ${BLUE}G.${RESET}${RED}I.T.${RESET}${YELLOW}S.${RESET}${YELLOW} >>>>>${RESET}"`
    `echo -e "                           ${YELLOW}<<<<<${RESET}${RED} MAIN MENU${RESET} ${YELLOW}>>>>>${RESET}"`
    ${GREEN}=========================================================================${RESET}
    ${GREEN}  [001] Line_Calculator${RESET}  |||   ${GREEN}[005] SHA-256${RESET}    |||   ${GREEN}[009]      N/A${RESET}   
    ${GREEN}  [002] IPtables_BLK${RESET}     |||   ${GREEN}[006] TaR/UnTaR${RESET}  |||   ${GREEN}[010]      N/A${RESET}   
    ${GREEN}  [003] NetCaT${RESET}           |||   ${GREEN}[007]      N/A${RESET}   |||   ${GREEN}[011]      N/A${RESET}   
    ${GREEN}  [004] MD5     ${RESET}         |||   ${GREEN}[008]      N/A${RESET}   |||   ${GREEN}[012]      N/A${RESET}   
    ${RED}  (q)uit${RESET}
    ${GREEN}=========================================================================${RESET}
EOF

md5() {
echo "please give the string to be converted to md5 format"
read u_input
echo "md5 of $u_input : `echo -n "$u_input" | md5sum`"
}


sha256() {
echo "please give the string to be converted to md5 format"
read u_input
echo "sha256 of $u_input : `echo -n "$u_input" | sha256sum`"
}


nc_manager() {

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
   "Q") return 1 #exit 0
   ;;
   *) echo "use defined values, ending the program now."
   ;;  
esac

}


line_calc() {

#get the first parameter if not exist then ask for the directory 
if [ -z "$1" ]; then
    echo "please give the path to directory / Enter "Q" to abort"
    read user_input
    path=$user_input
else
    path=$1
fi

if [ "$user_input" = "Q" ]; then
    #exit 0
    return 1
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

}


iptables_blk() {

#first line is to get the address to be blocked.
echo "please input the IP address to be blocked / Enter "Q" to abort"
read blk_addr
if [ "$blk_addr" = "Q" ]; then
    #exit 0
    return 1
fi

iptables -I INPUT -s $blk_addr -j DROP
iptables -I OUTPUT -s $blk_addr -j DROP
iptables -I FORWARD -s $blk_addr -j DROP
iptables-save > /etc/iptables.conf

}


tar_archiever() {

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

}


    read -n1 -s
    case "$REPLY" in
#    "1")  sh /root/Desktop/GITS/linecalculator_v05.sh ;;
    "1")  line_calc ;;
#   "2")  sh /root/Desktop/GITS/fw_entry.sh ;;
    "2")  iptables_blk ;;
#    "3")  sh /root/Desktop/GITS/nc_manager.sh ;;
    "3")  nc_manager ;;
#    "4")  sh /root/Desktop/GITS/md5c.sh ;;
    "4")  md5 ;;
#    "5")  sh /root/Desktop/GITS/sha256c.sh ;;
    "5")  sha256 ;;
    "6")  tar_archiever ;;
    "q")  exit                      ;;
#    "q")  echo "case sensitive!!"   ;; 
     * )  echo "invalid option"     ;;
    esac
    sleep 1
done













###SCRATCHPAD########
#@35 `figlet ghostintheshell`