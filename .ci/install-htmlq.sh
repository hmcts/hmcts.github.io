#!/usr/bin/env bash

wget https://github.com/mgdm/htmlq/releases/download/v0.4.0/htmlq-x86_64-linux.tar.gz
tar -xzf htmlq-x86_64-linux.tar.gz

if [ command -v sudo &> /dev/null ]; then
  sudo install htmlq /usr/bin/htmlq
else
  install htmlq /usr/bin/htmlq
fi
rm -f htmlq-x86_64-linux.tar.gz
