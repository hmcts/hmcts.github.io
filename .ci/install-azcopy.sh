#!/usr/bin/env bash
set -ex

sudo apt-get update
sudo apt-get install -y wget curl

wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y azcopy
rm -f packages-microsoft-prod.deb
