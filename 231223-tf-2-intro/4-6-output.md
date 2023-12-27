# 2023-12-25    16:52
=====================

6. Outputting attributes
------------------------
Terraform keeps attributes of all the resources you create:
    - e.g. the *aws_instance* resource has the attribute *public_ip*
Those attributes can be *queried* and *outputted*
This can be useful just to output valuable information or to feed information to external software.
# Here's an example. You can use 'output' to display the public IP address of an AWS resource:
------------------------------
resource "aws_instance" "example" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
}

output "ip" {
    value = "${aws_instance.example.public.ip}"
}
------------------------------

You can refer to any attribute by specifying the following elements in your variable (see an example above):
- the resource type: 'aws_instance'
- the resource name: 'example'
- the attribute name: 'public_ip'
You can find the full list of attribute names on the official terraform website:
# https://developer.hashicorp.com/terraform/cli/inspect

You can also use the attributes in a *script* (locally, not in AWS EC2 instance):
------------------------------
resource "aws_instance" "example" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    provisioner "local-exec" {
        command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
    }
}
------------------------------
This will send 'private_ip' in a local file 'private_ips.txt'. So every time this resource created this is going to add this 'private_ip' to a list of private ip addresses.
If we have multiple 'aws_instances', then you can get their private ips in a text file.

You can populate the IP addresses in an *ansible host* file.
Or you have another possibility: execute a script (with attributes as argument) which will take care of a mapping of resource name and the IP address.
