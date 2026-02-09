#!/usr/bin/env bash

source "$HOME/.config/hypr/scripts/env.sh"

pkill rofi || true

ROFI_CMD=(rofi -dmenu -i -theme "${ROFI_THEME_BASE}" -theme-str "${ROFI_SIZE_SETTINGS}")

if [[ $1 == "waybar" ]]; then
  ROFI_CMD+=(-theme-str "${ROFI_WAYBAR_POS}")
fi

SETTING_OPTIONS=(
  " Appearance"
  "󰍹 Displays"
  "󰕾 Audio"
  "󰂯 Bluetooth"
  "󰤨 Network"
  " Reload"
)

choice=$(printf '%s\n' "${SETTING_OPTIONS[@]}" | "${ROFI_CMD[@]}" -a 5 -p " ")

if [[ -n "$choice" ]]; then
  case "$choice" in
  "${SETTING_OPTIONS[0]}")
    APPEARANCE_OPTIONS=(
      "󰸉 Wallpaper"
      " GTK"
    )

    app_choice=$(printf '%s\n' "${APPEARANCE_OPTIONS[@]}" | "${ROFI_CMD[@]}" -p " ")

    if [[ -n "$app_choice" ]]; then
      case "$app_choice" in
      "${APPEARANCE_OPTIONS[0]}")
        "${SCRIPT_DIR}/wallpaper.sh" "$@"
        ;;
      "${APPEARANCE_OPTIONS[1]}")
        nwg-look
        ;;
      esac
    fi
    ;;

  "${SETTING_OPTIONS[1]}")
    nwg-displays
    ;;
  "${SETTING_OPTIONS[2]}")
    kitty -1 --class pulsemixer -- pulsemixer
    ;;
  "${SETTING_OPTIONS[3]}")
    kitty -1 --class bluetui -- bluetui
    ;;
  "${SETTING_OPTIONS[4]}")
    kitty -1 --class impala -- impala
    ;;
  "${SETTING_OPTIONS[5]}")
    "${SCRIPT_DIR}/reload.sh"
    ;;
  *)
    exit 1
    ;;
  esac
fi
