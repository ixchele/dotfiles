#!/usr/bin/env bash

# Check if wofi is already running
if pgrep -x "wofi" > /dev/null
then
    exit 0
fi

# Options de menu
list=('Lock' 'Shutdown' 'Reboot' 'Logout' 'Hibernate' 'Suspend')

# Affichage du menu avec Wofi
selected=$(printf '%s\n' "${list[@]}" | wofi --show dmenu --prompt "Power Menu" --lines 7 --style ~/.config/wofi/config)

# Si rien n'est sélectionné, sortir
[[ -z $selected ]] && exit 0

# Actions
case "$selected" in
    'Lock') loginctl lock-session ;;
    'Shutdown') systemctl poweroff ;;
    'Reboot') systemctl reboot ;;
    'Logout') loginctl terminate-session "$XDG_SESSION_ID" ;;
    'Hibernate') systemctl hibernate ;;
    'Suspend') systemctl suspend ;;
esac