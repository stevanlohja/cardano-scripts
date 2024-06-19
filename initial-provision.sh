#!/bin/bash

# Update and upgrade system packages
sudo apt-get update -y && sudo apt-get upgrade -y

# Install required packages and tools
sudo apt-get install -y automake build-essential pkg-config libffi-dev libgmp-dev \
libssl-dev libtinfo-dev libsystemd-dev zlib1g-dev make g++ tmux git jq wget \
libncursesw5 libtool autoconf

# Install ghcup for GHC and Cabal installation
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Source the environment to use ghcup
source ~/.ghcup/env

# Install and set GHC 8.10.7
ghcup install ghc 8.10.7
ghcup set ghc 8.10.7

# Install and set Cabal 3.6.2.0
ghcup install cabal 3.6.2.0
ghcup set cabal 3.6.2.0

# Check GHC and Cabal versions
ghc --version
cabal --version

# Create working directory for Cardano source code
mkdir -p $HOME/cardano-src
cd $HOME/cardano-src

# Download, compile, and install libsodium
git clone https://github.com/IntersectMBO/libsodium
cd libsodium
git checkout dbb48cc
./autogen.sh
./configure
make
sudo make install

# Set environment variables for libsodium
echo 'export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"' >> ~/.bashrc
echo 'export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"' >> ~/.bashrc
source ~/.bashrc

# Download, compile, and install secp256k1
cd $HOME/cardano-src
git clone https://github.com/bitcoin-core/secp256k1
cd secp256k1
git checkout ac83be33
./autogen.sh
./configure --enable-module-schnorrsig --enable-experimental
make
make check
sudo make install
sudo ldconfig

# Download and set up cardano-node
cd $HOME/cardano-src
git clone https://github.com/IntersectMBO/cardano-node.git
cd cardano-node
git fetch --all --recurse-submodules --tags
git checkout $(curl -s https://api.github.com/repos/IntersectMBO/cardano-node/releases/latest | jq -r .tag_name)

# Configure the build options
cabal configure --with-compiler=ghc-8.10.7
cabal update

# If on a non-x86/x64 platform (e.g., ARM), install and configure LLVM
if [ "$(uname -m)" = "aarch64" ] || [ "$(uname -m)" = "arm64" ]; then
    sudo apt install -y llvm-9 clang-9 libnuma-dev
    sudo ln -s /usr/bin/llvm-config-9 /usr/bin/llvm-config
    sudo ln -s /usr/bin/opt-9 /usr/bin/opt
    sudo ln -s /usr/bin/llc-9 /usr/bin/llc
    sudo ln -s /usr/bin/clang-9 /usr/bin/clang
fi

# Build and install cardano-node and cardano-cli
cabal build all

# Copy binaries to $HOME/.local/bin
mkdir -p $HOME/.local/bin
cp -p "$(./scripts/bin-path.sh cardano-node)" $HOME/.local/bin/
cp -p "$(./scripts/bin-path.sh cardano-cli)" $HOME/.local/bin/

# Add $HOME/.local/bin to PATH
echo 'export PATH="$HOME