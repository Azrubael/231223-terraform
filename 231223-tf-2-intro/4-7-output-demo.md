# 2023-12-27    16:23
=====================

7. Demo Outputting Attributes
-----------------------------

In this demo we'll just apply and what we've seen in the theory.
I'm going to start an instance and "output" some of the attributes, see '/4-7-demo-3'.

    $ vagrant reload --provision
    $ vagrant ssh
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 4.15.0-213-generic x86_64)
...
Last login: Wed Dec 27 14:21:55 2023 from 10.0.2.2

vagrant@ubuntu-bionic:~$ ls
3-1-terraform-test  3-3-first-steps  4-1-demo-1  4-4-demo-2  4-7-demo-3
vagrant@ubuntu-bionic:~$ cd 4-7-demo-3
vagrant@ubuntu-bionic:~/4-7-demo-3$ ls
instance.tf  provider.tf  terraform.tfvars  vars.tf  versions.tf

vagrant@ubuntu-bionic:~/4-7-demo-3$ terraform init
Initializing the backend...
Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v5.31.0...
- Installed hashicorp/aws v5.31.0 (signed by HashiCorp)


vagrant@ubuntu-bionic:~/4-7-demo-3$ terraform plan -out demo3.azrubael
...
  # aws_instance.example will be created
  + resource "aws_instance" "example" {
      + ami                                  = "ami-010b814555e3268fa"
...
      + instance_type                        = "t2.micro"
...
Saved the plan to: demo3.azrubael


vagrant@ubuntu-bionic:~/4-7-demo-3$ terraform apply demo3.azrubael
aws_instance.example: Creating...
aws_instance.example: Still creating... [10s elapsed]
aws_instance.example: Still creating... [20s elapsed]
aws_instance.example: Still creating... [30s elapsed]
aws_instance.example: Provisioning with 'local-exec'...
aws_instance.example (local-exec): Executing: ["/bin/sh" "-c" "echo 172.31.95.182 >> private_ips.txt"]
aws_instance.example: Creation complete after 34s [id=i-0af78493eb12ab632]
    Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
    Outputs:
    ip = "44.211.211.64"


vagrant@ubuntu-bionic:~/4-7-demo-3$ cat private_ips.txt
172.31.95.182


vagrant@ubuntu-bionic:~/4-7-demo-3$ terraform destroy
aws_instance.example: Refreshing state... [id=i-0af78493eb12ab632]
...
Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.
        Enter a value: yes
aws_instance.example: Destroying... [id=i-0af78493eb12ab632]
aws_instance.example: Still destroying... [id=i-0af78493eb12ab632, 10s elapsed]
aws_instance.example: Still destroying... [id=i-0af78493eb12ab632, 20s elapsed]
aws_instance.example: Still destroying... [id=i-0af78493eb12ab632, 30s elapsed]
aws_instance.example: Still destroying... [id=i-0af78493eb12ab632, 40s elapsed]
aws_instance.example: Destruction complete after 41s
Destroy complete! Resources: 1 destroyed.


vagrant@ubuntu-bionic:~/4-7-demo-3$ date
Wed Dec 27 16:07:59 UTC 2023
