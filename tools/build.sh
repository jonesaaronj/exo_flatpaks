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
pkg="${dir##*/}"
echo "dir: ${dir}"
echo "pkg: ${pkg}"

pushd $dir

[ -f "${pkg}.json" ] && manifest="${pkg}.json" 
[ -f "${pkg}.yaml" ] && manifest="${pkg}.yaml" 
[ -f "${pkg}.yml" ] && manifest="${pkg}.yml" 
echo "using manifest: $manifest"

run_command "flatpak run org.flatpak.Builder --disable-rofiles-fuse --install-deps-from=flathub --force-clean ${pkg} ${manifest}"
run_command "flatpak build-export export ${pkg}"
run_command "flatpak build-bundle export ${pkg}.flatpak ${pkg} --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo"

popd

