#!/bin/bash

dirs=("eXo")
arches=("x86_64" "aarch64")

for dir in "${dirs[@]}"; do    
    for arch in "${arches[@]}"; do
        ./tools/build_all.sh "${arch}" "${dir}" "./release/${dir}_${arch}"
    done
done