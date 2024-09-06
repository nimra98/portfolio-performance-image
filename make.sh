#!/bin/bash
sudo make release VERSION=0.70.4 LATEST=true TARGETARCH=amd64 PACKAGING=pponly ARCHITECTURE=linux.gtk.x86_64
sudo make release VERSION=0.70.4 LATEST=true TARGETARCH=amd64 PACKAGING=nextcloud ARCHITECTURE=linux.gtk.x86_64
sudo make release VERSION=0.70.4 LATEST=true TARGETARCH=amd64 PACKAGING=firefox ARCHITECTURE=linux.gtk.x86_64
sudo make release VERSION=0.70.4 LATEST=true TARGETARCH=amd64 PACKAGING=firefox-nextcloud ARCHITECTURE=linux.gtk.x86_64

# ARM
sudo make release VERSION=0.70.4 LATEST=true TARGETARCH=arm64 PACKAGING=pponly ARCHITECTURE=linux.gtk.aarch64
sudo make release VERSION=0.70.4 LATEST=true TARGETARCH=arm64 PACKAGING=nextcloud ARCHITECTURE=linux.gtk.aarch64
sudo make release VERSION=0.70.4 LATEST=true TARGETARCH=arm64 PACKAGING=firefox ARCHITECTURE=linux.gtk.aarch64
sudo make release VERSION=0.70.4 LATEST=true TARGETARCH=arm64 PACKAGING=firefox-nextcloud ARCHITECTURE=linux.gtk.aarch64
