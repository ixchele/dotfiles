#!/bin/bash

echo "Calculating cache size..."

cache_dirs=(
    "$HOME/.cache"
    "$HOME/.config/Code/Cache"
    "$HOME/.config/Code/CachedData"
    "$HOME/.var/app/com.google.Chrome/cache"
    "$HOME/.config/Code/CachedExtensionVSIXs"
    "$HOME/.var/app/org.mozilla.firefox/cache"
    "$HOME/.var/app/com.visualstudio.code/config/Code/Cache"
    "$HOME/.var/app/com.visualstudio.code/config/Code/CachedData"
    "$HOME/.var/app/com.visualstudio.code/config/Code/CachedExtensionVSIXs"
)

get_total_size() {
  total=0
  for dir in "${cache_dirs[@]}"; do
    if [ -d "$dir" ]; then
      size=$(du -sb "$dir" 2>/dev/null | cut -f1)
      total=$((total + size))
    fi
  done
  echo $total
}

size_before=$(get_total_size)

echo "Clearing cache..."

for dir in "${cache_dirs[@]}"; do
  if [ -d "$dir" ]; then
    rm -rf "$dir"/*
  fi
done

size_after=$(get_total_size)

color="\033[0m"
if [ "$size_before" -gt "$size_after" ]; then
  color="\033[32m"
else
  color="\033[0m"
fi

freed=$(( (size_before - size_after) / 1024 / 1024 ))

echo "✅ Cache cleared."
echo -e "🧹 Freed approximately $color$freed\033[0m MB of space."
