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
pkg="${dir##*/}"
echo "dir: ${dir}"
echo "pkg: ${pkg}"

pushd $dir

[ -f "${pkg}.json" ] && manifest="${pkg}.json" 
[ -f "${pkg}.yaml" ] && manifest="${pkg}.yaml" 
[ -f "${pkg}.yml" ] && manifest="${pkg}.yml" 
echo "using manifest: $manifest"

run_command "flatpak run org.flatpak.Builder --user --install-deps-from=flathub --force-clean --arch=${arch} ${pkg}_${arch} ${manifest}"
run_command "flatpak build-export --arch=${arch} export_${arch} ${pkg}_${arch}"
run_command "flatpak build-bundle --arch=${arch} export_${arch} ${pkg}.${arch}.flatpak ${pkg} --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo"

popd
