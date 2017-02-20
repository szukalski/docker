#!/bin/bash

INFLUX_IMAGE=influxdb
INFLUX_CONTAINER=graf-influxdb

GRAFANA_IMAGE=grafana/grafana
GRAFANA_CONTAINER=graf-grafana

PERSISTENT_CONTAINER=graf-storage
PERSISTENT_LOCATION=/srv/docker/grafana-influxdb
VOLUMES=""

INFLUX_ADMIN=dba
INFLUX_ADMIN_PASSWORD=dbapassword
INFLUX_USER=rouser
INFLUX_USER_PASSWORD=userpassword
INFLUX_DATABASES=("default")

GRAFANA_ADMIN_PASSWORD=secret

# We need a fresh install so this will check if the persistent location already exists.
if [ -d $PERSISTENT_LOCATION ]; then
	echo "This is going to clean out the existing installation data. Please clean up and then try again"
	exit 1
fi

mkdir -p $PERSISTENT_LOCATION
# INFLUXDB persistent storage
mkdir -p $PERSISTENT_LOCATION/var/lib/influxdb
VOLUMES=$VOLUMES" -v $PERSISTENT_LOCATION/var/lib/influxdb:/var/lib/influxdb"
mkdir -p $PERSISTENT_LOCATION/etc/influxdb
cp influxdb/etc/influxdb/influxdb.conf $PERSISTENT_LOCATION/etc/influxdb/influxdb.conf
VOLUMES=$VOLUMES" -v $PERSISTENT_LOCATION/etc/influxdb/influxdb.conf:/etc/influxdb/influxdb.conf"
# GRAFANA persistent storage
mkdir -p $PERSISTENT_LOCATION/var/lib/grafana
VOLUMES=$VOLUMES" -v $PERSISTENT_LOCATION/var/lib/grafana:/var/lib/grafana"

# Create persistent storage container
docker run -d $VOLUMES --name $PERSISTENT_CONTAINER ubuntu:16.04

# Run INFLUXDB
docker run -d \
	-p 8086:8086 \
	--restart always \
	--name $INFLUX_CONTAINER \
	--volumes-from $PERSISTENT_CONTAINER \
	$INFLUX_IMAGE

# Wait for database to start
sleep 10

# Create admin
curl --noproxy localhost -G http://localhost:8086/query --data-urlencode "q=CREATE USER $INFLUX_ADMIN WITH PASSWORD 'dbapassword' WITH ALL PRIVILEGES"

# Create user
curl --noproxy localhost -G http://localhost:8086/query -u $INFLUX_ADMIN:$INFLUX_ADMIN_PASSWORD --data-urlencode "q=CREATE USER $INFLUX_USER WITH PASSWORD 'userpassword'"

# Create databases
for DB in "${DATABASES[@]}"
do
	curl --noproxy localhost -G http://localhost:8086/query -u $INFLUX_ADMIN:$INFLUX_ADMIN_PASSWORD --data-urlencode "q=CREATE DATABASE $DB"
	curl --noproxy localhost -G http://localhost:8086/query -u $INFLUX_ADMIN:$INFLUX_ADMIN_PASSWORD --data-urlencode "q=GRANT READ ON $DB to $INFLUX_USER"
done

# Run GRAFANA
docker run -d \
	-p 3000:3000 \
	-e "GF_USERS_ALLOW_SIGN_UP=false" \
	-e "GF_USERS_ALLOW_ORG_CREATE=false" \
	-e "GF_SECURITY_ADMIN_PASSWORD=$GRAFANA_ADMIN_PASSWORD" \
	--restart always \
	--name $GRAFANA_CONTAINER \
	--volumes-from $PERSISTENT_CONTAINER \
	$GRAFANA_IMAGE

