#!/usr/bin/env bash

pkill -USR2 waybar
pkill -USR2 kitty

pkill hypridle | true && hypridle

makoctl reload
hyprctl reload

if [[ $1 == "hard" ]]; then
  pkill waybar || true && waybar
  pkill mako || true && mako daemon
  rm -rf "$HOME"/.cache/thumbnails/wallpapers/*
  chmod +x ~/.config/hypr/scripts/*
fi
