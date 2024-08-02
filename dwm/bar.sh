#!/bin/bash

battery(){
  cmd="$(acpi | cut -d, -f2 | awk '{print $1}' | cut -d% -f1)"
  echo -ne "^b#7daea3^^c#000000^ BATTERY ^d^ $cmd%"
}

volume(){
  cmd="$(pactl get-sink-volume 0 | cut -d/ -f2 | sed -n 1p | awk '{print $1}' | cut -d% -f1)"
  echo -ne "^b#7daea3^^c#000000^ VOLUME ^d^ $cmd%"
}

brightness(){
  cmd="$(sudo ybacklight -get | cut -d. -f1)"
  echo -ne "^b#7daea3^^c#000000^ BRIGHTNESS ^d^ $cmd%"
}

mute(){
  cmd="$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d: -f2 | awk '{print $1}')"
  echo -ne "^b#7daea3^^c#000000^ MUTE ^d^ $cmd"
}

bluetooth(){
	cmd="$(bluetoothctl devices Connected | sed -n 1p)"
  echo -ne "^b#7daea3^^c#000000^ BLUETOOTH ^d^ $cmd"
}

wifi(){
	cmd="$(nmcli connection | awk '{print $1}' | sed -n 2p)"
  echo -ne "^b#7daea3^^c#000000^ WIFI ^d^ $cmd"
}

arch(){
	cmd="󰣇 ARCHLINUX"
  echo -ne "^c#7daea3^ $cmd^d^"
}

xsetroot -name "$(arch) $(wifi) $(bluetooth) $(mute) $(brightness) $(volume) $(battery) "
