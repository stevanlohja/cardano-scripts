#!/bin/bash

# Create directory structure if it doesn't exist: $HOME/.local/bin/cardano-node
mkdir -p $HOME/.local/bin/cardano-node 

# Download and extract cardano-node binary from GitHub release (replace with the actual release link)
curl -L https://github.com/IntersectMBO/cardano-node/releases/download/8.7.3/cardano-node-8.7.3-linux.tar.gz | tar -xz -C $HOME/.local/bin/cardano-node 

# Add the newly installed directory to the PATH by appending to .bashrc
echo 'export PATH=$HOME/.local/bin/cardano-node:$PATH' >> $HOME/.bashrc 

# Update the current terminal session with the new PATH settings
source $HOME/.bashrc