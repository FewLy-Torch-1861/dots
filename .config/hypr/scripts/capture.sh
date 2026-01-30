#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/env.sh"

pkill rofi || true

ROFI_CMD=(rofi -dmenu -i -p " " -theme-str "#window { height: 26%; }" -theme "${ROFI_THEME_MENU}")

if [[ $1 == "waybar" ]]; then
  ROFI_CMD+=(-theme-str "${ROFI_WAYBAR_POS}")
fi

# Determine recording state
if pgrep -x "gpu-screen-reco" >/dev/null; then
  RECORD_OPTION="󰙧 Stop Record"
else
  RECORD_OPTION="󰑋 Record"
fi

OPTIONS=(
  "󰹑 Screen"
  "󱂬 Window"
  "󰆞 Region"
  "$RECORD_OPTION"
)

choice=$(printf '%s\n' "${OPTIONS[@]}" | "${ROFI_CMD[@]}")

if [[ -n "$choice" ]]; then
  case "$choice" in
  "${OPTIONS[0]}")
    sleep 0.3
    pidof slurp || hyprshot -o "${HYPRSHOT_DIR}" -m output -m active
    ;;

  "${OPTIONS[1]}")
    sleep 0.3
    pidof slurp || hyprshot -o "${HYPRSHOT_DIR}" -m window -m active
    ;;

  "${OPTIONS[2]}")
    sleep 0.3
    pidof slurp || hyprshot -o "${HYPRSHOT_DIR}" -m region
    ;;

  "$RECORD_OPTION")
    sleep 0.3

    if pgrep -x "gpu-screen-reco" >/dev/null; then
      pkill -SIGINT -f gpu-screen-reco
      # Wait for the recording to finish saving
      while pgrep -x "gpu-screen-reco" >/dev/null; do sleep 0.1; done
      # Get the path of the last recorded file
      LATEST_FILE=$(ls -t ~/Videos/Recorded/ | head -n 1)
      notify-send "Stopped Recording" "Saved to: ~/Videos/Recorded/$LATEST_FILE"
    else
      gpu-screen-recorder -w screen -f 60 -a default_output -o ~/Videos/Recorded/"$(date +%y-%m-%d_%H%M%S)".mp4 &
      notify-send "Started Recording"
    fi
    ;;

  *)
    exit 1
    ;;
  esac
fi

