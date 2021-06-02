# Docker login
docker login -u qcteqcr

# Set variables
TAG_PUSH=qcteqcr/rust-development-environment
TAG_BUILDER=qcteqcr/rust-environment-builder

# Copy extensions
cp -r $HOME/.vscode-server/extensions ./extensions

docker tag $TAG_BUILDER $TAG_PUSH

# Build repository images
docker buildx build --push --platform=linux/amd64,linux/arm64,linux/arm/v7 -t $TAG_PUSH . 

# Remove extensions
rm -r ./extensions

docker run -d --restart unless-stopped -v /var/run/docker.sock:/var/run/docker-host.sock $TAG_PUSH