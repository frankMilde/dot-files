#!/bin/bash

xsetroot -solid black

#setxkbmap -model pc105 -layout us
setxkbmap -layout us
#xmodmap ~/.fk_win_natural_keyb

#turns CAPSLOCK off and lets it act as ESC
xmodmap -e "clear lock"
xmodmap -e "keycode 66 = Escape"
#xmodmap -e "keycode 0x42 = Escape" 

firefox &
if test "`hostname`" != "archPad"; then
	thunderbird &
fi
${HOME}/local/bin/st -e  ${HOME}/local/bin/startup-check-arch-updates.sh &

traffic() {
	if test "`hostname`" == "archPad"; then
		INTERFACE="`ls /sys/class/net | tail -1`"
	else 
		INTERFACE="`ls /sys/class/net | head -1`"
	fi
	DNLOAD_1="`cat /proc/net/dev | grep $INTERFACE | awk '{print $2 }'`"
	UPLOAD_1="`cat /proc/net/dev | grep $INTERFACE | awk '{print $10}'`"
	sleep 1
	DNLOAD_2="`cat /proc/net/dev | grep $INTERFACE | awk '{print $2 }'`"
	UPLOAD_2="`cat /proc/net/dev | grep $INTERFACE | awk '{print $10}'`"

	DNLOAD="$(($DNLOAD_2 - $DNLOAD_1))"
	UPLOAD="$(($UPLOAD_2 - $UPLOAD_1))"

	KBIT_DL=$(echo "$DNLOAD / 1024" | bc)
	KBIT_UL=$(echo "$UPLOAD / 1024" | bc)
	#echo "☳ $ESSID:$LINK ▼$DNLOAD ▲$UPLAOD"
	echo "D $KBIT_DL kb/s U $KBIT_UL kb/s  |  "
}
wifi() {
	STATUS="X`/sbin/iwgetid`"
	if test "$STATUS" != "X" ; then
		ESSID="`/sbin/iwgetid |awk -F ":" '{print $2}'|sed -e 's/"//g'`"
		LINK="`awk 'NR==3 {print $3}' /proc/net/wireless |sed -e 's/\.//g'`"
		#echo "☳ $ESSID:$LINK ▼$DNLOAD ▲$UPLAOD"
		echo "$ESSID:$LINK  |  "
	else
		echo "No wifi | "
	fi
}
batt() {
	PRESENT=`cat /sys/class/power_supply/BAT0/present`
	CHARGE=`cat /sys/class/power_supply/BAT0/capacity`
	STATUS=`cat /sys/class/power_supply/BAT0/status`
	#use do while loop with test if CHARGE_2 - CHARGE_1 has changed and time
	#that loop --> get estimate of remaining time
	if test "$PRESENT" != "0" ; then
		case $STATUS in
			Full)
				SIGN="=";;
			Charging)
				SIGN="+";;
			Discharging)
				SIGN="-";;
		esac
		#echo " ⚡ ${CHARGE}${SIGN}  "
		echo " Batt. ${CHARGE} ${SIGN}${SIGN} |  "
	else
		echo " AC  "
	fi
}
volume(){
	echo "♫ `/usr/bin/amixer get Master Playback Volume |awk '/Mono:/ {print $4}' | sed -e 's/\[//g'|sed -e 's/%\]//g'`  |  "
}
cmusstats(){
	if test "X`pgrep cmus`" != "X" ; then 
		TIME="`cmus-remote -Q |awk '/duration/ {print $2}'`"
		CURR="`cmus-remote -Q |awk '/position/ {print $2}'`"
		ARTIST="`cmus-remote -Q |sed -ne '/artist/s/tag artist //pg'`"
		TITLE="`cmus-remote -Q |sed -ne '/title/s/tag title //pg'`"
		MIN=$($TIMESEC/60)
		SEC=$($TIMESEC%60)
		TOTALRESTSEC=$($TIME-$CURR)
		RESTMIN=$($TOTALRESTSEC/60)
		RESTSEC=$($TOTALRESTSEC%60)

		#echo "$ARTIST - $TITLE [$CURR/$TIME] | "
		echo "$ARTIST - $TITLE [$RESTMIN:$RESTSEC/$MIN:$SEC] | "
	fi
}

xset b 0 440 50 &  beep off

if test "`hostname`" == "archPad"; then
	while xsetroot -name "`cmusstats``wifi``traffic``batt``volume``date '+%a, %d. %b   %H:%M'`"
	do
		sleep 1
	done &
else
	while xsetroot -name "`cmusstats``traffic``volume``date '+%a, %d. %b   %H:%M'`"
	do
		sleep 1
	done &
fi

exec ${HOME}/local/bin/dwm
exit
