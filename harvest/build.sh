#!/bin/bash

# You can't include the closed-source netapp files in public so if you don't have them then present then exit..
if [ -f ./netapp-harvest_*_all.deb ]; then
	echo "Missing netapp-harvest package, please download manually from NetApp and include in the directory"
	exit 1
fi
if [ -f ./netapp-manageability-sdk-*.zip ]; then
	echo "Missing netapp-manageability-sdk zip, please download manually from NetApp and include in the directory"
	exit 1
fi

# Local image name because this will contain closed source components and shouldnt be pushed to a public hub
IMAGE=harvest

# Build
docker build -t $IMAGE .

