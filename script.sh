#!/bin/bash

echo "## Attach the Jenkins Data Volume ##"
sudo mkfs.ext4 -F /dev/xvdk
sudo mkdir -p /var/lib/jenkins
sudo mount /dev/xvdk /var/lib/jenkins
BLK_ID=$(sudo blkid /dev/xvdk | cut -f2 -d" ")
echo "$BLK_ID     var/lib/jenkins   ext4    defaults   0   2" | sudo tee --append /etc/fstab
sudo mount -a

echo "## Install Jenkins on Amazon Linux ##"
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
sudo dnf install java-17-amazon-corretto -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins