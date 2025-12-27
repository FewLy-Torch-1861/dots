#!/usr/bin/env bash

NOTIFY_CMD="notify-send -a osd -t 750 -u low -h string:x-canonical-private-synchronous:osd"

case $3 in
nosep)
  $NOTIFY_CMD "$1" "$2"
  ;;
*)
  $NOTIFY_CMD "$1" ": $2"
  ;;
esac
