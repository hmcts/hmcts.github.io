#!/usr/bin/env bash

wget https://github.com/mgdm/htmlq/releases/download/v0.4.0/htmlq-x86_64-linux.tar.gz
tar -xzf htmlq-x86_64-linux.tar.gz
sudo install htmlq /usr/bin/htmlq
rm -f htmlq-x86_64-linux.tar.gz
