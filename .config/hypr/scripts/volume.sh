#!/usr/bin/env bash

# Usage: ./volume.sh <up|down|mute|mic-mute>

case "$1" in
  up)
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
    ;;
  down)
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    ;;
  mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
  mic-mute)
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    ;;
esac

# Handle Mic Mute OSD
if [[ "$1" == "mic-mute" ]]; then
  mic_info=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
  is_mic_muted=$(echo "$mic_info" | grep -c "MUTED")
  if [ "$is_mic_muted" -eq 1 ]; then
    ~/.config/hypr/scripts/osd.sh "Microphone" "Muted"
  else
    ~/.config/hypr/scripts/osd.sh "Microphone" "Unmuted"
  fi
  exit 0
fi

# Handle Speaker Volume/Mute OSD
vol_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
volume=$(echo "$vol_info" | awk '{print int($2 * 100)}')
is_muted=$(echo "$vol_info" | grep -c "MUTED")

if [ "$is_muted" -eq 1 ]; then
  ~/.config/hypr/scripts/osd.sh "Volume" "Muted" "($volume%)"
else
  ~/.config/hypr/scripts/osd.sh --bar "$volume" "Volume"
fi
