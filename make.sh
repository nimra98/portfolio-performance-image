#!/bin/bash

# Check if VERSION and RELEASE_TYPE are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 VERSION RELEASE_TYPE"
    echo "Example: $0 1.0.0 release-amd64"
    echo "Example: $0 1.0.0 release"
    exit 1
fi

VERSION=$1
RELEASE_TYPE=$2

sudo make $RELEASE_TYPE VERSION=$VERSION LATEST=true PACKAGING=pponly
sudo make $RELEASE_TYPE VERSION=$VERSION LATEST=true PACKAGING=nextcloud
sudo make $RELEASE_TYPE VERSION=$VERSION LATEST=true PACKAGING=firefox
sudo make $RELEASE_TYPE VERSION=$VERSION LATEST=true PACKAGING=firefox-nextcloud
