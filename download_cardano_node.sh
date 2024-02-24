#!/bin/bash

# Set the default repository URL
REPO_URL="https://github.com/IntersectMBO/cardano-node"

# Set the default target directory for the binary
TARGET_DIR="$HOME/.local/bin"  # You can change this to your preferred directory

# Function to display usage
usage() {
    echo "Usage: $0 [-v <version>] [-d <target_directory>]"
    echo "Options:"
    echo "  -v <version>: Specify the version to download (default: latest)"
    echo "  -d <target_directory>: Specify the target directory (default: $TARGET_DIR)"
    exit 1
}

# Parse command line options
while getopts "v:d:" opt; do
    case $opt in
        v)
            VERSION=$OPTARG
            ;;
        d)
            TARGET_DIR=$OPTARG
            ;;
        *)
            usage
            ;;
    esac
done

# Create the target directory if it doesn't exist
mkdir -p $TARGET_DIR

# If version is not specified, get the latest release version from GitHub
if [ -z "$VERSION" ]; then
    VERSION=$(curl -sSL $REPO_URL/releases/latest | grep -oP '(?<=cardano-node-)[^"]*')
fi

# Download the cardano-node binary and extract
curl -sSL $REPO_URL/releases/download/$VERSION/cardano-node-$VERSION-linux.tar.gz | tar -xz -C $TARGET_DIR --strip-components=1

# Set executable permissions
chmod +x $TARGET_DIR/cardano-node

# Add the target directory to the PATH
echo "export PATH=\$PATH:$TARGET_DIR" >> $HOME/.bashrc
source $HOME/.bashrc  # Update the current session

# Verify the installation
cardano-node --version