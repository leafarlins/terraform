#!/bin/bash
echo "----- BEGIN OF INSTALL SCRIPT -----"
set +x
dnf update -y
dnf install nginx git sshfs -y
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
systemctl start docker
systemctl enable docker
docker volume create redisdata
docker volume create mongodb
mkdir /srv/data
mkdir /srv/srvfiles
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
yum install epel-release -y
dnf install certbot python3-certbot-nginx -y
