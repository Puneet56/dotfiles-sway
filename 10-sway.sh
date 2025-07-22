#!/usr/bin/env bash

set -xe

sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm \
  polkit \
  sway \
  swaybg \
  swaylock \
  swayidle \
  wmenu \
  wofi \
  foot \
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
  libnotify

# enable network manager service
sudo systemctl enable --now NetworkManager
