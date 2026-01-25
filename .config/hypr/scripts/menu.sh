#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/env.sh"

pkill rofi || true

ROFI_CMD=(rofi -dmenu -i -p " " -u 4 -theme "${ROFI_THEME_MENU}")

if [[ $1 == "waybar" ]]; then
  ROFI_CMD+=(-theme-str "${ROFI_WAYBAR_POS}")
fi

OPTIONS=(
  " Apps"
  " Files"
  " Clipboard"
  " Settings"
  "⏻ Power"
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
    "${SCRIPT_DIR}/clipboard.sh" "$@"
    ;;

  "${OPTIONS[3]}")
    "${SCRIPT_DIR}/settings.sh" "$@"
    ;;

  "${OPTIONS[4]}")
    "${SCRIPT_DIR}/power.sh" "$@"
    ;;
  *)
    exit 1
    ;;
  esac
fi
