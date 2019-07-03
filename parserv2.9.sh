#!/bin/bash -   
    #title          :parserv2.9.sh
    #description    :Crypto Currency Price Grabber/Parser/Logger
    #author         :rektosauruz
    #date           :20180105
    #version        :v2.8      
    #usage          :./parserv2.sh 1.[filename] 2.[y/n] 3.[y/n] 4.[y/n] 5.[y/n]
    #notes          :this time the uuid creator will be fixed     
    #bash_version   :4.4.11(1)-release

ESC="["
RESET=$ESC"39m"
RED=$ESC"31m"
GREEN=$ESC"32m"
LBLUE=$ESC"36m"
BLUE=$ESC"34m"
BLACK=$ESC"30m"

#[*] Status Indicator with different colors.
RLS=${RED}"[*]"${RESET}
BLS=${BLUE}"[*]"${RESET}
GLS=${GREEN}"[*]"${RESET}
RES=${RED}"[!]"${RESET}

#If there is no parameter that is supplied print Explanation and Input Syntax.
EXPLANATION="Cryptocurrency API Logger With Timestamp [Please Add Currency names to api.list file]"
USAGE_PARAMS="<db_path/db_name>[leave blank for default]  <y/n to Mark>  <y/n to query>  <y/n to read from terminal>  <y/n to create DB sorter file>" 
DEFAULT_DB=/root/GITS/ccr_db.dat
DEFAULT_qDB=/root/GITS/query_db.dat
DEFAULT_DBs=/root/GITS/dbs.txt

### | Main Flow             | ====================================================#


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



##querying tool here##
function query_tool(){

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
        echo -e "${RED}Checking ${BLUE}$ccr \t = \t ${GREEN}$varx"
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
	exit 0 
else 
    exit 0
fi

#xfce4-terminal --geometry=27x29+1200+20 -e  ~/currencyhandler/parserv2.8.sh $1 $2 $3 $4 $5




### | Scratch PAD           | ====================================================#
#old time function replaced by simple date 
#timestamp() { 
#    date +"%T" 
#}
#below line is for creating new terminal window to show required usage parameters 
#xfce4-terminal --geometry=27x29+1200+20 -e  ~/Desktop/database_name 2>/dev/null
#
#
##counter part here
#last_uniq=~/root/dbs.txt
#prev_last=$(cut -d ':' -f2 "$last_uniq")
#newuniq=$((prev_last + 1))
#sed -i "s/$prev_last\$/$newuniq/g" "$last_uniq"
##counter part here
#
#
##unique id generator function here##
#function id_gen(){
#echo " $cts`uuidgen --random` "
#}
##unique id generator function here##
#


### | To Be Implemented     | ====================================================#

#date + "%T %u" for example usage of date
#date + "%a_%B_%d_%c_%Z_%Y"
#date +"%a_%B_%d_%r_%Z_%Y"
#crontab 
#user mark
#data_query using grep automated ?  query is working work it more fore file location and more stable implementation, maybe without function

### | Discard Pile Below    | ====================================================#

#vard=`curl https://api.coinmarketcap.com/v1/ticker/$ccr/ 2>/dev/null | grep percent_change_24h | cut -d "\"" -f4 &`
#varh=`curl https://api.coinmarketcap.com/v1/ticker/$ccr/ 2>/dev/null | grep percent_change_1h | cut -d "\"" -f4 &`

#timestamp function can be called as is.
#timestamp() { 
#    date +"%T" 
#}
#
#echo "Checking $ccr =  $varx"
#echo "$varx"
#timestamp
#cts=$(timestamp)
#=================================================================================#

#=================================================================================#



