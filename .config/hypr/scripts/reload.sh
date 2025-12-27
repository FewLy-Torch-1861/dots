#!/usr/bin/env bash

OSD=~/.config/hypr/scripts/osd.sh

# Reload waybar and start if it die
if ! pgrep -x waybar >/dev/null; then
  waybar &
  exit 0
fi
pkill -SIGUSR2 waybar &

# Reload hypridle
pkill hypridle || true && hypridle &

# Start hyprpaper if it die
if ! pgrep -x hyprpaper >/dev/null; then
  hyprpaper &
  exit 0
fi
pkill -f wal.sh &

# Reload kitty config
pkill -SIGUSR1 kitty &

# Reload mako config
makoctl reload &

# Reload hyprland config
hyprctl reload &

# Maxout brightness
brightnessctl -e4 -n2 set 100% &

$OSD "Reloaded" -- nosep

