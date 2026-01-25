#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/env.sh"

pkill rofi || true

# ROFI_CMD=(rofi -dmenu -i -p "󰸉 " -show-icons -theme "${ROFI_THEME_WALLPAPER}")
ROFI_CMD=(rofi -dmenu -i -p "󰸉 " -show-icons -theme "${ROFI_THEME_MENU}")

WALLPAPER_DIR="$HOME"/Pictures/Wallpapers

if [[ $1 == "waybar" ]]; then
  ROFI_CMD+=(-theme-str "${ROFI_WAYBAR_POS}")
fi

choice=$(find "${WALLPAPER_DIR}" -type f -printf "%P\n" | "${ROFI_CMD[@]}")

swww img -t random --transition-duration 2 --transition-step 100 --transition-fps 60 "${WALLPAPER_DIR}"/"${choice}"
