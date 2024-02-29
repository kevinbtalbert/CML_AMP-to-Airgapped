#!/bin/bash

# This script downloads the PyPi requirements for all downloaded
# repos and enables offline (airgapped) installation of the wheels.
# Ensure chmod +x 3-download-dependencies.sh if error
# RUN: bash 3-download-dependencies.sh

# USAGE: pip install --no-index --find-links=/path/to/pip_packages -r requirements.txt

# Current directory from which the script is run
current_dir=$(pwd)

# Directory to store downloaded packages
packages_dir="${current_dir}/pip_packages"
mkdir -p "$packages_dir"

# Recursively find and process all 'requirements.txt' files
find "$current_dir" -type f -name 'requirements.txt' | while read requirements_file; do
    echo "Processing requirements file: $requirements_file"

    # Directory where the requirements.txt file is located
    requirements_dir=$(dirname "$requirements_file")

    # Download dependencies listed in 'requirements.txt'
    pip download -r "$requirements_file" -d "$packages_dir" --exists-action=i

    echo "Dependencies from $requirements_file have been downloaded to $packages_dir."
done

echo "All dependencies have been downloaded to $packages_dir."
