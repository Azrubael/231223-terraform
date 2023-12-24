#!/bin/bash
# 2023-12-23    17:37

vagrant up && vagrant ssh

sudo apt-get update

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install terraform

terraform version
# Terraform v1.6.6 on linux_amd64

mkdir terraform
cd terraform
sudo apt-get install mc


# 2023-12-24    13:58
sudo apt update && sudo apt install wget curl awscli -y

echo "Enter AWS Access Key:"
read awsaccess

echo "Enter AWS Secret Key:"
read awssecret

echo "Enter an AZ for AWS:"
read az

# Configure your AWS user profile
aws configure set aws_access_key_id $awsaccess
aws configure set aws_secret_access_key $awssecret
aws configure set default.region $az

# Create a key which can be used for ssh login
ssh-keygen -N "" -f $HOME/.ssh/id_rsa

