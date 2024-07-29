#!/bin/bash

battery(){
  cmd="$(acpi | cut -d, -f2 | awk '{print $1}' | cut -d% -f1)"
  echo -ne "^b#7daea3^^c#000000^ BAT ^d^ $cmd%"
}

volume(){
  cmd="$(pactl get-sink-volume 0 | cut -d/ -f2 | sed -n 1p | awk '{print $1}' | cut -d% -f1)"
  echo -ne "^b#7daea3^^c#000000^ VOL ^d^ $cmd%"
}

mute(){
  cmd="$(pactl get-sink-mute @DEFAULT_SINK@ | cut -d: -f2 | awk '{print $1}')"
  echo -ne "^b#7daea3^^c#000000^ MUTE ^d^ $cmd"
}

arch(){
	cmd="󰣇 ArchLinux"
  echo -ne "^c#7daea3^ $cmd^d^"
}

xsetroot -name "$(arch) $(mute) $(volume) $(battery) "
