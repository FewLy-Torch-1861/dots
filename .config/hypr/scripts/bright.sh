#!/usr/bin/env bash

OSD=~/.config/hypr/scripts/osd.sh

case $1 in
up)
  brightnessctl set 5%+
  $OSD "Brightness" "$(brightnessctl -m | cut -d, -f4)"
  ;;
dn)
  brightnessctl set 5%-
  $OSD "Brightness" "$(brightnessctl -m | cut -d, -f4)"
  ;;
*)
  exit 1
  ;;
esac
