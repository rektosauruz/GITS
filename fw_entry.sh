#!/bin/bash


#first line is to get the address to be blocked.
echo "please input the IP address to be blocked / Enter "Q" to abort"
read blk_addr
if [ "$blk_addr" = "Q" ]; then
    exit 0
fi

iptables -I INPUT -s $blk_addr -j DROP
iptables -I OUTPUT -s $blk_addr -j DROP
iptables -I FORWARD -s $blk_addr -j DROP
iptables-save > /etc/iptables.conf





 







######SCRATCHPAD
#how to drop any packet from in or out ?
#iptables -I INPUT -s hackademix.net -j DROP
#iptables -I OUTPUT -s hackademix.net -j DROP
#iptables -I FORWARD -s hackademix.net -j DROP
#iptables -L
#
#
#
#
#
#
#
#