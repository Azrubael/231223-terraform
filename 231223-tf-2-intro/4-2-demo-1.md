# 2023-12-25    11:10
=====================

* 2. Demo variables
-------------------
Sometimes in Vagrant you get requests that are invalid if your time is wrong
So always make sure that the time is correst
    $ vagrant up
    $ vagrant ssh
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 4.15.0-213-generic x86_64)
...

vagrant@ubuntu-bionic:~/4-1-demo-1$ date
    Mon Dec 25 09:23:06 UTC 2023
vagrant@ubuntu-bionic:~/4-1-demo-1$ sudo apt-get install ntpdate ; sudo ntpdate ntp.ubuntu.com
...
25 Dec 09:30:42 ntpdate[2824]: adjust time server 185.125.190.57 offset 0.035000 sec
vagrant@ubuntu-bionic:~/4-1-demo-1$ date
Mon Dec 25 09:31:18 UTC 2023

3-1-terraform-test  3-3-first-steps  4-1-demo-1
vagrant@ubuntu-bionic:~$ cd 4-1-demo-1
vagrant@ubuntu-bionic:~/4-1-demo-1$ ls -hl
total 20K
-rw-rw-r-- 1 vagrant vagrant 145 Dec 25 08:35 instance.tf
-rw-rw-r-- 1 vagrant vagrant 118 Dec 23 17:04 provider.tf
-rw-rw-r-- 1 vagrant vagrant 146 Dec 25 09:08 terraform.tfvars
-rw-rw-r-- 1 vagrant vagrant 256 Dec 25 08:35 vars.tf
-rw-rw-r-- 1 vagrant vagrant  46 Dec 23 17:04 versions.tf


vagrant@ubuntu-bionic:~/4-1-demo-1$ terraform init
...
Terraform has been successfully initialized!
...


vagrant@ubuntu-bionic:~/4-1-demo-1$ terraform plan -out demo1.azrubael
...
  # aws_instance.example will be created
...
Plan: 1 to add, 0 to change, 0 to destroy.

