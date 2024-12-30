#!/bin/bash

accent_col="$(cat /home/adi/.config/dwm/config.h | grep -i accent | sed -n 1p | cut -d\" -f2)"

battery(){
  cmd="$(acpi | cut -d, -f2 | awk '{print $1}' | cut -d% -f1)"
  echo -ne "^b$accent_col^^c#000000^ BAT ^d^ $cmd%"
}

volume(){
  cmd="$(pactl get-sink-volume 0 | cut -d/ -f2 | sed -n 1p | awk '{print $1}' | cut -d% -f1)"
  cmd="$cmd%"
  if [[ "$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d: -f2 | awk '{print $1}')" == "yes" ]]; then
    cmd="mute"
  fi
  echo -ne "^b$accent_col^^c#000000^ VOL ^d^ $cmd"
}

brightness(){
  cmd="$(sudo ybacklight -get | cut -d. -f1)"
  echo -ne "^b$accent_col^^c#000000^ BRIGHTNESS ^d^ $cmd%"
}

mute(){
  cmd="$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d: -f2 | awk '{print $1}')"
  echo -ne "^b$accent_col^^c#000000^ MUTE ^d^ $cmd"
}

bluetooth(){
	cmd="$(bluetoothctl devices Connected | sed -n 1p)"
  if [ "$cmd" != "" ]; then
    echo -ne "^b$accent_col^^c#000000^ BLUETOOTH ^d^ $cmd"
  fi
}

wifi(){
	cmd="$(nmcli connection | awk '{print $1}' | sed -n 2p)"
  echo -ne "^b$accent_col^^c#000000^ WIFI ^d^ $cmd"
}

arch(){
	cmd="󰣇 ARCHLINUX"
  echo -ne "^c$accent_col^ $cmd^d^"
}

_time(){
  cmd="$(date +'%I:%M %p')"
  echo -ne "^b$accent_col^^c#000000^ TIME ^d^ $cmd"
}

_date(){
  cmd="$(date +'%b %d, %a')"
  echo -ne "^b$accent_col^^c#000000^ DATE ^d^ $cmd"
}

_mem(){
  mem_used="$(top -b -n 1 | grep -i mem | sed -n 1p | awk '{print $8}')"
  mem_total="$(top -b -n 1 | grep -i mem | sed -n 1p | awk '{print $4}')"
  mem_perc_with_extra="$(echo "scale = 4; ($mem_used/$mem_total)*100" | bc)"
  final_mem_perc="${mem_perc_with_extra::-2}%"
  mem_gigs="$(free -h | sed -n 2p | awk '{print $3}')"
  echo -ne "^b$accent_col^^c#000000^ MEM ^d^ $mem_gigs"
}

_cpu(){
  foo="$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')"
  cmd=${foo::-2}
  cmd="$(echo $cmd | cut -c 1-4)%"
  echo -ne "^b$accent_col^^c#000000^ CPU ^d^ $cmd"
}

_ip(){
  cmd="$(ip a show $(ip a | grep '.: w' | cut -d: -f2 | awk '{print $1}') | grep 192.168 | awk '{print $2}' | cut -d/ -f1)"
  echo -ne "^b$accent_col^^c#000000^ IP ^d^ $cmd"
}

_bat_time(){
  bat_hour="$(acpi | cut -d, -f3 | awk '{print$1}' | cut -d: -f1)"
  bat_min="$(acpi | cut -d, -f3 | awk '{print$1}' | cut -d: -f2)"
  cur_hour="$(date "+%I")"
  cur_min="$(date "+%M")"

  fin_hour=`bc << EOF
  $cur_hour + $bat_hour
  EOF
  `
  fin_min=`bc << EOF
  $cur_min + $bat_min
  EOF
  `
  fin_hour="$(echo $fin_hour | cut -d ' ' -f1)"
  fin_min="$(echo $fin_min | cut -d ' ' -f1)"

  echo -ne "| $bat_hour:$bat_min"
  
}

xsetroot -name "$(arch) $(_ip) $(_cpu) $(_mem) $(volume) $(battery) $(_bat_time) $(_time) $(_date) "
