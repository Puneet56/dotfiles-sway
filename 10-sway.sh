#!/usr/bin/env bash

set -xe

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm \
  polkit \
  sway \
  swaybg \
  swaylock \
  swayidle \
  waybar \
  mako \
  grim \
  slurp \
  networkmanager \
  ttf-font-awesome \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-emoji \
  xorg-xwayland \
  brightnessctl \
  git \
  libnotify \
  fuzzel \
  i3blocks \
  iw \
  awesome-terminal-fonts \
  adobe-source-code-pro-fonts \
  less \
  jq \
  power-profiles-daemon \
  python-gobject \
  swayosd

# enable network manager service
sudo systemctl enable --now NetworkManager

# swayosd libinput backend
sudo systemctl enable --now swayosd-libinput-backend.service

# power-profiles-daemon
sudo systemctl enable --now power-profiles-daemon.service
