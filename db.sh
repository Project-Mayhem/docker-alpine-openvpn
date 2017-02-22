#!/bin/bash
# Docker buildcycle script
# Build and automate cleanup - good to use on a dev box where this is the
# only project you are workingo on.

REPO_AND_IMAGE='org.pm/alpine-openvpn:2.1'
CONTAINER_NAME='openvpn'

# remove built image for rebuild
#docker rmi $(docker images | grep -v $REPO_AND_IMAGE | awk {'print $3'})
docker rmi $(docker images | awk {'print $3'})
# remove any images that are left around
docker rmi $(docker images -f dangling=true -q)

# remove any existing stopped containers
docker ps -a | awk '{print $1}' | xargs docker rm

# build the image, removing intermediate layers, deleting cache
# docker build --rm --no-cache -t "$REPO_AND_IMAGE" .
docker build \
    --rm \
    -t "$REPO_AND_IMAGE" .

# run the newly built image
#docker run --name $CONTAINER_NAME -p 25565:25565 -l $CONTAINER_NAME $REPO_AND_IMAGE

# run in inteactive for debugging / development
docker run \
      --name $CONTAINER_NAME \
      -d \
      -v ~/dev/git/projectMayhem/docker-centos-openvpn/config:/opt/config \
      -l $CONTAINER_NAME \
      -it \
      $REPO_AND_IMAGE

      # --entrypoint="/bin/bash" for debugging

# attach to the new container
#docker attach -it minecraft

# follow stdout
#docker logs -f $CONTAINER_NAME
