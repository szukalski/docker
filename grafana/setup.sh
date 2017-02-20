#!/bin/bash

IMAGE=grafana/grafana
CONTAINER=grafana
PERSISTENT_LOCATION=/srv/docker/$CONTAINER
PERSISTENT_VOLUMES=(var/lib/grafana etc/grafana)

# Pull the image
docker pull $IMAGE

# Create persistent volume locations if they don't exist
for VOL in ${PERSISTENT_VOLUMES[@]}
do
	echo $VOL
	if [ ! -d $PERSISTENT_LOCATION/$VOL ]; then
		mkdir -p $PERSISTENT_LOCATION/$VOL
	fi
done

# Run the image
docker run -d \
	-p 3000:3000 \
	-v $PWD/var/lib/grafana:/var/lib/grafana \
	-e "GF_USERS_ALLOW_SIGN_UP=false" \
	-e "GF_USERS_ALLOW_ORG_CREATE=false" \
	-e "GF_SECURITY_ADMIN_PASSWORD=secret" \
	--restart always \
	--name $CONTAINER \
	$IMAGE

