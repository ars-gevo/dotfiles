#!/bin/sh

while true; do
    BAT=$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null)
    BAT_STAT=$(cat /sys/class/power_supply/BAT1/status 2>/dev/null)
    BRT=$(brightnessctl i | grep -oP '\(\K\d+(?=%\))')
    DATE_TIME=$(date +'%d.%m.%y %H:%M')
    VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d", $2 * 100}')
    MUTE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED)

    if [ "$BAT_STAT" = "Charging" ]; then
        BAT_ICON="󰁹"
    else
        BAT_ICON="󰂎"
    fi

    if [ "$MUTE" -gt 0 ]; then
        VOL_ICON=" "
    else
        VOL_ICON=" "
    fi

    BRT_ICON=" "

    echo "$VOL% $VOL_ICON | $BRT% $BRT_ICON | $BAT% $BAT_ICON | $DATE_TIME"

    sleep 1
done
