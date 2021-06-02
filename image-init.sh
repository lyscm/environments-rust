# Set variables
TAG_BUILD=qcteqcr/rust-development:build
TAG_PUSH=qcteqcr/rust-development

# Copy extensions
cp -r $HOME/.vscode-server/extensions ./extensions

# Build repository images
docker buildx build --push --platform=linux/amd64,linux/arm64,linux/arm/v7 -t $TAG_PUSH . 

# Remove extensions
rm -r ./extensions

# docker run -d --restart unless-stopped -v /var/run/docker.sock:/var/run/docker-host.sock qcteqcr/rust-development 