#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/env.sh"

pkill rofi || true

ROFI_CMD=(rofi -dmenu -i -p " " -theme "${ROFI_THEME_MENU}")

if [[ $1 == "waybar" ]]; then
  ROFI_CMD+=(-theme-str "${ROFI_WAYBAR_POS}")
fi

SETTING_OPTIONS=(
  "󰸉 Wallpaper"
)

choice=$(printf '%s\n' "${SETTING_OPTIONS[@]}" | "${ROFI_CMD[@]}")

if [[ -n "$choice" ]]; then
  case "$choice" in
  "${SETTING_OPTIONS[0]}")
    "${SCRIPT_DIR}/wallpaper.sh" "$@"
    ;;
  *)
    exit 1
    ;;
  esac
fi
