#!/usr/bin/env bash

pkill -SIGUSR1 waybar
hyprctl dispatch settiled
hyprctl dispatch fullscreenstate 2