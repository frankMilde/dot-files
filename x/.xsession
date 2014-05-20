#!/bin/bash

xsetroot -solid black
#xsetroot -solid gray30 &

setxkbmap -model pc105 -layout us
xmodmap ~/.fk_win_natural_keyb

#turns CAPSLOCK off and lets it act as ESC
xmodmap -e "clear lock"
xmodmap -e "keycode 66 = Escape"
#xmodmap -e "keycode 0x42 = Escape" 

#gpg-agent --daemon --enable-ssh-support \
	#--write-env-file "${HOME}/.gnupg/.gpg-agent-info"

sleep 1 && firefox &
sleep 1 && use-thunderbird-with-gpg-agent.sh &
sleep 1 && evince &

volume(){
     # STATUS="`amixer get Headphone |awk '/Front\ Left:/ {print $4}'`"
     # if test "$STATUS" != "[on]" ; then 
     #   echo " Mute"
     # else
        echo "Vol. `/usr/bin/amixer get Master Playback Volume |awk '/Front\ Left:/ {print $5}' | sed -e 's/\[//g'|sed -e 's/%\]//g'` | "
			# 	 fi
    }
cmusstats(){
 if test "X`pgrep cmus`" != "X" ; then 
    TIME="`cmus-remote -Q |awk '/duration/ {print $2}'`"
    CURR="`cmus-remote -Q |awk '/position/ {print $2}'`"
    ARTIST="`cmus-remote -Q |sed -ne '/artist/s/tag artist //pg'`"
    TITLE="`cmus-remote -Q |sed -ne '/title/s/tag title //pg'`"
		#TOTALSEC=$($TIME-$CURR)
		#RESTMIN=$($TOTALSEC/60)
		#RESTSEC=$($TOTALSEC%60)
		
	  echo "$ARTIST - $TITLE [$CURR/$TIME] | "
	  #echo "$ARTIST - $TITLE [$RESTMIN:$RESTSEC] | "
 fi
}

xset b 0 440 50 &  beep off

# & hinter Main entfernt
if /usr/bin/screen -ls | grep -q Main; then
       /usr/bin/uxterm -e screen -Uxr Main &
else
      /usr/bin/uxterm -e screen -US Main &
fi

#original dwm
#while xsetroot -name "`date` `uptime | sed 's/.*,//'`"

#Franks
#while xsetroot -name "`cmusstats``volume``date '+%A, %d. %b %Y   %H:%M'`"
while xsetroot -name "`cmusstats``volume``date '+%A, %d. %b %Y   %H:%M'`"
do
	sleep 1
done &
exec ~/local/bin/dwm

exit

