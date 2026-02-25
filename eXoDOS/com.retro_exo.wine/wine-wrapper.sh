#!/bin/bash
export WINEPREFIX="/var/data/wine"
CURRENT_VER="11.0"

# Check if the prefix exists
if [ -d "$WINEPREFIX" ]; then
    # If the version stamp doesn't exist, or doesn't match 11.0, wipe the prefix
    if [ ! -f "$WINEPREFIX/exo_version" ] || [ "$(cat "$WINEPREFIX/exo_version")" != "$CURRENT_VER" ]; then
        echo "Old or incompatible Wine prefix detected. Wiping for a clean update..."
        rm -rf "$WINEPREFIX"
    fi
fi

# Create the prefix directory and stamp it with the current version
mkdir -p "$WINEPREFIX"
echo "$CURRENT_VER" > "$WINEPREFIX/exo_version"

# Hand over execution to Wine
exec wine "$@"
