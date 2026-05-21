#!/bin/bash

run_command () {
    echo "$1"
    eval "$1"
}

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

arch="${1}"
dir="${2%/}"
pkg="${3}"
release="${4%/}"
echo "dir: ${dir}"
echo "pkg: ${pkg}"
echo "release: ${release}"

run_command "mkdir -p ${release}"

run_command "cp -f ${dir}/${pkg}.${arch}.flatpak ${release}/${pkg}.${arch}.flatpak"