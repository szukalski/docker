#!/bin/bash

sudo apt install apache2-utils

read -p "Directory to store volumes: "
if [ ! -d $REPLY ]; then
    echo "Directory must exist"
    exit 1
fi
DIR=$REPLY

# Populate .env file
echo DIR="$DIR" > .env
echo UID=$(id -u) >> .env
echo GID=$(id -g) >> .env
echo TZ=$(cat /etc/timezone) >> .env

# Create directory structure
mkdir -p $DIR/nginx-proxy/{certs,htpasswd}
mkdir -p $DIR/{downloads,tv,movies}
mkdir -p $DIR/{rutorrent,radarr,sonarr,jackett,muximux}/config
