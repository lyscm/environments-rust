# RUST TIER BUILDER - REPOSITORY <h1> 

[![environments-rust - CI](https://github.com/lyscm/environments-rust/actions/workflows/deploy-packages.yml/badge.svg?branch=master)](https://github.com/lyscm/environments-rust/actions/workflows/deploy-packages.yml)

## Initiate package(s): <h2> 

Set parameters:

```bash
OWNER=lyscm
CONTAINER_NAME=rust
TAG=ghcr.io/lyscm/environments/rust
```
Remove any existing container:

```bash
docker stop $CONTAINER_NAME
docker rm $CONTAINER_NAME
docker pull $TAG
```

Run container:

```bash
docker run \
    -d \
    --name $CONTAINER_NAME \
    --restart unless-stopped \
    -v /var/run/docker.sock:/var/run/docker-host.sock \
    --net=host \
    --cap-add=SYS_PTRACE \
    --security-opt seccomp:unconfined \
    --privileged \
    $TAG
```