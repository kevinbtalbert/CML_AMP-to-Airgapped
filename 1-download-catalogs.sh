#!/bin/bash

# This script downloads the official and/or community AMP
# catalogs from the Cloudera official repo.
# Ensure chmod +x 1-download-catalogs.sh if error

download_date=$(date +%Y-%m-%d)

download_catalog() {
    local yaml_url=$1
    local prefix=$2
    # Save the YAML file in the current working directory
    local yaml_file="${prefix}-amp-catalog-${download_date}.yaml"

    echo "Downloading YAML from $yaml_url to $yaml_file..."
    wget $yaml_url -O "$yaml_file"

    if [ $? -eq 0 ]; then
        echo "Successfully downloaded to $yaml_file"
    else
        echo "Failed to download from $yaml_url"
    fi
}

# Official AMP catalog
read -p "Do you want to download the official AMP catalog? (y/n) " official_answer
if [[ $official_answer =~ ^[Yy]$ ]]; then
    download_catalog "https://raw.githubusercontent.com/cloudera/Applied-ML-Prototypes/master/amp-catalog-cloudera-default-new.yaml" "official"
fi

# Community AMP catalog
read -p "Do you want to download the community AMP catalog? (y/n) " community_answer
if [[ $community_answer =~ ^[Yy]$ ]]; then
    download_catalog "https://raw.githubusercontent.com/cloudera/Community-Applied-ML-Prototypes/master/community-amp-catalog-default.yaml" "community"
fi
