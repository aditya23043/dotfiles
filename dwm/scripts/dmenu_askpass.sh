#!/bin/bash

pass="$(cat /dev/null | dmenu -P -p 'Enter Password')"

echo "$pass"
