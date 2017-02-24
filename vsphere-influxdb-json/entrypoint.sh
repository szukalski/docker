#!/bin/bash
SLEEP_TIME=60

while :; do
	vsphere-influxdb-go
	sleep $SLEEP_TIME
done
