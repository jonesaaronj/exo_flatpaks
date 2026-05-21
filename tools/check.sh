#!/bin/bash

arch="${1}"
for dir in "${2%/}"/*; do
    dir=${dir%/}
    pkg="${dir##*/}"
    if [[ "$dir" == *"com.retro_exo"* ]]; then
        if ! [ -d "${dir}/export_${arch}" ]; then
            echo "${pkg} missing export_${arch}"
        fi
        if ! [ -f "${dir}/${pkg}.${arch}.flatpak" ]; then
            echo "${pkg} missing ${arch}.flatpak"
        fi
    fi
done
