#!/bin/sh

gh release upload "${1}" ./release_all/*.flatpak  --clobber