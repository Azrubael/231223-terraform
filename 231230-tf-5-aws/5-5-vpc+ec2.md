# 2023-12-30    13:54
=====================

5. Launching EC2 instances in the VPC
-------------------------------------

The first we have to spin-out our VPC, as it's shown in a previous '231230-TF-5-4-vpc+nat-demo.md'.
After we have set up a VPC, let's spinning up new instances in that VPC.
It'll be very straightforward, but we want to launch the instance in our newly created VPC:
- with security group which permit access SSH through port22
    [ingress IP range 0.0.0.0/0, but the best bractice is to only allow one your IP (x.x.x.x/32)]
    [egressIP range 0.0.0.0/0, but you can make it more restrictive];
- using a keypair that will be uploaded by terraform.


    $ vim provider.tf
----------
provider "aws" {
    access_key = var.AWS_ACCESS_KEY
    secret_key = var.AWS_SECRET_KEY
    region     = var.AWS_REGION
}


    $ vim instance.tf
----------
resource "aws_instance" "example" {
    ami = var.AMIS[var.AWS_REGION]
    instance_type = "t2_micro"

    # the VPC subnet
    subnet_id = aws_subnet.main-public-1.id

    # the security group
    vpc_security_group_ids = [aws_security_group.allow-ssh.id]

    # the public SSH key
    key_name = aws_key_pair.mykeypair.key_name
}


    $ vim vars.tf
----------
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
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


    $ securitygroup.tf
----------
resource "aws_security_group" "allow-ssh" {
    vpc_id      = aws_vpc.main.id
    name        = "allow-ssh"
    description = "security group that allows ssh and all egress traffic"
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # all protocols
    cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "allow-ssh"
    }
}


    $ keypairs.tf
----------
resource "aws_key_pair" "mykeypair" {
    key_name = "mykeypair"
    public_key = file("mykeypair.pub")
}
# the file 'mykeypair.pub' will be uploaded to AWS and will allow an  instance to be launched with this public key



    $ vim vpc.tf
----------
# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "main"
  }
}

# Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "main-public-1"
  }
}

resource "aws_subnet" "main-public-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "main-public-2"
  }
}

resource "aws_subnet" "main-public-3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "main-public-3"
  }
}

resource "aws_subnet" "main-private-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "main-private-1"
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "main-private-2"
  }
}

resource "aws_subnet" "main-private-3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "main-private-3"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "main-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-2-a" {
  subnet_id      = aws_subnet.main-public-2.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-3-a" {
  subnet_id      = aws_subnet.main-public-3.id
  route_table_id = aws_route_table.main-public.id
}

