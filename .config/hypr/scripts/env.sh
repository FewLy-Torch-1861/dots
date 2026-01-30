#!/usr/bin/env bash
# shellcheck disable=SC2034

# Rofi Environment Variables
SCRIPT_DIR="$HOME/.config/hypr/scripts"

# Theme Definitions
ROFI_THEME_BASE="$HOME/.config/rofi/themes/mine.rasi"
ROFI_THEME_WALLPAPER="$HOME/.config/rofi/themes/wallpaper.rasi"

# Window Sizing
ROFI_SIZE_MENU='window { width: 20%; height: 40%; }'
ROFI_SIZE_POWER='window { width: 20%; height: 31%; }'
ROFI_SIZE_SETTINGS='window { width: 20%; height: 36%; }'
ROFI_SIZE_CAPTURE='window { width: 20%; height: 26%; }'
ROFI_SIZE_CLIPBOARD='window { width: 30%; height: 50%; }'
ROFI_SIZE_EMOJI='window { width: 30%; height: 50%; }'
ROFI_SIZE_WALLPAPER='window { width: 99%; height: 72%; }'

# Waybar Positioning (Top Left)
ROFI_WAYBAR_POS='#window { anchor: north west; location: north west; x-offset: 6px; y-offset: 6px; }'

HYPRSHOT_DIR="$HOME/Pictures/Screenshots/"
