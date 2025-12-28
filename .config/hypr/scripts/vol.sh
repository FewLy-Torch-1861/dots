#!/usr/bin/env bash

OSD=~/.config/hypr/scripts/osd.sh

case $1 in
up)
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
  $OSD "Volume" "$(pulsemixer --get-volume | cut -d ' ' -f1)%"
  ;;
dn)
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
  $OSD "Volume" "$(pulsemixer --get-volume | cut -d ' ' -f1)%"
  ;;
lup)
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+
  $OSD "Volume" "$(pulsemixer --get-volume | cut -d ' ' -f1)%"
  ;;
ldn)
  wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
  $OSD "Volume" "$(pulsemixer --get-volume | cut -d ' ' -f1)%"
  ;;
mute)
  wpctl set-mute @DEFAULT_SINK@ toggle
  if wpctl get-volume @DEFAULT_SINK@ | grep -q "MUTED"; then
    $OSD "Volume" "Muted"
  else
    $OSD "Volume" "Unmuted"
  fi
  ;;
mmute)
  wpctl set-mute @DEFAULT_SOURCE@ toggle
  if wpctl get-volume @DEFAULT_SOURCE@ | grep -q "MUTED"; then
    $OSD "Mic" "Muted"
  else
    $OSD "Mic" "Unmuted"
  fi
  ;;
*)
  exit 1
  ;;
esac
