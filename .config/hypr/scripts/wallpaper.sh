#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/env.sh"

pkill rofi || true

ROFI_CMD=(rofi -dmenu -i -p "󰸉 " -show-icons -theme "${ROFI_THEME_WALLPAPER}")

WALLPAPER_DIR="$HOME"/Pictures/Wallpapers

if [[ $1 == "waybar" ]]; then
  ROFI_CMD+=(-theme-str "${ROFI_WAYBAR_POS}")
fi

choice=$(find "${WALLPAPER_DIR}" -type f | while read -r file; do
  filename=$(basename "$file")
  echo -en "${filename}\0icon\x1f${file}\n"
done | "${ROFI_CMD[@]}")

if [[ -n "$choice" ]]; then
  swww img -t random --transition-duration 2 --transition-step 100 --transition-fps 60 "${WALLPAPER_DIR}"/"${choice}"
fi
