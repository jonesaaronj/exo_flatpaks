#!/bin/bash

run_command() {
    echo "$1"
    eval "$1"
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

arch="${1}"

for dir in "${2%/}"/*; do

    dir="${dir%/}"
    pkg="${dir##*/}"
    release="${3%/}"
    echo "dir: ${dir}"
    echo "pkg: ${pkg}"
    echo "release: ${release}"

    if [[ "${dir}" == *"com.retro_exo"* ]]; then
    
        $SCRIPT_DIR/build.sh "${arch}" "${dir}"
        $SCRIPT_DIR/release.sh "${arch}" "${dir}" "${pkg}" "${release}"
    fi
done
