#!/bin/bash

# Set the default repository URL
REPO_URL="https://github.com/IntersectMBO/cardano-node"

# Set the default target directory for the binary
TARGET_DIR="$HOME/.local/bin"  # You can change this to your preferred directory

# Function to display usage
usage() {
    echo "Usage: $0 [-r <repository_url>] [-v <version>] [-d <target_directory>]"
    echo "Options:"
    echo "  -r <repository_url>: Specify the repository URL (default: $REPO_URL)"
    echo "  -v <version>: Specify the version to download (default: latest)"
    echo "  -d <target_directory>: Specify the target directory (default: $TARGET_DIR)"
    exit 1
}

# Parse command line options
while getopts "r:v:d:" opt; do
    case $opt in
        r)
            REPO_URL=$OPTARG
            ;;
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
    VERSION=$(curl -sSL $REPO_URL/releases/latest | grep -oP '(?<=tag\/v)[^"]*')
fi

# Download the cardano-node binary
curl -sSLJ -o $TARGET_DIR/cardano-node $REPO_URL/releases/download/$VERSION/cardano-node-$VERSION-linux.tar.gz

# Extract the binary from the tarball
tar -xzf $TARGET_DIR/cardano-node-$VERSION-linux.tar.gz -C $TARGET_DIR --strip-components=2 cardano-node-$VERSION-linux/cardano-node

# Set executable permissions
chmod +x $TARGET_DIR/cardano-node

# Clean up the downloaded tarball
rm $TARGET_DIR/cardano-node-$VERSION-linux.tar.gz

# Verify the installation
cardano-node --version