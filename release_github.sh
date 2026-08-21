#!/bin/sh

current_date=$(date +%Y%m%d)
echo "$current_date"

gh release create "flatpaks_$current_date" --target main --title "flatpaks_$current_date"

gh release upload "flatpaks_$current_date" ./release_all/*.flatpak  --clobber
