#!/bin/bash

# You can't include the closed-source netapp files in public so if you don't have them then present then exit..
if [ ! -f ./netapp-harvest_*_all.deb ]; then
	echo "Missing netapp-harvest package, please download manually from NetApp and include in the directory"
	exit 1
fi
if [ ! -f ./netapp-manageability-sdk-*.zip ]; then
	echo "Missing netapp-manageability-sdk zip, please download manually from NetApp and include in the directory"
	exit 1
fi

IMAGE=szukalski/netapp-harvest

# Build
docker build -t $IMAGE .

