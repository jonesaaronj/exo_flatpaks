#!/bin/sh

find ${1} -type f \
-not \( \
-path "./release/*" -o \
-path ".*/com.retro_exo.*/export/*" -o \
-path ".*/com.retro_exo.*/*.flatpak" -o \
-path ".*/com.retro_exo.*/.flatpak-builder/*" -o \
-path ".*/com.retro_exo.*/com.retro_exo.*/*" \
\) \
-exec du -sh {} + | sort -h
