#!/bin/sh
# Script pour appliquer la palette de couleurs Nord au TTY Linux

# Couleurs de base
nord0="#2E3440"  # black
nord1="#3B4252"  # brblack
nord2="#434C5E"
nord3="#4C566A"
nord4="#D8DEE9"  # white
nord5="#E5E9F0"
nord6="#ECEFF4"  # brwhite

# Couleurs
nord7="#8FBCBB"  # cyan
nord8="#88C0D0"  # brcyan
nord9="#81A1C1"  # blue
nord10="#5E81AC" # brblue
nord11="#BF616A" # red
nord12="#D08770" # brred
nord13="#EBCB8B" # yellow
nord14="#A3BE8C" # green
nord15="#B48EAD" # magenta

# Utilise les séquences d'échappement pour redéfinir la palette
# ]P0... définit la couleur 0, ]P1... la couleur 1, etc.
for i in $(seq 0 15); do
    color_var=$(printf "nord%d" "$i")
    hex_color=$(eval echo "$"$color_var | sed "s/#//")
    printf "\033]P%x%s" "$i" "$hex_color"
done

clear
