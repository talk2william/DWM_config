#/bin/bash

#### dependencies:
# 1) feh --> background
# 2) alsamix --> audio infos
# 3) acpitool --> battery infos
# 4) ifconfig --> networkinfos

#### infos:
# 1) updates all 0.5 seconds 
#  	--> volume and battery state in the statusbar updates only all 0.5 seconds --> easy editable
#		--> update time is not in syc with the system time --> seconds display may look laggy
# 2) network is looking for the strings 'eth0' and 'wlan0' --> easy editable

feh --bg-scale ~/build/dwm/1.jpeg

while true
do
   battery=$(acpitool -b | cut -d"," -f2 | cut -d" " -f2)
   ip=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1)
   ip="${ip}"
   vol=$(amixer get Master | tail -1 | sed 's/.*\[\([0-9]*%\)\].*/\1/')
   vol="${vol}"
   mute=$(amixer get Master | egrep "^  Front Left"| cut -d"[" -f 4 | cut -d"]" -f 1)
   tmp="eth0:"
   if [ "$ip" = "$tmp" ]
	then
   	ip=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1)
	ip="${ip}"
   fi
   tmp="off"
   if [ "$mute" = "$tmp" ]
	then
	vol="mute"
   fi
   xsetroot -name "✉ ┊ ♬ $vol ┊  ◔$ip ┊  ☀$(date +"%A %d.%m.%y ⌚ %H:%M:%S")"
   sleep 0.5    # Update time
done &
