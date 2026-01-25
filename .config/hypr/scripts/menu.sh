#!/usr/bin/env bash

pkill rofi || true

SCRIPT_DIR=~/.config/hypr/scripts
ROFI_THEME=~/.config/rofi/themes/menu.rasi

ROFI_CMD=(rofi -dmenu -p " " -no-show-icons -theme "${ROFI_THEME}")

if [[ $1 == "waybar" ]]; then
  ROFI_CMD+=(-theme-str '#window { anchor: north west; location: north west; x-offset: 6px; y-offset: 6px;}')
fi

OPTIONS=(
  " Apps"
  " Files"
  " Clipboard"
  " Settings"
  "⏻ Power"
)

SETTING_OPTIONS=(
  "󰸉 Wallpaper"
)

POWER_OPTIONS=(
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
    rofi -show drun -show-icons
    ;;

  "${OPTIONS[1]}")
    rofi -modi filebrowser -show-icons -show filebrowser
    ;;

  "${OPTIONS[2]}")
    ${SCRIPT_DIR}/clipboard.sh
    ;;

  "${OPTIONS[3]}")
    choice=$(printf '%s\n' "${SETTING_OPTIONS[@]}" | "${ROFI_CMD[@]}")

    if [[ -n "$choice" ]]; then
      case "$choice" in
      "${SETTING_OPTIONS[0]}")
        notify-send -u low "WIP"
        ;;

      *)
        exit 1
        ;;
      esac
    fi
    ;;

  "${OPTIONS[4]}")
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
    ;;
  *)
    exit 1
    ;;
  esac
fi
