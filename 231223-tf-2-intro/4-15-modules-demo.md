# 2023-12-28    19:21
=====================

15. Demo An external Module
---------------------------

Here we'll study how to use modules. We're going to use an external module that will spin up a console cluster.

    $ vagrant up
    $ vagrant ssh
    $ mkdir 4-15-demo-6
    $ cd 4-15-demo-6
    $ ssh-keygen -f mykey

vagrant@ubuntu-bionic:~/4-15-demo-6$ ls -ghltr
total 32K
-rw-rw-r-- 1 vagrant   46 Dec 23 17:04 versions.tf
-rw-rw-r-- 1 vagrant   47 Dec 23 17:04 provider.tf
-rw-rw-r-- 1 vagrant  468 Dec 23 17:04 modules.tf
-rw-rw-r-- 1 vagrant  104 Dec 23 17:04 key.tf
-rw-rw-r-- 1 vagrant  831 Dec 23 17:04 default_vpc.tf
-rw-rw-r-- 1 vagrant  168 Dec 28 17:26 vars.tf
-rw-r--r-- 1 vagrant  403 Dec 28 17:36 mykey.pub
-rw------- 1 vagrant 1.7K Dec 28 17:36 mykey


vagrant@ubuntu-bionic:~/4-15-demo-6$ terraform init
    Initializing the backend...
    Initializing modules...
Downloading git::https://github.com/wardviaene/terraform-consul-module.git?ref=terraform-0.12 for consul...
...
Terraform has been successfully initialized!


vagrant@ubuntu-bionic:~/4-15-demo-6$ terraform plan -out demo6.azrubael
...
Plan: 9 to add, 0 to change, 0 to destroy.
...


vagrant@ubuntu-bionic:~/4-15-demo-6$ terraform apply "demo6.azrubael"
Apply complete! Resources: 9 added, 0 changed, 0 destroyed.
Outputs:
consul-output = "ec2-54-80-28-116.compute-1.amazonaws.com"


> AWS > EC2 > there are three running instances:
    consul-0,    consul-1,    consul-2

> AWS > EC2 > there are three running subnets except default


vagrant@ubuntu-bionic:~/4-15-demo-6$ terraform destroy
...
Destroy complete! Resources: 9 destroyed.
vagrant@ubuntu-bionic:~/4-15-demo-6$ 

