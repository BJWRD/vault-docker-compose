#!/bin/bash
#Docker & Docker-Compose Installation Script
sudo yum update -y 
sudo yum install yum-utils -y
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum install vault -y
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/dock
er-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io --allowerasing -y
sudo systemctl enable docker --now
sudo systemctl enable containerd.service --now
sudo chmod 666 /var/run/docker.sock
sudo curl -L https://github.com/docker/compose/releases/download/v2.11.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
