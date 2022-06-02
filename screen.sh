#!/usr/bin/bash

if [[ -z `which xrandr` ]]
then
    echo "plz install xrandr"
    exit
fi

br=`xrandr --prop --verbose | grep -A10 " connected primary" | grep "Brightness"`
br=${br:12}

dev=`xrandr --prop --verbose | grep " connected primary"`
dev=${dev%% *}

up=` echo "$br+0.1"|bc`
down=` echo "$br-0.1"|bc`

if [ $1 == 'up' ] && [ $(echo "$up <= 1.0"|bc) -ne 0 ]
then
    xrandr --output $dev --brightness $up
elif [ $1 == 'down' ] && [ $(echo "$down > 0"|bc) -ne 0 ]
then
    xrandr --output $dev --brightness $down
fi
