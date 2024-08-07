#!/usr/bin/env bash
set -ex

apt-get update
apt-get install -y wget curl

wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
apt-get update
apt-get install -y azcopy
rm -f packages-microsoft-prod.deb
