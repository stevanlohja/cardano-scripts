#!/bin/bash

# Default Cardano Node version
CARDANO_NODE_VERSION="8.7.3"

# Parse command line options
while getopts ":v:" opt; do
  case ${opt} in
    v )
      CARDANO_NODE_VERSION="${OPTARG}"
      ;;
    \? )
      echo "Usage: $0 [-v cardano_node_version]" >&2
      exit 1
      ;;
  esac
done

# Define the download URL
DOWNLOAD_URL="https://github.com/IntersectMBO/cardano-node/releases/download/${CARDANO_NODE_VERSION}/cardano-node-${CARDANO_NODE_VERSION}-linux.tar.gz"

# Define the temporary directory for extraction
TEMP_DIR="/tmp/cardano-node-${CARDANO_NODE_VERSION}"

# Create the temporary directory
mkdir -p "${TEMP_DIR}"

# Navigate to the temporary directory
cd "${TEMP_DIR}"

# Download the Cardano Node binary archive
echo "Downloading Cardano Node binary archive..."
wget "${DOWNLOAD_URL}"

# Extract the contents
echo "Extracting archive..."
tar -xzf "cardano-node-${CARDANO_NODE_VERSION}-linux.tar.gz"

# Move binaries to /usr/bin
echo "Moving binaries to /usr/bin..."
sudo mv "cardano-node-${CARDANO_NODE_VERSION}-linux/cardano-node" "/usr/bin/"
sudo mv "cardano-node-${CARDANO_NODE_VERSION}-linux/cardano-cli" "/usr/bin/"

# Clean up temporary files
echo "Cleaning up..."
rm -rf "${TEMP_DIR}"

echo "Cardano Node ${CARDANO_NODE_VERSION} has been installed successfully!"