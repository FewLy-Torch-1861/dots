#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/env.sh"

pkill rofi || true

ROFI_CMD=(rofi -dmenu -i -p "⏻ " -u 4 -theme "${ROFI_THEME_MENU}")

if [[ $1 == "waybar" ]]; then
  ROFI_CMD+=(-theme-str "${ROFI_WAYBAR_POS}")
fi

POWER_OPTIONS=(
  " Lock"
  "󰗽 Logout"
  "󰒲 Sleep"
  "󰜉 Restart"
  "⏻ Shutdown"
)

choice=$(printf '%s\n' "${POWER_OPTIONS[@]}" | "${ROFI_CMD[@]}")

if [[ -n "$choice" ]]; then
  case "$choice" in
  "${POWER_OPTIONS[0]}")
    hyprlock
    ;;
  "${POWER_OPTIONS[1]}")
    hyprctl dispatch exit
    ;;
  "${POWER_OPTIONS[2]}")
    systemctl suspend
    ;;
  "${POWER_OPTIONS[3]}")
    systemctl reboot
    ;;
  "${POWER_OPTIONS[4]}")
    systemctl poweroff
    ;;
  *)
    exit 1
    ;;
  esac
fi
