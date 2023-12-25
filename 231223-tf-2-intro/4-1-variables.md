# 2023-12-24    17:50
=====================

Now we're going to split a terraform file with some credentials on two parts, and one of them will not be saved in uor IaaC repository:

vim provider.tf
------------------------
proviser "aws" {
    access_key = "${var.AWS_ACCESS_KEY}"
    secret_key = "${var.AWS_SECRET_KEY}"
    region = "${var.AWS_REGION}"
}

------------------------

vim vars.tf
------------------------
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "eu-west-1"
}

------------------------

# It will be but in '.gitignore'
vim terraform.tfvars
------------------------
AWS_ACCESS_KEY="..."
AWS_SECRET_KEY="..."
AWS_REGION="non-default-value-that-you-need"
------------------------

instance.tf
------------------------
resource "aws_instance" "example-5th {
    ami = "ami-543532452362"
    instance_type = "t2.micro"
}
------------------------


================================================================
# An alternative edition of 'instance.tf' ans 'vars.tf' if you use
# https://cloud-images.ubuntu.com/locator/ec2/
instance.tf
------------------------
resource "aws_instance" "example-5th {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
}
------------------------

vim vars.tf
------------------------
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "eu-west-1"
}
variable "AMIS" {
    type = "map"
    default = {
        us-east-1 = "ami-53453245342534"
        us-west-2 = "ami-43245234543253"
        eu-central-1 = "ami-454354325345432"
    }
}

------------------------