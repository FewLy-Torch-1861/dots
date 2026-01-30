#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/env.sh"

pkill rofi || true

ROFI_CMD=(rofi -modi emoji -show emoji -theme "${ROFI_THEME_BASE}" -theme-str "${ROFI_SIZE_EMOJI}")

if [[ $1 == "waybar" ]]; then
  ROFI_CMD+=(-theme-str "${ROFI_WAYBAR_POS}")
fi

"${ROFI_CMD[@]}"
