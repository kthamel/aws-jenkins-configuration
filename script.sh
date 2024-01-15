#!/bin/bash

echo "## Attach the Jenkins Data Volume ##"
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.jenkins-data.dns_name}:/  /var/lib/jenkins
echo ${aws_efs_file_system.jenkins-data.dns_name}:/ /var/lib/jenkins nfs4 defaults,_netdev 0 0  | sudo cat >> /etc/fstab

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
