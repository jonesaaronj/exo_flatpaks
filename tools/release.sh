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

dir="${1%/}"
pkg="${2}"
release="${3%/}"
echo "dir: ${dir}"
echo "pkg: ${pkg}"
echo "release: ${release}"

run_command "mkdir -p ${release}"
run_command "cp -f ${dir}/${pkg}.flatpak ${release}/${pkg}.flatpak"
