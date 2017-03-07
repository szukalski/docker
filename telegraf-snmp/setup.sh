#!/bin/bash

IMAGE=telegraf			# Image to pull from docker hub
CONTAINER=telegraf		# Name for the container

# Pull the image
docker pull $IMAGE

# Run the image
docker run -d \
-v $PWD/etc/telegraf:/etc/telegraf \
--restart always \
--name $CONTAINER \
$IMAGE
