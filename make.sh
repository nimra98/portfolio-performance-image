#!/bin/bash
sudo make release VERSION=0.70.4 LATEST=true PACKAGING=pponly
sudo make release VERSION=0.70.4 LATEST=true PACKAGING=nextcloud
sudo make release VERSION=0.70.4 LATEST=true PACKAGING=firefox
sudo make release VERSION=0.70.4 LATEST=true PACKAGING=firefox-nextcloud