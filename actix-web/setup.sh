OWNER=q-cteq
REPOSITORY=container-registry
IMAGE_NAME=rust-debian
IMAGE_VERSION=latest

TAG=docker.pkg.github.com/$OWNER/$REPOSITORY/$IMAGE_NAME:$IMAGE_VERSION

docker build -t $TAG -f ./Dockerfile .
docker run -p 8000:8000 $TAG

#docker push $TAG