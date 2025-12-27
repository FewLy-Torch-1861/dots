#!/usr/bin/env bash

OSD=~/.config/hypr/scripts/osd.sh

switch_lang() {
  hyprctl \
    --batch "$(
      hyprctl devices -j |
        jq -r '.keyboards[] | .name' |
        while IFS= read -r keyboard; do
          printf '%s %s %s;' 'switchxkblayout' "${keyboard}" 'next'
        done
    )"
}

get_lang() {
  hyprctl devices -j |
    jq -r '.keyboards[] | .active_keymap' |
    head -n1 |
    cut -c1-2 |
    tr 'a-z' 'A-Z'
}

switch_lang
$OSD "Layout" "$(get_lang)"
