# Set variables
TAG=qcteqcr/rust-development

# Copy extensions
cp -r $HOME/.vscode-server/extensions ./extensions

# Build repository images
docker build -t $TAG .
docker push $TAG

# Remove extensions
rm -r ./extensions

# docker run -v /var/run/docker.sock:/var/run/docker-host.sock qcteqcr/rust-development