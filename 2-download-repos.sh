#!/bin/bash

# This script downloads the official and/or community AMP 
# repos from the Cloudera and associated repos.
# If there are any AMPs you do NOT wish to be downloaded, 
# modify the YAMLs downloaded from the first script and remove them.
# Ensure chmod +x 2-download-repos.sh if error
# RUN: bash 2-download-repos.sh

clone_repos_from_yaml() {
    local yaml_file=$1
    local repos_dir="repositories"  # Define the directory to store repositories

    # Ensure the repositories directory exists
    mkdir -p "$repos_dir"

    if [ ! -f "$yaml_file" ]; then
        echo "YAML file does not exist: $yaml_file"
        return 1
    fi

    echo "Processing $yaml_file..."

    grep 'git_url' "$yaml_file" | awk -F ': ' '{ print $2 }' | while IFS= read -r git_url; do
        # Remove both single and double quotes from the URL
        git_url=$(echo $git_url | tr -d "'" | tr -d '"')

        if [ ! -z "$git_url" ]; then
            # Ensure the URL ends with .git; append .git if necessary
            [[ $git_url =~ \.git$ ]] || git_url="${git_url}.git"

            # Extract the repository name from the URL, removing any trailing .git
            repo_name=$(basename "${git_url}" .git)

            echo "Downloading $repo_name from $git_url..."
            # Clone the repository into the repositories directory
            git clone "$git_url" "$repos_dir/$repo_name"
        fi
    done
}

download_date=$(date +%Y-%m-%d)

if [ "$#" -eq 0 ]; then
    echo "No YAML file paths provided. Searching in the current working directory..."
    for prefix in official community; do
        default_yaml_file="${prefix}-amp-catalog-${download_date}.yaml"
        if [ -f "$default_yaml_file" ]; then
            clone_repos_from_yaml "$default_yaml_file"
        else
            echo "File not found: $default_yaml_file"
        fi
    done
else
    for yaml_file in "$@"; do
        clone_repos_from_yaml "$yaml_file"
    done
fi
