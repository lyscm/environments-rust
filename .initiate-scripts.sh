
OWNER="lyscm"
REGISTRY="ghcr.io"
REPOSITORY_NAME="lyscm.common.tiers/rust"

echo $CR_PAT | docker login $REGISTRY -u $OWNER --password-stdin

cd $HOME/.vscode-server/extensions/ && zip -9 -r extensions.zip ./* && cd -

yes | cp -r $HOME/.vscode-server/extensions/extensions.zip .
rm -rf $HOME/.vscode-server/extensions/extensions.zip

docker buildx build --push --tag $REGISTRY/$OWNER/$REPOSITORY_NAME/extensions --file ./Dockerfile.extensions .

docker build --tag $REGISTRY/$OWNER/$REPOSITORY_NAME/base --file ./Dockerfile.base .
docker push $REGISTRY/$OWNER/$REPOSITORY_NAME/base

rm -rf extensions.zip