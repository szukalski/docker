#!/bin/bash

IMAGE=szukalski/vsphere-influxdb-go

# Build
docker build -t $IMAGE .
