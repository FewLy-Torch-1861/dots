#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/env.sh"

pkill rofi || true

ROFI_CMD=(rofi -dmenu -i -p "󰸉 " -show-icons -theme "${ROFI_THEME_WALLPAPER}" -theme-str "${ROFI_SIZE_WALLPAPER}")

WALLPAPER_DIR="$HOME"/Pictures/Wallpapers
CACHE_DIR="$HOME/.cache/thumbnails/wallpapers"

if [[ ! -d "$CACHE_DIR" ]]; then
  mkdir -p "$CACHE_DIR"
fi

if [[ $1 == "waybar" ]]; then
  ROFI_CMD+=(-theme-str "${ROFI_WAYBAR_POS}")
fi

choice=$( {
  echo -en "Random\0icon\x1fmedia-playlist-shuffle\n"
  find "${WALLPAPER_DIR}" -type f | while read -r file; do
    filename="${file#"$WALLPAPER_DIR"/}"

    hash=$(echo -n "$file" | md5sum | cut -d' ' -f1)
    thumb="${CACHE_DIR}/${hash}.png"

    if [ ! -f "$thumb" ]; then
      magick "$file" -thumbnail '500x500>' -strip "$thumb"
    fi

    echo -en "${filename}\0icon\x1f${thumb}\n"
  done
} | "${ROFI_CMD[@]}")

if [[ "$choice" == "Random" ]]; then
  choice=$(find "${WALLPAPER_DIR}" -type f | shuf -n 1)
  choice="${choice#"$WALLPAPER_DIR"/}"
fi

if [[ -n "$choice" ]]; then
  swww img -t any --transition-duration 2 --transition-step 100 --transition-fps 60 "${WALLPAPER_DIR}"/"${choice}"
fi
