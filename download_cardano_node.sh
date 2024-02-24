#!/bin/bash

# Function to display usage information
display_usage() {
    echo "Usage: $0 [-v version]"
    echo "If version is not provided, the latest release will be downloaded."
}

# Parse command line options
while getopts ":v:" opt; do
    case $opt in
        v)
            version="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            display_usage
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            display_usage
            exit 1
            ;;
    esac
done

# Download the Cardano Node release
download_url="https://github.com/IntersectMBO/cardano-node/releases/download/${version}/cardano-node-${version}-linux.tar.gz"
temp_dir=$(mktemp -d)

echo "Downloading Cardano Node ${version}..."
wget -qO "${temp_dir}/cardano-node-${version}.tar.gz" "${download_url}"

# Extract and install
echo "Extracting and installing..."
tar -xzf "${temp_dir}/cardano-node-${version}.tar.gz" -C "${temp_dir}"

# Get the extracted directory name
extracted_dir=$(tar -tzf "${temp_dir}/cardano-node-${version}.tar.gz" | head -1 | cut -f1 -d'/')

# Move to /usr/local/bin/cardano-node
sudo mv "${temp_dir}/${extracted_dir}" /usr/local/bin/cardano-node

# Add to PATH
if ! grep -q "/usr/local/bin/cardano-node" ~/.bashrc; then
    echo "Adding Cardano Node to PATH..."
    echo "export PATH=\$PATH:/usr/local/bin/cardano-node" >> ~/.bashrc
    source ~/.bashrc
fi

echo "Cardano Node ${version} has been successfully installed and added to PATH."
