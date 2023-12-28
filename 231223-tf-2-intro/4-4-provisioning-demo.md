# 2023-12-25    15:06
=====================

4. Demo Software provisioning
-----------------------------

# https://whatsmyip.org
> AWS > VPC > Security > Security groups > Name: tf-SG >
    All TPP: My IP > *CREATE*

    $ vagrant ssh
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 4.15.0-213-generic x86_64)
...

vagrant@ubuntu-bionic:~$ ssh-keygen -N "" -f $HOME/.ssh/id_rsa
vagrant@ubuntu-bionic:~$ cd 4-4-demo-2

vagrant@ubuntu-bionic:~/4-4-demo-2$ terraform init
...
Terraform has been successfully initialized!
...

vagrant@ubuntu-bionic:~/4-4-demo-2$ terraform plan -out myplan.az
...
Plan: 2 to add, 0 to change, 0 to destroy.
Saved the plan to: myplan.az
...

vagrant@ubuntu-bionic:~/4-4-demo-2$ terraform apply "myplan.az"
aws_key_pair.mykey: Creating...
...
aws_instance.example: Provisioning with 'remote-exec'...
aws_instance.example (remote-exec): Connecting to remote host via SSH...
                                                \/\/\/\/
aws_instance.example (remote-exec):   Host: 44.201.139.214
aws_instance.example (remote-exec):   User: ubuntu
aws_instance.example (remote-exec):   Password: false
aws_instance.example (remote-exec):   Private key: true
aws_instance.example (remote-exec):   Certificate: false
aws_instance.example (remote-exec):   SSH Agent: false
aws_instance.example (remote-exec):   Checking Host Key: false
aws_instance.example (remote-exec):   Target Platform: unix
aws_instance.example (remote-exec): Connected!
...
aws_instance.example: Still creating... [1m10s elapsed]
aws_instance.example: Creation complete after 1m12s [id=i-0b5f9a55308803a93]
Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

vagrant@ubuntu-bionic:~/4-4-demo-2$ terraform plan
aws_key_pair.mykey: Refreshing state... [id=mykey]
aws_instance.example: Refreshing state... [id=i-0b5f9a55308803a93]
    No changes. Your infrastructure matches the configuration.
Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

# http://44.201.139.214
# Welcome to NGINX!


vagrant@ubuntu-bionic:~/4-4-demo-2$ terraform destroy
...

Plan: 0 to add, 0 to change, 2 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

