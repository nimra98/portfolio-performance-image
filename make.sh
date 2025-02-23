#!/bin/bash

# Check if VERSION is provided
if [ -z "$1" ]; then
    echo "Usage: $0 VERSION"
    exit 1
fi

VERSION=$1

sudo make release-amd64 VERSION=$VERSION LATEST=true PACKAGING=pponly
sudo make release-amd64 VERSION=$VERSION LATEST=true PACKAGING=nextcloud
sudo make release-amd64 VERSION=$VERSION LATEST=true PACKAGING=firefox
sudo make release-amd64 VERSION=$VERSION LATEST=true PACKAGING=firefox-nextcloud

sudo make release-arm64 VERSION=$VERSION LATEST=true PACKAGING=pponly
sudo make release-arm64 VERSION=$VERSION LATEST=true PACKAGING=nextcloud
sudo make release-arm64 VERSION=$VERSION LATEST=true PACKAGING=firefox
sudo make release-arm64 VERSION=$VERSION LATEST=true PACKAGING=firefox-nextcloud