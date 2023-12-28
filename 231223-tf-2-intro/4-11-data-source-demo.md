# 2023-12-28    13:30
=====================


11. Demo Data Sources
---------------------

It this demo we'll see how Datasources work with the almost same example we saw in theory.
    $ vagrant up
    $ vagrant ssh
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 4.15.0-213-generic x86_64)
...
Last login: Wed Dec 27 17:25:51 2023 from 10.0.2.2

    $ mkdir 4-11-demo-5
    $ cd 4-11-demo-5
    $ vim provider.tf
-----------
provider "aws" {
  region = var.AWS_REGION
}
-----------

    $ vim securitygroup.tf
-----------
data "aws_ip_ranges" "azr_ec2" {
  regions  = ["us-east-1", "eu-central-1"]
  services = ["ec2"]
}

resource "aws_security_group" "from_azr" {
  name = "from_azr"

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = slice(data.aws_ip_ranges.azr_ec2.cidr_blocks, 0, 50)
  }
  tags = {
    CreateDate = data.aws_ip_ranges.azr_ec2.create_date
    SyncToken  = data.aws_ip_ranges.azr_ec2.sync_token
  }
}
-----------

    $ vim vars.tf
-----------
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-010b814555e3268fa"
    eu-central-1 = "ami-03cea216f9d507835"
  }
}
-----------

    $ vim versions.tf
-----------

terraform {
  required_version = ">= 0.12"
}
-----------

# terraform.tfvars      <--- not needed, see ~/aws./credentials

vagrant@ubuntu-bionic:~/4-11-demo-5$ ls -lgh
total 16K
-rw-rw-r-- 1 vagrant  46 Dec 23 17:04 provider.tf
-rw-rw-r-- 1 vagrant 452 Dec 28 11:34 securitygroup.tf
-rw-rw-r-- 1 vagrant 194 Dec 28 11:35 vars.tf
-rw-rw-r-- 1 vagrant  46 Dec 23 17:04 versions.tf


╵
vagrant@ubuntu-bionic:~/4-11-demo-5$ terraform init
    Initializing the backend...
...


vagrant@ubuntu-bionic:~/4-11-demo-5$ terraform apply
data.aws_ip_ranges.azr_ec2: Reading...
data.aws_ip_ranges.azr_ec2: Read complete after 0s [id=1703185987]
    Terraform used the selected providers to generate the following execution plan. Resource
    actions are indicated with the following symbols:
      + create
Terraform will perform the following actions:
  # aws_security_group.from_azr will be created
  + resource "aws_security_group" "from_azr" {
...
      + name                   = "from_azr"
...
  Enter a value: yes

aws_security_group.from_azr: Creating...
aws_security_group.from_azr: Creation complete after 4s [id=sg-0cd1c934566f32001]
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.


> AWS > VPC > Security groups > sg-0cd1c934566f32001 = "from_azr"
    Tags:    
    SyncToken	1703185987
    CreateDate	2023-12-21-19-13-07


vagrant@ubuntu-bionic:~/4-11-demo-5$ terraform destroy
...
  Enter a value: yes
aws_security_group.from_azr: Destroying... [id=sg-0cd1c934566f32001]
aws_security_group.from_azr: Destruction complete after 2s

Destroy complete! Resources: 1 destroyed.
