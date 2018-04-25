#!/bin/bash

sudo apt install apache2-utils

read -p "Directory to store volumes: "
echo DIR="$REPLY" > .env

echo UID=$(id -u) >> .env
echo GID=$(id -g) >> .env
echo TZ=$(cat /etc/timezone) >> .env

