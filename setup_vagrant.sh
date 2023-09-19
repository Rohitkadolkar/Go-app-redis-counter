#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if Vagrant is installed, and if not, install it
install_vagrant() {
  if ! command_exists vagrant; then
    echo "Vagrant is not installed. Installing Vagrant..."

    # Install Vagrant using the official installer
    if [ "$(uname -s)" = "Linux" ]; then
      # Linux installation
      sudo apt update
      sudo apt install vagrant -y
    elif [ "$(uname -s)" = "Darwin" ]; then
      # macOS installation
      brew cask install vagrant
    else
      echo "Unsupported operating system. Please install Vagrant manually: https://www.vagrantup.com/downloads.html"
      exit 1
    fi

    echo "Vagrant has been installed."
  fi
}

# Error check and exit on failure
check_command() {
  if ! command_exists "$1"; then
    echo "Error: $1 is not installed. Please install it and rerun the script."
    exit 1
  fi
}

# Install Vagrant if not already installed
install_vagrant

# Check if VirtualBox is installed
check_command VBoxManage

# Define the Vagrant box name and URL (adjust as needed)
BOX_NAME="ubuntu/bionic64"
BOX_URL="https://app.vagrantup.com/ubuntu/boxes/bionic64"

# Initialize the Vagrant environment if not already initialized
if [ ! -f V

