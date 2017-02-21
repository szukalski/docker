#!/bin/bash

IMAGE=szukalski/vsphere-influxdb-go
CONTAINER=vsphere-influxdb-go
PERSISTENT_LOCATION=/srv/docker/$CONTAINER
CONFIG=etc/vsphere-influxdb-go.json

if [ ! -f $PERSISTENT_LOCATION/$CONFIG ]; then
	echo "Config file $CONFIG has to be present at $PERSISTENT_LOCATION before setup. Exiting."
	exit 1
fi

# Run the image
docker run -d \
	--restart always \
	--name $CONTAINER \
	-v $PERSISTENT_LOCATION/$CONFIG:/$CONFIG
	$IMAGE
