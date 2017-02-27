#!/bin/bash

INFLUX_ADMIN=dba
INFLUX_ADMIN_PASSWORD=dbapassword
INFLUX_USER=rouser
INFLUX_USER_PASSWORD=userpassword
INFLUX_DATABASES=("influx")

# Start this puppy
docker-compose up -d

# Wait for influx to start
sleep 10

# Create admin
curl --noproxy localhost -G http://localhost:8086/query --data-urlencode "q=CREATE USER $INFLUX_ADMIN WITH PASSWORD '$INFLUX_ADMIN_PASSWORD' WITH ALL PRIVILEGES"

# Create user
curl --noproxy localhost -G http://localhost:8086/query -u $INFLUX_ADMIN:$INFLUX_ADMIN_PASSWORD --data-urlencode "q=CREATE USER $INFLUX_USER WITH PASSWORD '$INFLUX_USER_PASSWORD'"

# Create databases
for DB in "${INFLUX_DATABASES[@]}"
do
	curl --noproxy localhost -G http://localhost:8086/query -u $INFLUX_ADMIN:$INFLUX_ADMIN_PASSWORD --data-urlencode "q=CREATE DATABASE $DB"
	curl --noproxy localhost -G http://localhost:8086/query -u $INFLUX_ADMIN:$INFLUX_ADMIN_PASSWORD --data-urlencode "q=GRANT READ ON $DB to $INFLUX_USER"
done

# Add datasource
curl --noproxy localhost "http://$GRAFANA_ADMIN:$GRAFANA_ADMIN_PASSWORD@localhost:3000/api/datasources" \
	-X POST \
	-H 'Content-Type: application/json;charset=UTF-8' \
	--data-binary \
	'{"name":"influx","type":"influxdb","url":"http://influxdb:8086","access":"proxy","isDefault":true,"database":"influx","user":"$INFLUX_USER","password":"$INFLUX_USER_PASSWORD"}'
