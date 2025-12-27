#!/usr/bin/env bash

get-battery() {
  if [[ -f "$BATTERY_PATH/capacity" ]]; then
    cat "$BATTERY_PATH/capacity"
  else
    echo "N/A"
  fi
}

get-uptime() {
  awk '{print int($1/86400)"d "int(($1%86400)/3600)"h "int((($1%86400)%3600)/60)"m"}' /proc/uptime
}

get-cpu-temp() {
  sensors | grep 'Package id 0:' | awk '{print $4}'
}

get-cpu-load() {
  top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}'
}

get-storage-usage() {
  df -h / | grep '/' | awk '{print $3 " / " $2}'
}

get-ram-usage() {
  free -h | grep 'Mem:' | awk '{print $3 " / " $2}' | sed 's/i//g'
}

get-fan-speed() {
  fanspeed=$(sensors | grep 'fan1:' | awk '{print $2}')
  echo "${fanspeed}RPM"
}

get-battery-stats() {
  if [[ -f "$BATTERY_PATH/status" ]]; then
    cat "$BATTERY_PATH/status" | cut -c1
  else
    echo "N/A"
  fi
}

BATTERY_PATH="/sys/class/power_supply/BAT0"

NOTIFY_CMD="notify-send -u low -h string:x-canonical-private-synchronous:sys_stats"

$NOTIFY_CMD " --------------- SYS STATS --------------- " "\
  Storage: $(get-storage-usage)\tRAM: $(get-ram-usage)
 CPU Temp: $(get-cpu-temp)\tCPU Load: $(get-cpu-load)%
  Battery: $(get-battery)% ($(get-battery-stats))\tFan: $(get-fan-speed)
   Uptime: $(get-uptime)
 ----------------------------------------- 
"
