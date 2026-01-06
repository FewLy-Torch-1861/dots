#!/usr/bin/env bash

tmp_file=$(mktemp)
trap 'rm -f "$tmp_file"' EXIT

kitty --class 'wallpaper-picker' yazi "$HOME/Pictures/Wallpapers" --chooser-file="$tmp_file"

if [ -s "$tmp_file" ]; then
  wallpaper_path=$(cat "$tmp_file")

  if [ -n "$wallpaper_path" ] && [ -f "$wallpaper_path" ]; then
    echo -e "splash = false\n\nwallpaper {\n  monitor = \n  path = ${wallpaper_path}\n  fit_mode = cover\n}\n" >~/.config/hypr/hyprpaper.conf
    pkill hyprpaper | true && hyprpaper &
    disown
    ln -sf "${wallpaper_path}" ~/.config/current_wallpaper
  fi
fi
