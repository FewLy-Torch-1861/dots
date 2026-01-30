#!/usr/bin/env bash

pkill -USR2 waybar
pkill -USR1 kitty

pkill hypridle | true && hypridle

makoctl reload
hyprctl reload

chmod +x ~/.config/hypr/scripts/*

if [[ $1 == "hard" ]]; then
  pkill waybar || true && waybar
  pkill mako || true && mako daemon
  rm -rf "$HOME"/.cache/thumbnails/wallpapers/*
fi
