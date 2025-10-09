#!/bin/bash
set -e

# Function to print colored messages
print() {
  echo -e "\e[1;32m$1\e[0m"
}

print "==> Updating system..."
sudo pacman -Syu --noconfirm

print "==> Installing Docker and Docker Compose..."
sudo pacman -S --noconfirm docker docker-compose

print "==> Enabling and starting Docker service..."
sudo systemctl enable docker.service
sudo systemctl start docker.service

print "==> Adding user '$USER' to docker group..."
sudo usermod -aG docker "$USER"

print "==> Docker installation complete."
print "==> Please log out and back in (or run 'newgrp docker') to apply user group changes."

print "==> Testing Docker setup..."
docker --version || echo "Docker command will work after re-login."
docker-compose --version || echo "Docker Compose command will work after re-login."

print "==> Installing lazydocker..."
sudo pacman -S --noconfirm lazydocker

print "✅ All done! You can now use Docker without sudo after re-login."
