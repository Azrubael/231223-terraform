# 2023-12-30    12:59
=====================


4. Demo VPCs and NAT
--------------------

In this demo we'll deep in details of how to use VPC with Terraform.
    $ cd 231230-tf-5-aws
    $ vagrant up
    $ vagrant ssh
vagrant@ubuntu-bionic:~$ aws --version
aws-cli/1.18.69 Python/3.6.9 Linux/4.15.0-212-generic botocore/1.16.19

vagrant@ubuntu-bionic:~$ aws configure
[devops-awscli]

vagrant@ubuntu-bionic:~$ sudo cp -r /vagrant/5-4-vpc-demo7 5-4-vpc-demo7
vagrant@ubuntu-bionic:~$ ls -hltr 5-4-vpc-demo7
total 20K
-rw-r--r-- 1 root root   46 Dec 30 11:29 provider.tf
-rw-r--r-- 1 root root   46 Dec 30 11:29 versions.tf
-rw-r--r-- 1 root root  972 Dec 30 11:29 nat.tf
-rw-r--r-- 1 root root 2.6K Dec 30 11:29 vpc.tf
-rw-r--r-- 1 root root   50 Dec 30 11:29 vars.tf

vagrant@ubuntu-bionic:~$ sudo chmod +w 5-4-vpc-demo7
vagrant@ubuntu-bionic:~$ sudo chown vagrant:vagrant 5-4-vpc-demo7
vagrant@ubuntu-bionic:~$ sudo chown vagrant:vagrant 5-4-vpc-demo7/*
vagrant@ubuntu-bionic:~$ cd 5-4-vpc-demo7
vagrant@ubuntu-bionic:~/5-4-vpc-demo7$ sudo chmod +x *

vagrant@ubuntu-bionic:~/5-4-vpc-demo7$ terraform init
...
Terraform has been successfully initialized!


vagrant@ubuntu-bionic:~/5-4-vpc-demo7$ terraform plan -out demo7.az
...
Plan: 18 to add, 0 to change, 0 to destroy.
...

vagrant@ubuntu-bionic:~/5-4-vpc-demo7$ terraform apply "demo7.az"
...
Apply complete! Resources: 18 added, 0 changed, 0 destroyed.


vagrant@ubuntu-bionic:~/5-4-vpc-demo7$ terraform graph
digraph {
	compound = "true"
	newrank = "true"
	subgraph "root" {
		"[root] aws_eip.nat (expand)" [label = "aws_eip.nat", shape = "box"]
		"[root] aws_internet_gateway.main-gw (expand)" [label = "aws_internet_gateway.main-gw", shape = "box"]
		"[root] aws_nat_gateway.nat-gw (expand)" [label = "aws_nat_gateway.nat-gw", shape = "box"]
		"[root] aws_route_table.main-private (expand)" [label = "aws_route_table.main-private", shape = "box"]
		"[root] aws_route_table.main-public (expand)" [label = "aws_route_table.main-public", shape = "box"]
		"[root] aws_route_table_association.main-private-1-a (expand)" [label = "aws_route_table_association.main-private-1-a", shape = "box"]
		"[root] aws_route_table_association.main-private-2-a (expand)" [label = "aws_route_table_association.main-private-2-a", shape = "box"]
		"[root] aws_route_table_association.main-private-3-a (expand)" [label = "aws_route_table_association.main-private-3-a", shape = "box"]
		"[root] aws_route_table_association.main-public-1-a (expand)" [label = "aws_route_table_association.main-public-1-a", shape = "box"]
		"[root] aws_route_table_association.main-public-2-a (expand)" [label = "aws_route_table_association.main-public-2-a", shape = "box"]
		"[root] aws_route_table_association.main-public-3-a (expand)" [label = "aws_route_table_association.main-public-3-a", shape = "box"]
		"[root] aws_subnet.main-private-1 (expand)" [label = "aws_subnet.main-private-1", shape = "box"]
		"[root] aws_subnet.main-private-2 (expand)" [label = "aws_subnet.main-private-2", shape = "box"]
		"[root] aws_subnet.main-private-3 (expand)" [label = "aws_subnet.main-private-3", shape = "box"]
		"[root] aws_subnet.main-public-1 (expand)" [label = "aws_subnet.main-public-1", shape = "box"]
		"[root] aws_subnet.main-public-2 (expand)" [label = "aws_subnet.main-public-2", shape = "box"]
		"[root] aws_subnet.main-public-3 (expand)" [label = "aws_subnet.main-public-3", shape = "box"]
		"[root] aws_vpc.main (expand)" [label = "aws_vpc.main", shape = "box"]
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"]" [label = "provider[\"registry.terraform.io/hashicorp/aws\"]", shape = "diamond"]
		"[root] var.AWS_REGION" [label = "var.AWS_REGION", shape = "note"]
		"[root] aws_eip.nat (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
		"[root] aws_internet_gateway.main-gw (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_nat_gateway.nat-gw (expand)" -> "[root] aws_eip.nat (expand)"
		"[root] aws_nat_gateway.nat-gw (expand)" -> "[root] aws_internet_gateway.main-gw (expand)"
		"[root] aws_nat_gateway.nat-gw (expand)" -> "[root] aws_subnet.main-public-1 (expand)"
		"[root] aws_route_table.main-private (expand)" -> "[root] aws_nat_gateway.nat-gw (expand)"
		"[root] aws_route_table.main-public (expand)" -> "[root] aws_internet_gateway.main-gw (expand)"
		"[root] aws_route_table_association.main-private-1-a (expand)" -> "[root] aws_route_table.main-private (expand)"
		"[root] aws_route_table_association.main-private-1-a (expand)" -> "[root] aws_subnet.main-private-1 (expand)"
		"[root] aws_route_table_association.main-private-2-a (expand)" -> "[root] aws_route_table.main-private (expand)"
		"[root] aws_route_table_association.main-private-2-a (expand)" -> "[root] aws_subnet.main-private-2 (expand)"
		"[root] aws_route_table_association.main-private-3-a (expand)" -> "[root] aws_route_table.main-private (expand)"
		"[root] aws_route_table_association.main-private-3-a (expand)" -> "[root] aws_subnet.main-private-3 (expand)"
		"[root] aws_route_table_association.main-public-1-a (expand)" -> "[root] aws_route_table.main-public (expand)"
		"[root] aws_route_table_association.main-public-1-a (expand)" -> "[root] aws_subnet.main-public-1 (expand)"
		"[root] aws_route_table_association.main-public-2-a (expand)" -> "[root] aws_route_table.main-public (expand)"
		"[root] aws_route_table_association.main-public-2-a (expand)" -> "[root] aws_subnet.main-public-2 (expand)"
		"[root] aws_route_table_association.main-public-3-a (expand)" -> "[root] aws_route_table.main-public (expand)"
		"[root] aws_route_table_association.main-public-3-a (expand)" -> "[root] aws_subnet.main-public-3 (expand)"
		"[root] aws_subnet.main-private-1 (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_subnet.main-private-2 (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_subnet.main-private-3 (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_subnet.main-public-1 (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_subnet.main-public-2 (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_subnet.main-public-3 (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_vpc.main (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_route_table_association.main-private-1-a (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_route_table_association.main-private-2-a (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_route_table_association.main-private-3-a (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_route_table_association.main-public-1-a (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_route_table_association.main-public-2-a (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_route_table_association.main-public-3-a (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"]" -> "[root] var.AWS_REGION"
		"[root] root" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)"
	}
}


vagrant@ubuntu-bionic:~/5-4-vpc-demo7$ mkdir 5-6-vpc-ec2-demo7
vagrant@ubuntu-bionic:~/5-4-vpc-demo7$ cp terraform.tfstate ../5-6-vpc-ec2-demo7/terreform.tfstate

vagrant@ubuntu-bionic:~/5-4-vpc-demo7$ terraform destroy
...
Destroy complete! Resources: 18 destroyed.
