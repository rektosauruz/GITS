#!/bin/bash

##this scripts simply changes the startup exo command at the xfce4 keyboard loacation file located at file=~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml

screen_manager () {

echo "current resolution is `xrandr | grep current | cut -d',' -f2 | cut -d' ' -f3,4,5`"


if [ "`xrandr | grep current | cut -d',' -f2 | cut -d' ' -f3,4,5`" == "1920x1080" ];then
	





sed -i '1\'
}



 
