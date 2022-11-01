#!/bin/bash
#Docker & Docker-Compose Installation Script
sudo yum update -y 
sudo yum install yum-utils -y
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install vault -y
sudo yum install git -y
sudo yum install docker-ce docker-ce-cli containerd.io --allowerasing -y
sudo systemctl enable docker --now
sudo systemctl enable containerd.service --now
sudo chmod 666 /var/run/docker.sock
sudo curl -L https://github.com/docker/compose/releases/download/v2.11.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
