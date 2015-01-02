#!/bin/bash

xsetroot -solid black

#setxkbmap -model pc105 -layout us
setxkbmap -layout us
#xmodmap ~/.fk_win_natural_keyb

#turns CAPSLOCK off and lets it act as ESC
xmodmap -e "clear lock"
xmodmap -e "keycode 66 = Escape"
#xmodmap -e "keycode 0x42 = Escape" 

#gpg-agent --daemon --enable-ssh-support \
#	--write-env-file "${HOME}/.gnupg/.gpg-agent-info"

${HOME}/local/bin/st &
firefox &
#thunderbird &

wifi() {
    #STATUS="X`/sbin/iwgetid`"
    ESSID="`iwconfig wlp3s0 | grep ESSID | cut -f2 -d':' | sed -e 's/"//g'| sed -e 's/ //g'`"
    if test "$ESSID" != "off/any" ; then
        #ESSID="`/sbin/iwgetid |awk -F ":" '{print $2}'|sed -e 's/"//g'`"
        LINK="`awk 'NR==3 {print $3}' /proc/net/wireless |sed -e 's/\.//g'`"
        echo " $ESSID:$LINK  "
    else
        echo "No wifi "
    fi
}
batt(){
      FULL=`cat /sys/class/power_supply/BAT1/charge_full`
      PRESENT=`cat /sys/class/power_supply/BAT0/present`
      CHARGE=`cat /sys/class/power_supply/BAT0/capacity`
      STATUS=`cat /sys/class/power_supply/BAT0/status`
    if test "$PRESENT" != "0" ; then
      case $STATUS in
        Full)
          SIGN="=";;
        Charging)
          SIGN="+";;
        Discharging)
          SIGN="-";;
      esac
      echo " Batt: ${CHARGE}${SIGN}  "
    else
      echo " AC  "
    fi
    }
volume(){
     # STATUS="`amixer get Headphone |awk '/Front\ Left:/ {print $4}'`"
     # if test "$STATUS" != "[on]" ; then 
     #   echo " Mute"
     # else
        echo "Vol. `/usr/bin/amixer get Master Playback Volume |awk '/Mono:/ {print $4}' | sed -e 's/\[//g'|sed -e 's/%\]//g'` | "
     # fi
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

while xsetroot -name "`cmusstats``volume``wifi``batt` `date '+%A, %d. %b %Y   %H:%M'`"
do
	sleep 1
done &
exec ${HOME}/local/bin/dwm

exit
