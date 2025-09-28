#!/usr/bin/env bash

set -xe

sudo pacman -S --noconfirm \
  go \
  nodejs \
  npm

curl -fsSL https://bun.sh/install | bash
