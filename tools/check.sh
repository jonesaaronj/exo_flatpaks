#!/bin/bash

for dir in "${1%/}"/*; do
    dir=${dir%/}
    pkg="${dir##*/}"
    if [[ "$dir" == *"com.retro_exo"* ]]; then
        if ! [ -d "${dir}/export" ]; then
            echo "${pkg} missing export"
        fi
        if ! [ -f "${dir}/${pkg}.flatpak" ]; then
            echo "${pkg} missing flatpak"
        fi
    fi
done

