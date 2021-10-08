#!/bin/sh

# This script is executed inside a container running the new version of this image after it is built, 
# and can be used to verify the image has been configured correctly.

# verify non-root user
echo "user info: $(id)"
if [ "$(id -u)" != "1000" ]; then
  echo "Incorrect user id: $(id -u)"
  exit 1
fi

# verify passwordless sudo
echo "sudo whoami: $(sudo --non-interactive whoami)" || ( echo "'sudo' command not configured correctly"; exit 1 )

# test installed packages
git --version || ( echo "'git' not installed"; exit 1 )
