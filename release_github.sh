#!/bin/sh

TODAY=$(date +%Y%m%d)
RELEASE="flatpaks_${TODAY}"
echo ${RELEASE}

gh release create "${RELEASE}" --title "${RELEASE}" --generate-notes
gh release upload "${RELEASE}" ./release_all/*.flatpak  --clobber