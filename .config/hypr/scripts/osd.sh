#!/usr/bin/env bash

if [[ "$1" == "--bar" ]]; then
  # Usage: ./osd.sh --bar 50 "Volume"
  value="$2"
  title="$3"
  notify-send -a "osd" -h "int:value:$value" -h "string:x-canonical-private-synchronous:osd" "$title" ": $value%"
else
  # Usage: ./osd.sh "Title" "Description"
  title="$1"
  body="$2"
  notify-send -a "osd" -h "string:x-canonical-private-synchronous:osd" "$title" ": $body"
fi
