#!/bin/bash

if [ -z "$1" ]; then  #if absolute directory isn't given
        wget -O /tmp/wallpaper.jpg "http://www.bing.com/$(wget -q -O- https://binged.it/2ZButYc | sed -e 's/<[^>]*>//g' | cut -d / -f2 | cut -d \& -f1)"
        gsettings set org.gnome.desktop.background picture-uri-dark file:////tmp/wallpaper.jpg
else
        dir=$1 #get absolute directory path
        number=$(ls $dir | wc -l) # get number of files
        index=$(($RANDOM % $number +1)) #select a wallpaper randomly
        file=$(ls $dir | sed -n $(echo $index)p) #get file name of index
        path=$(echo $dir/$file) #get absolute path to picture
        gsettings set $(echo org.gnome.desktop.background picture-uri-dark file:////$path) #change wallpaper
        echo $(date) $file >> $dir/wallpaper_of_the_day.txt #write log to file
fi

