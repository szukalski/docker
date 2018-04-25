#!/bin/bash

sudo apt install apache2-utils

read -p "Directory to store volumes: "
if [ ! -d $REPLY ]; then
    echo "Directory must exist"
    exit 1
fi

echo DIR="$REPLY" > .env

echo UID=$(id -u) >> .env
echo GID=$(id -g) >> .env
echo TZ=$(cat /etc/timezone) >> .env

