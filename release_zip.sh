#!/bin/bash

mkdir -p zip

for dir in ./release/*/; do    
    dir=${dir%/}
    echo "Zipping ${dir}"
    dirName=$(basename "${dir}")
    tar -C "${dir}" -czvf "./zip/${dirName}.tar.gz" .
done
