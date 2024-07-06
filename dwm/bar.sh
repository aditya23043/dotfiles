#!/bin/bash

battery(){
  cmd="$(acpi | cut -d, -f2 | awk '{print $1}' | cut -d% -f1)"
  echo -ne "BAT: $cmd%"
}

volume(){
  cmd="$(pactl get-sink-volume 0 | cut -d/ -f2 | sed -n 1p | awk '{print $1}' | cut -d% -f1)"
  echo -ne "VOL: $cmd%"
}

xsetroot -name " $(volume) | $(battery) "
