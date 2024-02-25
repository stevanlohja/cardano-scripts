#!/bin/bash

# Set default values
release_url=""

# Parse command-line options
while getopts ":url:" opt; do
  case $opt in
    u)
      release_url="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Check if the release URL is provided
if [ -z "$release_url" ]; then
  echo "Usage: $0 -url <release_url>"
  exit 1
fi

install_dir="/usr/bin"

# Change to the installation directory
cd "$install_dir" || exit

# Download the Cardano Node release
sudo wget "$release_url"

# Extract the contents
sudo tar -xvzf "$(basename "$release_url")"

# Remove the downloaded tar.gz file if you want to save space
sudo rm "$(basename "$release_url")"