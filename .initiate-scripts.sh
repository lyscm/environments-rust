
OWNER="lyscm"
REGISTRY="ghcr.io"
REPOSITORY_NAME="environments/rust"

echo $CR_PAT | docker login $REGISTRY -u $OWNER --password-stdin

cd $HOME/.vscode-server/extensions/ && zip -9 -r extensions.zip ./* && cd -

yes | cp -r $HOME/.vscode-server/extensions/extensions.zip .
rm -rf $HOME/.vscode-server/extensions/extensions.zip

docker buildx build \
    --output "type=image,push=true" \
    --file ./Dockerfile.extensions \
    --tag $REGISTRY/$OWNER/$REPOSITORY_NAME/extensions \
    .

rm -rf extensions.zip