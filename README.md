# RUST TIER BUILDER - REPOSITORY <h1> 
## Initiate package(s): <h2> 

Set parameters:

```bash
OWNER=lyscm
CONTAINER_NAME=lyscm.rust-tier
TAG=ghcr.io/lyscm/lyscm.common.tiers/rust
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
    --privileged \
    $TAG
```