#!/bin/bash
set -e

package_installed() {
    dpkg -l | grep -q "^ii\s*$1\s"
}

run_with_sudo() {
    if [ "$EUID" -ne 0 ]; then
        sudo "$@"
    else
        "$@"
    fi
}

if ! package_installed vagrant; then
    echo "Installing Vagrant..."
    run_with_sudo apt-get update
    run_with_sudo apt-get install -y vagrant
else
    echo "Vagrant is already installed."
fi

if ! package_installed virtualbox; then
    echo "Installing VirtualBox..."
    run_with_sudo apt-get update
    run_with_sudo apt-get install -y virtualbox
else
    echo "VirtualBox is already installed."
fi

if ! vagrant box list | grep -q "ubuntu/bionic64"; then
    echo "Adding 'ubuntu/bionic64' Vagrant box..."
    vagrant box add ubuntu/bionic64
else
    echo "'ubuntu/bionic64' Vagrant box is already added."
fi

if [ ! -f Vagrantfile ]; then
    echo "Initializing Vagrant environment..."
    vagrant init ubuntu/bionic64
else
    echo "Vagrant environment is already initialized."
fi

if ! vagrant status | grep -q "running"; then
    echo "Starting the Vagrant VM..."
    vagrant up
else
    echo "Vagrant VM is already running."
fi


echo "Vagrant setup completed."
