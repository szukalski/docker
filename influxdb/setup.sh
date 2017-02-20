#!/bin/bash

IMAGE=influxdb
CONTAINER=influxdb
PERSISTENT_CONTAINER=$CONTAINER-storage
PERSISTENT_LOCATION=/srv/docker/$CONTAINER
PERSISTENT_VOLUMES=(var/lib/influxdb)
PERSISTENT_FILES=(etc/influxdb/influxdb.conf)
VOLUMES=""
DATABASES=("servers" "virtualhosts" "network")

# Create persistent volume locations if they don't exist
for VOL in ${PERSISTENT_VOLUMES[@]}
do
	VOLUMES=$VOLUMES" -v $PERSISTENT_LOCATION/$VOL:/$VOL"
	if [ ! -d $PERSISTENT_LOCATION/$VOL ]; then
	mkdir -p $PERSISTENT_LOCATION/$VOL
	fi
done

# Copy persistent files
for FILE in ${PERSISTENT_FILES[@]}
do
	VOLUMES=$VOLUMES" -v $PERSISTENT_LOCATION/$FILE:/$FILE"
	if [ ! -f $PERSISTENT_LOCATION/$FILE ]; then
	mkdir -p $PERSISTENT_LOCATION/$FILE
	fi
done

# Create persistent storage container
docker run -d $VOLUMES --name $PERSISTENT_CONTAINER ubuntu:16.04

# Run the image
docker run -d \
	-p 8086:8086 \
	--restart always \
	--name $CONTAINER \
	--volumes-from $PERSISTENT_CONTAINER \
	$IMAGE

sleep 10

# Create databases
for DB in "${DATABASES[@]}"
do
  curl -G http://localhost:8086/query --data-urlencode "q=CREATE DATABASE $DB"
done
