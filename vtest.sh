#!/bin/bash


#this simple script will create a webcam record without prompting on to the screen!

cts=$(date +"%a_%B_%d_%r_%Z_%Y")


function vrec() {



vlc -I dummy v4l2:///dev/video0 -Vdummy --video-filter scene --no-audio --scene-path /root/Desktop/cam_rec --scene-prefix image_prefix --scene-format png vlc://quit --run-time=1 


}




vrec #1>/dev/null




#vlc -I dummy v4l2:///dev/video0 -Vdummy --video-filter scene --no-audio --scene-path /root/Desktop/cam_rec --scene-prefix image_prefix --scene-format png vlc://quit --run-time=1