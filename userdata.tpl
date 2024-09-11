#!/bin/bash
echo "----- BEGIN OF INSTALL SCRIPT -----"
sudo yum update -y &&
sudo yum install nginx docker python-certbot-nginx git -y &&
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose &&
sudo chmod +x /usr/local/bin/docker-compose &&
sudo usermod -aG docker ec2-user &&
sudo systemctl enable docker &&
sudo systemctl start docker &&
sudo docker volume create redisdata &&
echo "----- END OF INSTALL SCRIPT -----"
#sudo apt-get install -y \
#apt-transport-https \
#ca-certificates \
#curl \
#gnupg-agent \
#software-properties-common &&
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
#sudo apt-get update -y &&
#sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&
#sudo usermod -aG docker ubuntu