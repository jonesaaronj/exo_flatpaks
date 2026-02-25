#!/bin/bash

run_command() {
    echo "$1"
    eval "$1"
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for dir in "${1%/}"/*; do

    dir="${dir%/}"
    pkg="${dir##*/}"
    release="${2%/}"
    echo "dir: ${dir}"
    echo "pkg: ${pkg}"
    echo "release: ${release}"

    if [[ "${dir}" == *"com.retro_exo"* ]]; then
        if [ ! -f "${dir}/${pkg}.flatpak" ]; then
            $SCRIPT_DIR/build.sh "${dir}"
        fi
        $SCRIPT_DIR/release.sh "${dir}" "${pkg}" "${release}"    
    fi
done

