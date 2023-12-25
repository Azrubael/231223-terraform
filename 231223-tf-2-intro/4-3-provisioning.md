# 2023-12-25    11:33
=====================

3. Software Provisioning
------------------------

vagrant@ubuntu-bionic:~/4-1-demo-1$ terraform version
Terraform v1.6.6


There are two ways to *provision software* on your instances:
1. You can build your *own custom AMI* and bundle your software with the image
    *Packer* is a great tool to do this
    
2. You can coot *standartized AMI* and then install the software on it by:
    + using file uploads
    + usig remote exec (scripts)
    + using automation tools like Chef, Puppet or Ansible

Now Chef is intergrated within terraform, so you can have Chef statements within *.tf files.
    *Chef scripts are supported in Terraform v1.6.6* from (Q4 2016)
Terraform continues to support the Chef Provider, which allows you to provision and manage infrastructure using Chef scripts. The Chef Provider is an open-source plugin for Terraform developed by HashiCorp. It enables you to define and manage Chef resources within your Terraform configuration.
    You can run *Puppet agent* using remote-exec.
    For *Ansible* you can first run terraform and output the IP adress then run *ansible-playbook* on those hosts. There are *3rd party initiatives* integrating *Ansible* with *terraform*.

File uploads is an easies way to upload a file or script.
It can be used in conjunction with *remote-exec* to execute  a script
The provosioner may use SSH (for Linux hosts) or WinRM (for Windows hosts)

# An example of file uploads
----------------------------
resource "aws_instance" "example" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"

    provisioner "file" {
        source = "app.conf"
        destination = "/etc/myapp.conf"
    }
}
----------------------------

# To override the SSH defaults you can use "connection":
# you'll use this way in most usecases.
# The type of the conection is *ssh* by default, if you want to use
# other type, you have to declare it.
----------------------------
resource "aws_instance" "example" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"

    provisioner "file" {
        source = "script.sh"
        destination = "/opt/script.sh"
        connection {
            type = "ssh"
            user = "${var.instance_username}"
            password = "${var.instance_password}"
        }
    }
}
----------------------------

# Typically on AWS you'll use SSH keypairs and execute a script using remote-exec
----------------------------
resource "aws_key_pair" "some-key" {
    key_name = "mykey"
    public_key = "ssh-rsa my-public-key"
}

resource "aws_instance" "example" {
    ami = "${lookup(var.AMIS, var.AWS_REGION)}"
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.mykey.key_name}"

    provisioner "file" {
        source = "sript.sh"
        destination = "/opt/script.sh"
        connection {
            type = "ssh"
            user = "${var.instance_username}"
            private_key = "${file(${var.path_to_private_key})}"
        }
    }
    provisioner "remote-exec" {
        inline = [
            "chmod +x /opt/script.sh"
            "/opt/script.sh arguments"
        ]
    }
}
----------------------------

