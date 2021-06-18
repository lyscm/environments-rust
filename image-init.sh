# Docker login
# docker login -u qcteqcr

# Set variables
TAG=qcteqcr/rust-sdk-runtime
CONTAINER_NAME=rust-environment

# Copy extensions
cp -r $HOME/.vscode-server/extensions/* ./.vscode-extensions

# Build repository images
docker buildx build --push --platform=linux/amd64,linux/arm64,linux/arm/v7 -t $TAG . 

# Remove extensions
rm -r ./.vscode-extensions/**/

# Remove container
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME

# Pull latest images
docker pull $TAG

# Run a container
docker run -d --name $CONTAINER_NAME --restart unless-stopped -v /var/run/docker.sock:/var/run/docker-host.sock $TAG