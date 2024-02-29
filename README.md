# CML AMP to Airgapped
Download the Cloudera AMP catalog for an offline (airgapped) deployment of the AMP catalog.

![](/cml-airgapped.png)

This project provides a set of shell scripts designed to facilitate the management of Python dependencies for offline environments. It aims to simplify the process of downloading and installing Python packages without an internet connection, leveraging the GitHub API and local file storage. This solution is particularly useful for deploying Python applications in isolated or secure environments where direct access to PyPI or other online repositories is not possible.

## Overview

The project consists of several components:

1. **Download Catalogs Script**: This script interacts with the GitHub API to download YAML files containing lists of GitHub repositories. It supports downloading both the official AMP catalog and the community AMP catalog, saving them with a timestamp to ensure version tracking.

2. **Clone Repositories Script**: After downloading the YAML catalogs, this script clones the specified repositories from the GitHub URLs listed in the YAML files into the local project directory. It supports recursive search for `requirements.txt` files within these repositories to identify all Python dependencies.

3. **Download Dependencies Script**: This script finds all `requirements.txt` files within the downloaded repositories and uses `pip` to download the specified Python packages for offline installation. The downloaded packages are stored in a designated local directory.

4. **Offline Installation Guide**: Instructions are provided for using `pip` to install the downloaded packages from the local directory, enabling setup of Python environments without internet access.

## Usage

1. **Prepare Environment**: Ensure `pip`, `wget`, and `yq` are installed on your system. These tools are necessary for the scripts to function correctly.

2. **Download Catalogs**: Run the first script to download the YAML catalogs from GitHub. You will be prompted to choose which catalogs to download.

3. **Clone Repositories**: Execute the second script to clone the repositories listed in the downloaded YAML files. The script will search for `requirements.txt` files within these repositories.

4. **Download Dependencies**: Use the third script to download all Python packages listed in the `requirements.txt` files into a local directory for offline use.

5. **Offline Installation**: Follow the offline installation guide to install the downloaded packages on systems without internet access.

## Customization

You can customize the scripts to target different repositories or modify the paths used for downloading and storing files based on your specific needs and environment setup.

## Contributing

Contributions are welcome. Please submit pull requests or issues to improve the project's functionality or to address any bugs.

