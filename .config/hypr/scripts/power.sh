#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/env.sh"

pkill rofi || true

ROFI_CMD=(rofi -dmenu -i -p "⏻ " -u 4 -theme-str "#window { height: 31%; }" -theme "${ROFI_THEME_MENU}")

if [[ $1 == "waybar" ]]; then
  ROFI_CMD+=(-theme-str "${ROFI_WAYBAR_POS}")
fi

OPTIONS=(
  " Lock"
  "󰗽 Logout"
  "󰒲 Sleep"
  "󰜉 Restart"
  "⏻ Shutdown"
)

choice=$(printf '%s\n' "${OPTIONS[@]}" | "${ROFI_CMD[@]}")

if [[ -n "$choice" ]]; then
  case "$choice" in
  "${OPTIONS[0]}")
    hyprlock
    ;;
  "${OPTIONS[1]}")
    hyprctl dispatch exit
    ;;
  "${OPTIONS[2]}")
    systemctl suspend
    ;;
  "${OPTIONS[3]}")
    systemctl reboot
    ;;
  "${OPTIONS[4]}")
    systemctl poweroff
    ;;
  *)
    exit 1
    ;;
  esac
fi
