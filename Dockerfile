FROM --platform=$BUILDPLATFORM rust

# Set variables
ARG INSTALL_AZURE_CLI="true"
ARG INSTALL_ZSH="true"
ARG UPGRADE_PACKAGES="false"
ARG ENABLE_NONROOT_DOCKER="true"
ARG LINUX_VERSION=10
ARG LINUX_NAME=debian
ARG USERNAME=automatic
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG VSCODE_SERVER_PATH=/root/.vscode-server

# [Option] Use the OSS Moby CLI instead of the licensed Docker CLI
ARG USE_MOBY="true"

COPY library-scripts/*.sh /tmp/library-scripts/
COPY .vscode-extensions/ ${VSCODE_SERVER_PATH}/extensions/
COPY .vscode-configurations/ ${VSCODE_SERVER_PATH}/data/Machine/

# Install needed packages and setup non-root user. Use a separate RUN statement to add your
# own dependencies. A user of "automatic" attempts to reuse an user ID if one already exists.

# Install Azure CLI packages.
RUN if [ "${INSTALL_AZURE_CLI}" = "true" ]; then bash /tmp/library-scripts/azcli-debian.sh \
    && apt-get clean -y; fi

# Install Debian packages
RUN apt-get update \
    && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
    && /bin/bash /tmp/library-scripts/docker-debian.sh "${ENABLE_NONROOT_DOCKER}" "/var/run/docker-host.sock" "/var/run/docker.sock" "${USERNAME}" \
    && apt-get autoremove -y && apt-get clean -y 

# Setting the ENTRYPOINT to docker-init.sh will configure non-root access 
# to the Docker socket. The script will also execute CMD as needed.
ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD git config --global user.email "vsc-environment-builder@qcteq.com" \
    && git config --global user.name "Q-CTeq" \
    && export DOCKER_CLI_EXPERIMENTAL=enabled \
    && export DOCKER_BUILDKIT=1 \
    && docker build --platform=local -o . git://github.com/docker/buildx \
    && mkdir -p ~/.docker/cli-plugins \
    && mv buildx ~/.docker/cli-plugins/docker-buildx \
    && chmod a+x ~/.docker/cli-plugins/docker-buildx \
    && docker buildx create --use \
    && sleep "infinity"

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>
