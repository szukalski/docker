#!/bin/bash

IMAGE=grafana/grafana
CONTAINER=grafana
PERSISTENT_CONTAINER=$CONTAINER-storage
PERSISTENT_LOCATION=/srv/docker/$CONTAINER
PERSISTENT_VOLUMES=(var/lib/grafana)
VOLUMES=""

# Create persistent volume locations if they don't exist
for VOL in ${PERSISTENT_VOLUMES[@]}
do
	VOLUMES=$VOLUMES" -v $PERSISTENT_LOCATION/$VOL:/$VOL"
	if [ ! -d $PERSISTENT_LOCATION/$VOL ]; then
		mkdir -p $PERSISTENT_LOCATION/$VOL
	fi
done

# Create persistent storage container
docker run -d $VOLUMES --name $PERSISTENT_CONTAINER ubuntu:16.04

# Run the image
docker run -d \
	-p 3000:3000 \
	-e "GF_USERS_ALLOW_SIGN_UP=false" \
	-e "GF_USERS_ALLOW_ORG_CREATE=false" \
	-e "GF_SECURITY_ADMIN_PASSWORD=secret" \
	--restart always \
	--name $CONTAINER \
	--volumes-from $PERSISTENT_CONTAINER \
	$IMAGE

