#!/bin/bash

# Update and upgrade packages
sudo apt update -y && sudo apt upgrade -y

# Install necessary packages
sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Create volumes
mkdir -p "$(pwd)/config" "$(pwd)/db" "$(pwd)/sockets"
cd config

# Download configuration files
config_files=(
    "config.json"
    "db-sync-config.json"
    "submit-api-config.json"
    "topology.json"
    "byron-genesis.json"
    "shelley-genesis.json"
    "alonzo-genesis.json"
    "conway-genesis.json"
)

base_url="https://book.world.dev.cardano.org/environments/preview"

for file in "${config_files[@]}"; do
    curl -O -J "$base_url/$file"
done