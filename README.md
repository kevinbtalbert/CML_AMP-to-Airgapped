# CML AMP to Airgapped
Download the Cloudera AMP catalog for an offline (airgapped) deployment of the AMP catalog.

This sister repository will enable hosting an HTTP server (airgapped) for the AMP Catalog files: https://github.com/kevinbtalbert/CML_AMP_Airgap_HTTP_WebServer

![](/cml-airgapped.png)

This project provides a set of shell scripts designed to facilitate the management of Python dependencies for offline environments. It aims to simplify the process of downloading and installing Python packages without an internet connection, leveraging the GitHub API and local file storage. This solution is particularly useful for deploying Python applications in isolated or secure environments where direct access to PyPI or other online repositories is not possible.

#### NOTE! Customers will need to manually adjust the requirements python files in the AMPs to ensure pip calls to the offline repo: ```pip install --no-index --find-links=/path/to/pip_packages -r requirements.txt``` This ensures local pull of downloaded dependencies instead of PyPi search resolution.

## Overview

The project consists of several components:

1. **Download Catalogs Script**: Downloads YAML files containing lists of GitHub repositories. It supports downloading both the official AMP catalog and the community AMP catalog, saving them with a timestamp to ensure version tracking.

2. **Clone Repositories Script**: Clones the specified repositories from the GitHub URLs listed in the YAML files into a `repositories` directory within the current working directory. This script also ensures that each `git_url` ends with `.git` for consistent cloning behavior.

3. **Download Dependencies Script**: Searches for `requirements.txt` files within the `repositories` directory and uses `pip` to download the specified Python packages for offline installation. The downloaded packages are stored in a `pip_packages` directory within the current working directory.

4. **Offline Installation Guide**: Provides instructions for using `pip` to install the downloaded packages from the local `pip_packages` directory, enabling the setup of Python environments without internet access.

## Usage

1. **Prepare Environment**: Ensure `pip`, `wget`, `git`, and `awk` are installed on your system. These tools are necessary for the scripts to function correctly.

2. **Download Catalogs**: Run the first script to download the YAML catalogs from GitHub. You will be prompted to choose which catalogs to download. The catalogs are saved in the current working directory.

3. **Clone Repositories**: Execute the second script to clone the repositories listed in the downloaded YAML files into the `repositories` directory within the current working directory.

4. **Download Dependencies**: Use the third script to download all Python packages listed in the `requirements.txt` files found within the `repositories` directory. The packages are downloaded to the `pip_packages` directory for offline use.

5. **Offline Installation**: To install the downloaded packages on a system without internet access, use the command: `pip install --no-index --find-links=/path/to/pip_packages -r requirements.txt`, where `/path/to/pip_packages` is the path to the directory containing the downloaded packages.

## Customization

You can customize the scripts to target different repositories or modify the paths used for downloading and storing files based on your specific needs and environment setup.

## Contributing

Contributions are welcome. Please submit pull requests or issues to improve the project's functionality or to address any bugs.
