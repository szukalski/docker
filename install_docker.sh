#!/bin/bash
# Run this as root

# Configure docker repo
apt-get update
apt-get install apt-transport-https ca-certificates -y
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list
apt-get update

# Install pre-reqs
apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual -y

# Install docker and start service
apt-get install docker-engine -y
service docker start

# Install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.11.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# All done
exit 0