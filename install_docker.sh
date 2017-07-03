#!/bin/bash
# Run this as root

# Configure docker repo
apt-get update
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update

# Install pre-reqs
apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual -y

# Install docker and start service
apt-get install docker-ce -y
service docker start
systemctl enable docker

# Configure docker users
#groupadd docker
#usermod -aG docker $USER

# Install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# All done
exit 0
