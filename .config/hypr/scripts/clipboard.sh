#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/env.sh"

pkill rofi || true

ROFI_CMD=(rofi -dmenu -i -display-columns 2 -p " " -theme "${ROFI_THEME_BASE}" -theme-str "${ROFI_SIZE_CLIPBOARD}")

if [[ $1 == "waybar" ]]; then
  ROFI_CMD+=(-theme-str "${ROFI_WAYBAR_POS}")
fi

cliphist list |
  "${ROFI_CMD[@]}" |
  cliphist decode |
  wl-copy
