#!/usr/bin/env bash

pkill rofi || true

cliphist list |
  rofi -dmenu -display-columns 2 -p " " -theme ~/.config/rofi/themes/clipboard.rasi |
  cliphist decode |
  wl-copy
