# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.158.0/containers/rust/.devcontainer/base.Dockerfile
ARG VARIANT="1"
FROM mcr.microsoft.com/vscode/devcontainers/rust:0-${VARIANT}

# [Option] Install Azure CLI
ARG INSTALL_AZURE_CLI="true"

# [Option] Install Azure Bicep
ARG INSTALL_AZURE_BICEP="true"

# [Option] Install zsh
ARG INSTALL_ZSH="true"

# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="false"

# [Option] Enable non-root Docker access in container
ARG ENABLE_NONROOT_DOCKER="true"

# [Option] Use the OSS Moby CLI instead of the licensed Docker CLI
ARG USE_MOBY="true"

ARG LINUX_VERSION=10
ARG LINUX_NAME=debian

# Install .NET 5.0
RUN if [ "${INSTALL_AZURE_BICEP}" = "true" ]; then wget https://packages.microsoft.com/config/${LINUX_NAME}/${LINUX_VERSION}/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    sudo dpkg -i packages-microsoft-prod.deb; fi

RUN if [ "${INSTALL_AZURE_BICEP}" = "true" ]; then sudo apt-get update && \
    sudo apt-get install -y apt-transport-https && \
    sudo apt-get update && \
    sudo apt-get install -y dotnet-sdk-5.0; fi

RUN if [ "${INSTALL_AZURE_BICEP}" = "true" ]; then sudo apt-get update && \
    sudo apt-get install -y apt-transport-https && \
    sudo apt-get update && \
    sudo apt-get install -y aspnetcore-runtime-5.0; fi

# Install Azure Bicep packages.
RUN if [ "${INSTALL_AZURE_BICEP}" = "true" ]; then curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64 && \
    chmod +x ./bicep && \
    sudo mv ./bicep /usr/local/bin/bicep && \
    bicep --help; fi

# Install needed packages and setup non-root user. Use a separate RUN statement to add your
# own dependencies. A user of "automatic" attempts to reuse an user ID if one already exists.
ARG USERNAME=automatic
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY library-scripts/*.sh /tmp/library-scripts/

# Install Azure CLI packages.
RUN if [ "${INSTALL_AZURE_CLI}" = "true" ]; then bash /tmp/library-scripts/azcli-debian.sh \
    && apt-get clean -y; fi

RUN apt-get update \
    && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" \
    # Use Docker script from script library to set things up
    && /bin/bash /tmp/library-scripts/docker-debian.sh "${ENABLE_NONROOT_DOCKER}" "/var/run/docker-host.sock" "/var/run/docker.sock" "${USERNAME}" \
    # Install VSC extensions
    && /bin/bash /tmp/library-scripts/vsc-extensions.sh \
    # Clean up
    && apt-get autoremove -y && apt-get clean -y 
    # && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/

# Install Azure Function Tools
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg \
    && sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ \
    && wget -q https://packages.microsoft.com/config/debian/$LINUX_VERSION/prod.list \
    && sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list \
    && sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg \
    && sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list

RUN sudo apt-get update \
    && sudo apt-get install azure-functions-core-tools-3

# Install SDK
RUN cargo install azure-functions-sdk

# Setting the ENTRYPOINT to docker-init.sh will configure non-root access 
# to the Docker socket. The script will also execute CMD as needed.
ENTRYPOINT [ "/usr/local/share/docker-init.sh" ]
CMD [ "sleep", "infinity" ]

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>
