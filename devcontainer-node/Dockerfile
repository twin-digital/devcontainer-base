FROM mcr.microsoft.com/vscode/devcontainers/typescript-node:${NODE_VERSION}

# Suppress an apt-key warning about standard out not being a terminal. Use in this script is safe.
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ARG USERNAME=node

RUN userdel node \
  && useradd --create-home --shell /bin/bash --uid 1000 --no-log-init developer

# update outdated key for yarn packager
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -

# install gcloud cli
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
  sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    gnupg && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
  sudo apt-get update && sudo apt-get install -y \
    google-cloud-sdk \
    google-cloud-sdk-pubsub-emulator && \
  rm -rf /var/lib/apt/lists/*

# install arkade and useful tools
RUN curl -sLS https://dl.get-arkade.dev | sh \
  && arkade get kubectl \
  && arkade get kubeseal \
  && arkade get kustomize \
  # && arkade get terraform \
  && arkade get yq \
  && chmod +x /root/.arkade/bin/* \
  && mv /root/.arkade/bin/* /usr/local/bin/
  
# install latest terraform (newer than arkade's)
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
  apt-get update && \
  apt-get install -y software-properties-common && \
  apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
  apt-get update && \
  apt-get install -y terraform && \
  rm -rf /var/lib/apt/lists/*

RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/home/$USERNAME/scratch/.bash_history" \
    && echo $SNIPPET >> "/home/$USERNAME/.bashrc" \
    && echo "source ~/scratch/.bashrc" >> "/home/$USERNAME/.bashrc"

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment this line to install global node packages.
# RUN su developer -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1

USER developer
