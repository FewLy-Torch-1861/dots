#!/usr/bin/env bash

OSD=~/.config/hypr/scripts/osd.sh

if pgrep -x "gpu-screen-reco" >/dev/null; then
  pkill -SIGINT -f gpu-screen-reco
  $OSD "Stopped Recording" -- nosep
else
  gpu-screen-recorder -w screen -f 60 -a default_output -o ~/Videos/Recorded/Record-"$(date +%y-%m-%d_%H-%M-%S)".mp4 &
  $OSD "Started Recording" -- nosep
fi

