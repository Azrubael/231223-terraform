# 2023-12-27    19:18
=====================

9. Demo Remote state
--------------------

Now we're going to use S3 bucket as a remot state store

    $ which aws
/usr/bin/aws
    $ ls -l /usr/bin/aws
-rwxr-xr-x 1 root root 815 Jan 13  2022 /usr/bin/aws
    $ sudo rm /usr/bin/aws
    $ sudo rm /usr/bin/aws_completer
    $ sudo apt remove awscli -y
    $ sudo apt update
    $ sudo apt upgrade

# To install the AWS CLI, run the following commands.
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

    $ aws s3 mb s3://tf49-remote-demo
make_bucket: tf49-remote-demo
    $ aws s3 ls
2023-12-19 13:06:58 k8v.azrubael.online
2023-12-27 19:56:50 tf49-remote-demo


# 2023-12-28    12:20
=====================

    $ vagrant up
    $ vagrant ssh
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 4.15.0-213-generic x86_64)
...
Last login: Wed Dec 27 17:25:51 2023 from 10.0.2.2
    $ aws configure
...
Default output format [None]: json
# You cannot use variables in the backend, so you need to make sure that terraform can login tp aws using '~/.aws/credentials'.

# After that we'll get old code './terraform-course/demo-4/*'
    $ cd 4-9-demo-4
    $ vim backend.tf
----------
terraform {
    backend "s3" {
        bucket = "tf49-remote-demo"
        key = "terraform/demo4"
        region = "us-east-1"
    }
}
----------

    $ vim instance.tf
----------
resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }
}

output "ip" {
  value = aws_instance.example.public_ip
}
----------

    $ vim provider.tf
----------
provider "aws" {
  region = var.AWS_REGION
}
----------
    
    # vim vars.tf
----------
variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

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

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
----------

    $ vim versions.tf
----------
terraform {
  required_version = ">= 0.12"
}
----------

    $ terraform.tfvars
----------
AWS_ACCESS_KEY="..."
AWS_SECRET_KEY="..."
PATH_TO_PUBLIC_KEY="~/.ssh/key.pub"
PATH_TO_PRIVATE_KEY="~/.ssh/key"
----------


vagrant@ubuntu-bionic:~/4-9-demo-4$ ls -ghl
total 24K
-rw-rw-r-- 1 vagrant 135 Dec 28 10:35 backend.tf
-rw-rw-r-- 1 vagrant 381 Dec 28 10:41 instance.tf
-rw-rw-r-- 1 vagrant 117 Dec 28 10:42 provider.tf
-rw-rw-r-- 1 vagrant 195 Dec 27 15:56 terraform.tfvars
-rw-rw-r-- 1 vagrant 424 Dec 28 10:38 vars.tf
-rw-rw-r-- 1 vagrant  46 Dec 23 17:04 versions.tf


vagrant@ubuntu-bionic:~/4-9-demo-4$ terraform init
    Initializing the backend...
    Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.
    Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v5.31.0...
- Installed hashicorp/aws v5.31.0 (signed by HashiCorp)
...


vagrant@ubuntu-bionic:~/4-9-demo-4$ terraform plan -out demo4.azrubael
...
  # aws_instance.example will be created
...
Plan: 2 to add, 0 to change, 0 to destroy.
...


vagrant@ubuntu-bionic:~/4-9-demo-4$ terraform apply "demo4.azrubael"
aws_key_pair.mykey: Creating...
aws_instance.example: Creating...
aws_key_pair.mykey: Creation complete after 1s [id=mykey]
aws_instance.example: Still creating... [10s elapsed]
aws_instance.example: Still creating... [20s elapsed]
aws_instance.example: Still creating... [30s elapsed]
aws_instance.example: Provisioning with 'local-exec'...
aws_instance.example (local-exec): Executing: ["/bin/sh" "-c" "echo 172.31.31.246 >> private_ips.txt"]
aws_instance.example: Creation complete after 35s [id=i-06cc3c8022bd91aa3]
    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
    Outputs:
        ip = "3.80.58.76"

vagrant@ubuntu-bionic:~/4-9-demo-4$ cat private_ips.txt
172.31.31.246


> AWS > Amazon S3 > Buckets > tf49-remote-demo > terraform/
# and there we have a JSON state file
# s3://tf49-remote-demo/terraform/demo4

> AWS > EC2 > i-06cc3c8022bd91aa3 > Private IPv4 addresses = 172.31.31.246


vagrant@ubuntu-bionic:~/4-9-demo-4$ terraform destroy
...
      Enter a value: yes
