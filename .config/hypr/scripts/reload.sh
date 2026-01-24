#!/usr/bin/env bash

pkill waybar || true && waybar
pkill -USR2 kitty

makoctl reload
hyprctl reload

chmod +x ~/.config/hypr/scripts/*