#!/usr/bin/env bash

source "/vagrant/scripts/common.sh"

yum install -y docker docker-compose

groupadd docker
usermod -aG docker vagrant

echo "Starting docker..."
systemctl enable docker
systemctl start docker
