FROM ubuntu:20.04

# Suppress an apt-key warning about standard out not being a terminal. Use in this script is safe.
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

COPY scripts /usr/local/bin
COPY packages.txt /usr/local/etc/devcontainer/

# install sudo, scripts, and other packages from setup-files/packages.txt
RUN apt-get update && apt-get install -y sudo \
  && chmod +x /usr/local/bin/* \
  && install-packages /usr/local/etc/devcontainer/packages.txt

# setup non-root user with passwordless sudo
RUN useradd --create-home --shell /bin/bash --uid 1000 --no-log-init devuser
RUN adduser devuser sudo
RUN echo '%devuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER devuser