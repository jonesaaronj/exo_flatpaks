#!/bin/bash

dirs=("eXoShared" "eXoDemoScene" "eXoDOS" "eXoScummVM" "eXoWin9x")
arches=("x86_64" "aarch64")

for arch in "${arches[@]}"; do
    ./tools/release_all.sh "${arch}" "eXo" "./release_all"
done

for dir in "${dirs[@]}"; do
    for arch in "${arches[@]}"; do
        ./tools/release_all.sh "${arch}" "${dir}" "./release/${dir}_${arch}"
    done
done