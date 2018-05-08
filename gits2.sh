#!/bin/bash
#author : rektosauruz
#version : v2.2
#definition : G.I.T.S. - Ghost In The Shell - A shell framework


### | Declerations          | ====================================================#
# Color Declerations
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

EXPLANATION="Cryptocurrency API Logger With Timestamp [Please Add Currency names to api.list file]"
USAGE_PARAMS="<1.db_path/db_name[leave blank for default]>  <2.y/n to Mark>  <3.y/n to query>  <4.y/n to read from terminal>  <5.y/n to create DB sorter file>" 
cts=$(date +"%a_%B_%d_%r_%Z_%Y")

##################!  MENU  !##################
while :
do
    clear
    cat<<EOF
    `echo -e "${BLUE}==========================${RESET}${RED}=========================${RESET}${YELLOW}======================${RESET}"`
    `echo -e "       ${BLUE}_               _${RESET}    ${RED}_       _   _                ${YELLOW}_          _ _${RESET} "` 
    `echo -e "  ${BLUE}__  | |__   ___  ___| |_${RESET} ${RED}(_)_ __ | |_| |__   ___   ${YELLOW}___| |__   ___| | |${RESET}"`
    `echo -e " ${BLUE}/ _\_| '_ \ / _ \/ __| __${RESET} ${RED}| | '_ \| __| '_ \ / _ \ ${YELLOW}/ __| '_ \ / _ \ | |${RESET}"`
    `echo -e "${BLUE}| (_| | | | | (_) \__ \ |_${RESET} ${RED}| | | | | |_| | | |  __/ ${YELLOW}\__ \ | | |  __/ | |${RESET}"`
    `echo -e " ${BLUE}\__, |_| |_|\___/|___/\__${RESET} ${RED}|_|_| |_|\__|_| |_|\___|${YELLOW} |___/_| |_|\___|_|_|${RESET}"`
    `echo -e " ${BLUE}|___/${RESET}                                       													 "`
    `echo "${BLUE}==========================${RESET}${RED}=========================${RESET}${YELLOW}======================${RESET}"`
    ${GREEN}=========================================================================${RESET}
    `echo -e "${YELLOW}<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${RESET}${RED}  ${BLUE}G.${RESET}${RED}I.T.${RESET}${YELLOW}S.${RESET}${YELLOW} >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${RESET}"`
    `echo -e "${YELLOW}<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${RED} MAIN MENU${RESET} ${YELLOW}>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${RESET}"`
    ${GREEN}=========================================================================${RESET}
    |${GREEN} [001] Line_Calculator${RESET}  ||| ${GREEN}[005] SHA-256${RESET}       ||| ${GREEN}[009] Conn_ChecK${RESET}   |   
    |${GREEN} [002] IPtables_BLK${RESET}     ||| ${GREEN}[006] TaR/UnTaR${RESET}     ||| ${GREEN}[00l] Ipv4_ChecK${RESET}   |  
    |${GREEN} [003] NetCaT${RESET}           ||| ${GREEN}[007] CryptoPaRseR${RESET}  ||| ${GREEN}[00a] Rec_A${RESET}        |
    |${GREEN} [004] MD5     ${RESET}         ||| ${GREEN}[008] Scan_ipv4${RESET}     ||| ${GREEN}[00v] Rec_V${RESET}        |  
  ${RED}(q)uit${RESET}${GREEN}=====================================================================${RESET}
    
EOF
##################!  MENU  !##################



md5() {

echo "please give the string to be converted to md5 format"
echo -e "printed to /root/Desktop/md5.txt"
read u_input
echo "md5 of $u_input : `echo -n "$u_input" | md5sum`"
sleep 1
touch /root/Desktop/md5.txt
echo "md5 of $u_input : `echo -n "$u_input" | md5sum`" > /root/Desktop/md5.txt

}



sha256() {

echo "please give the string to be converted to md5 format"
echo -e "printed to /root/Desktop/sha256.txt"
read u_input
echo "sha256 of $u_input : `echo -n "$u_input" | sha256sum`"
sleep 1
touch /root/Desktop/sha256.txt
echo "sha256 of $u_input : `echo -n "$u_input" | sha256sum`" > /root/Desktop/sha256.txt

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
    total=$(( sum + total + 1 ))
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



function scan_last_two() {

for ipv4_4 in $(seq 1 255); do
	ping -c 1 192.168.1.$ipv4_4 | grep "ttl=" | cut -d" " -f4 & 
done
sleep 4 

}



##querying tool here##
function query_tool() {

  echo -e "do you want to make a query y/n?"
  read user_choice
if [ "$user_choice" = "y" ]; then
  echo -e "please enter date you want to query \t FORMAT [Month]_[day]_[HH:MM:SS]"
##echo -e "FORMAT [Month]_[day]_[HH:MM:SS]"
  read q_input
  cat $database_name | grep -A5 $q_input >> /root/GITS/querytable.txt
else 
  exit 0
fi

}



parser() {

#If there is no parameter that is supplied print Explanation and Input Syntax.
EXPLANATION="Cryptocurrency API Logger With Timestamp [Please Add Currency names to api.list file]"
USAGE_PARAMS="<1.db_path/db_name[leave blank for default]>  <2.y/n to Mark>  <3.y/n to query>  <4.y/n to read from terminal>  <5.y/n to create DB sorter file>" 
#DEFAULT_DB=/root/GITS/ccr_db.dat
#DEFAULT_qDB=/root/GITS/query_db.dat
#DEFAULT_DBs=/root/GITS/dbs.txt
DEFAULT_DB=/root/cron_files/ccr_db.dat
DEFAULT_qDB=/root/cron_files/query_db.dat
DEFAULT_DBs=/root/GITS/dbs.txt




#api.list checker if not present create automatically
if [ ! -f /root/GITS/api.list ]; then
    touch /root/GITS/api.list
    printf "monero\nbitcoin\nethereum\nkarbowanec\nsumokoin" >> /root/GITS/api.list
fi

#if first parameters is given as a file name use that file to populate else use the default database file
if [ -z "$1" ]; then
    database_name=$DEFAULT_DB
    echo -e "${RLS} ${RED}$EXPLANATION"
    echo -e "${RLS} Usage : $0 ${GREEN}$USAGE_PARAMS ${RESET}"  # Simplified USAGE for files only
elif [ "$1" = "D" ]; then
	database_name=$DEFAULT_DB
else
    database_name=$1
fi

#if first parameters is given as a file name use that file to populate else use the default database file
##condition if the file exist and user input required
if [ "$5" == "y" ]; then
  echo -e "please specify database sorter file with path : "
    read userpath  
    if [ "$userpath" == "$DEFAULT_DBs" ]; then
        last_uniq=$(grep -e lastuniq $DEFAULT_DBs | cut -d ':' -f2)
        prev_last=$last_uniq
        newuniq=$((prev_last + 1))
        sed -i "s/$prev_last\$/$newuniq/g" $DEFAULT_DBs 
      #  prev_last=$(cut -d ':' -f2 $last_uniq)
    else
        echo -e "database sorter file not found. New file is created /root/GITS/dbs.txt"
        touch $DEFAULT_DBs
        echo "lastuniq:0" > $DEFAULT_DBs
        last_uniq=$(grep -e lastuniq $DEFAULT_DBs | cut -d ':' -f2)         
    fi 
elif [ "$5" == "n" ]; then
    if [ -f "$DEFAULT_DBs" ]; then 
        last_uniq=$(grep -e lastuniq $DEFAULT_DBs | cut -d ':' -f2)
        prev_last=$last_uniq
        newuniq=$((prev_last + 1))
        sed -i "s/$prev_last\$/$newuniq/g" $DEFAULT_DBs #dbs.txt 
    else 
        echo "creating database sorter file"
        touch $DEFAULT_DBs  
        echo "lastuniq:0" > $DEFAULT_DBs 
        last_uniq=$(grep -e lastuniq $DEFAULT_DBs | cut -d ':' -f2)
    fi
else 
  if [ -f "$DEFAULT_DBs" ]; then 
        last_uniq=$(grep -e lastuniq $DEFAULT_DBs | cut -d ':' -f2)
        prev_last=$last_uniq
        newuniq=$((prev_last + 1))
        sed -i "s/$prev_last\$/$newuniq/g" $DEFAULT_DBs #dbs.txt 
    else 
        echo "creating database sorter file"
        touch $DEFAULT_DBs  
        echo "lastuniq:0" > $DEFAULT_DBs 
        last_uniq=$(grep -e lastuniq $DEFAULT_DBs | cut -d ':' -f2)
    fi
fi

dark_zone=$(mktemp)
##cts=$(date)
cts=$(date +"%a_%B_%d_%r_%Z_%Y")

##if the second parameter is given then mark the query
if [ "$2" == "y" ]; then
  echo "[*][*][MARKED][*][*] @ $cts     UUID = $last_uniq " >> $dark_zone
elif [ "$2" == "n" ]; then
  echo " @ $cts     UUID = $last_uniq " >> $dark_zone
else
    echo " @ $cts     UUID = $last_uniq " >> $dark_zone
fi
##if the second parameter is given then mark the query

#asking for fourth parameter here 
if [ "$4" == "y" ]; then 
    echo -e "\t ${RLS}${RLS}${RLS}${GREEN}$cts${RLS}${RLS}${RLS}"
fi

for ccr in $(cat /root/GITS/api.list); do

    varx=`curl https://api.coinmarketcap.com/v1/ticker/$ccr/ 2>/dev/null | grep price_usd | cut -d "\"" -f4 &`
    varn=`curl https://api.coinmarketcap.com/v1/ticker/$ccr/ 2>/dev/null | grep name | cut -d "\"" -f4 &`
    vard=`curl https://api.coinmarketcap.com/v1/ticker/$ccr/ 2>/dev/null | grep percent_change_24h | cut -d "\"" -f4 &`
    varh=`curl https://api.coinmarketcap.com/v1/ticker/$ccr/ 2>/dev/null | grep percent_change_1h | cut -d "\"" -f4 &`
    
    if [ -z "$varx" ]; then
      echo "Internet Connectivity Error, Terminating..."
      exit 0
    fi

    if [ "$4" == "y" ]; then 
        echo -e "           ${RED}Checking ${BLUE}$ccr \t = \t ${GREEN}$varx"
        echo -e "## $varn\t\t\t=$varx Delta_24h% = $vard  Delta_1h% = $varh " >> $dark_zone
    elif [ "$4" == "n" ]; then 
        echo -e "## $varn\t\t\t=$varx Delta_24h% = $vard  Delta_1h% = $varh " >> $dark_zone 
    fi
done

    echo "####################################################################" >> $dark_zone
        
cat $dark_zone >> $database_name

#getting third parameter
if [ "$3" == "q" ]; then
  query_tool
elif [ "$3" == "n" ]; then 
  #exit 0
  return 1 
else 
   # exit 0
  return 1
fi

}



test_connection() {

testv=`ping -c 1 -w 1 8.8.8.8 | grep ttl`
    if [ -z "$testv" ];
        then
        echo "Internet Connection is ${RED}DOWN${RESET}"
        sleep 1
        return 1
    else
        echo "Internet Connection is ${GREEN}UP${RESET}"
        sleep 1
        return 1
    fi

}



Ipv4_chk() {
echo "your IP is ${GREEN}`ifconfig wlan0 | grep "inet " | cut -d't' -f2 | cut -d'n' -f1`${RESET}"
sleep 1
return 1
}



Rec_Audio() {
parecord /root/A_REC/"$cts".wav
return 1
}

Rec_Video() {
vlc -I dummy v4l2:///dev/video0 -Vdummy --video-filter scene --no-audio --scene-path /root/C_REC --scene-prefix "$cts" --scene-format png vlc://quit --run-time=1
return 1
}



parser_input() {

#echo "$EXPLANATION"
#a1=/root/Desktop/dbstest.txt
a1="D"    
b2="n"
c3="n"
d4="y"
e5="n"
parser "$a1" "$b2" "$c3" "$d4" "$e5"
sleep 5

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
    "7")  parser_input  ;; 
    "8")  scan_last_two  ;;  
    "9")  test_connection ;; 
    "l") Ipv4_chk ;;
    "a") Rec_Audio ;;
    "v") Rec_Video ;;  
    "q")  exit                      ;;
#    "q")  echo "case sensitive!!"   ;; 
     * )  echo "invalid option"     ;;
    esac
    sleep 1
done