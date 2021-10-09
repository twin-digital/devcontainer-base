# Dev Container Base

Twin Digital's base development container for Visual Studio Code and GitHub Codespaces.

## Installed Packages

This container is built on an `ubuntu:20.04` base, and provides the following packages:

* curl
* git
* jq
* nano
* tar
* unzip
* wget

## Default User Configuration

This image sets up a non-root default user (`devuser`). This user has access to passwordless `sudo`.

## License

The contents of this repository are released under the [MIT License](LICENSE).