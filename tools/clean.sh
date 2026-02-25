#!/bin/bash

run_command () {
    echo "$1"
    eval "$1"
}

for dir in "${1%/}"/*; do

    dir="${dir%/}"
    pkg="${dir##*/}"
    echo "dir: ${dir}"
    echo "pkg: ${pkg}"

    if [[ "$dir" == *"com.retro_exo"* ]]; then
        run_command "rm -rf ${dir}/${pkg}"
        run_command "rm -rf ${dir}/.flatpak-builder"
        run_command "rm -rf ${dir}/export"
        run_command "rm ${dir}/${pkg}.flatpak"
    fi
done

