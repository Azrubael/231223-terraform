# 2023-12-28    17:44
=====================

14. Modules
-----------

You can:
- use modules to make your terraform more organized;
- use third party modules, like modules from github;
- reuse parts of your code e.g. to setup network in AWS Virtual Private Networks (VPC).

# A usecase example with a module from github:
----------
module "module-example" {
    source = "github.com/wardviaene/terraform-module-example"
}

# A usecase example with a moduke from a local folder:
----------
module "module-example" {
    source = "./module-example"
    region = "us-west-1"
    ip-range = "10.0.0.0/8"
    cluster-size = "3"
}

    $ vim module-example/vars.tf
----------
variable "region" {} # the input parameters
variable "ip-range" {}
variable "cluster-size" {}

    $ vim module-example/output.tf
----------
output "aws-cluster" {
    value = "${aws_instance.instance-1.public_ip},${aws_instance.instance-2.public_ip},${aws_instance.instance-3.public_ip}"
}

    $ vim module-example/output.tf
----------
# vars can be used here
resource "aws_instance" "instance-1" {...}
resource "aws_instance" "instance-2" {...}
resource "aws_instance" "instance-3" {...}

# This is done exactly the same way you would do in your main module.
Use the output from the module in the main part of your code:
----------
output "some-output" {
    value = "${module.module-example.aws-cluster}"
}

