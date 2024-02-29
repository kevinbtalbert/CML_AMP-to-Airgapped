#!/bin/bash

# This script downloads the official and/or community AMP 
# repos from the Cloudera and associated repos.
# If there are any AMPs you do NOT wish to be downloaded, 
# modify the YAMLs downloaded from the first script and remove them.
# Ensure chmod +x 1-download-repos.sh if error

# Function to clone repositories from a YAML file
clone_repos_from_yaml() {
    local yaml_file=$1

    if [ ! -f "$yaml_file" ]; then
        echo "YAML file does not exist: $yaml_file"
        return 1
    fi

    echo "Processing $yaml_file..."

    # Parse and clone repositories
    yq e '.items[].spec.git_url' "$yaml_file" | while read git_url; do
        if [ ! -z "$git_url" ]; then
            repo_name=$(basename -s .git "$git_url")
            echo "Downloading $repo_name from $git_url..."
            git clone "$git_url" "/root/$repo_name"
        fi
    done
}

download_date=$(date +%Y-%m-%d)

if [ "$#" -eq 0 ]; then
    # No parameters provided; use default files
    echo "No parameters provided. Looking for YAML files in /root..."
    for prefix in official community; do
        default_yaml_file="/root/${prefix}-amp-catalog-${download_date}.yaml"
        if [ -f "$default_yaml_file" ]; then
            clone_repos_from_yaml "$default_yaml_file"
        else
            echo "File not found: $default_yaml_file"
        fi
    done
else
    # Process provided YAML files
    for yaml_file in "$@"; do
        clone_repos_from_yaml "$yaml_file"
    done
fi
