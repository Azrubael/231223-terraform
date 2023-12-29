# 2023-12-29    17:42
=====================


17. Demo Terraform Commands
---------------------------

In this part we'll make an ovewie of the terraform commands, using the source code from 'demo-9' directory.

    $ vagrant up
    $ vagrant ssh
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 4.15.0-213-generic x86_64)
...
Last login: Thu Dec 28 14:57:36 2023 from 10.0.2.2
vagrant@ubuntu-bionic:~$ mkdir 4-17-demo-9
vagrant@ubuntu-bionic:~$ cd 4-17-demo-9
vagrant@ubuntu-bionic:~/4-17-demo-9$ ssh-keygen -f mykey


vagrant@ubuntu-bionic:~/4-17-demo-9$ ls -hltr
total 36K
-rw-rw-r-- 1 vagrant vagrant   46 Dec 23 17:04 versions.tf
-rw-rw-r-- 1 vagrant vagrant  442 Dec 23 17:04 securitygroup.tf
-rw-rw-r-- 1 vagrant vagrant   46 Dec 23 17:04 provider.tf
-rw-rw-r-- 1 vagrant vagrant  112 Dec 23 17:04 key.tf
-rw-r--r-- 1 vagrant vagrant  403 Dec 28 17:36 mykey.pub
-rw------- 1 vagrant vagrant 1.7K Dec 28 17:36 mykey
-rw-rw-r-- 1 vagrant vagrant  309 Dec 29 15:51 vars.tf
-rw-rw-r-- 1 vagrant vagrant 2.6K Dec 29 15:53 vpc.tf
-rw-rw-r-- 1 vagrant vagrant  783 Dec 29 15:54 instance.tf


vagrant@ubuntu-bionic:~/4-17-demo-9$ terraform init
Initializing the backend...
...
Terraform has been successfully initialized!


vagrant@ubuntu-bionic:~/4-17-demo-9$ terraform plan -out demo9.azrubael
...
Terraform will perform the following actions:
  # aws_ebs_volume.ebs-volume-1 will be created
...
Plan: 17 to add, 0 to change, 0 to destroy.


vagrant@ubuntu-bionic:~/4-17-demo-9$ terraform apply "demo9.azrubael"
...
Apply complete! Resources: 17 added, 0 changed, 0 destroyed.


vagrant@ubuntu-bionic:~/4-17-demo-9$ cat terraform.tfstate
...
# OR - it will be more readable
vagrant@ubuntu-bionic:~/4-17-demo-9$ terraform show
...


> AWS > EC2 > "i-07ca5baf556623c30	    Running     t2.micro"
> AWS > EC2 - Security groups > two new SG
> AWS > VPC > six new subnets (3 public and 3 private)
main-private-3	subnet-0bc85c2b2f2122b4c	
Available	vpc-0812dcd5146f41702 | main	10.0.6.0/24	–	251	us-east-1c	use1-az2	us-east-1	rtb-0e40ae56572dd0e8d	acl-0b61e4444671aea0c	No	No	No	-	No	427443251551
	main-public-2	subnet-0067eeb8990aae96d	
Available	vpc-0812dcd5146f41702 | main	10.0.2.0/24	–	251	us-east-1b	use1-az1	us-east-1	rtb-05f3ae1c890d571d4 | main-public-1	acl-0b61e4444671aea0c	No	Yes	No	-	No	427443251551
	main-public-3	subnet-0baf1cb15e533e0a1	
Available	vpc-0812dcd5146f41702 | main	10.0.3.0/24	–	251	us-east-1c	use1-az2	us-east-1	rtb-05f3ae1c890d571d4 | main-public-1	acl-0b61e4444671aea0c	No	Yes	No	-	No	427443251551
	main-private-1	subnet-0d7360e29f7102ddd	
Available	vpc-0812dcd5146f41702 | main	10.0.4.0/24	–	251	us-east-1a	use1-az6	us-east-1	rtb-0e40ae56572dd0e8d	acl-0b61e4444671aea0c	No	No	No	-	No	427443251551
	main-public-1	subnet-013c039839eef8aff	
Available	vpc-0812dcd5146f41702 | main	10.0.1.0/24	–	250	us-east-1a	use1-az6	us-east-1	rtb-05f3ae1c890d571d4 | main-public-1	acl-0b61e4444671aea0c	No	Yes	No	-	No	427443251551
	main-private-2	subnet-04ad0baea301b3ee0	
Available	vpc-0812dcd5146f41702 | main	10.0.5.0/24	–	251	us-east-1b	use1-az1	us-east-1	rtb-0e40ae56572dd0e8d	acl-0b61e4444671aea0c	No	No	No	-	No	427443251551


vagrant@ubuntu-bionic:~/4-17-demo-9$ terraform show | grep public_ip
    associate_public_ip_address          = true
    public_ip                            = "34.203.193.64"
    map_public_ip_on_launch                        = false
    map_public_ip_on_launch                        = false
    map_public_ip_on_launch                        = false
    map_public_ip_on_launch                        = true
    map_public_ip_on_launch                        = true
    map_public_ip_on_launch                        = true
vagrant@ubuntu-bionic:~/4-17-demo-9$ terraform show | grep private_ip
    private_ip                           = "10.0.1.13"
    secondary_private_ips                = []


vagrant@ubuntu-bionic:~/4-17-demo-9$ vim output.tf
vagrant@ubuntu-bionic:~/4-17-demo-9$ cat output.tf
output myoutput {
  value = "${aws_instance.example.public_ip}"
}


vagrant@ubuntu-bionic:~/4-17-demo-9$ terraform refresh
aws_vpc.main: Refreshing state... [id=vpc-0812dcd5146f41702]
aws_key_pair.mykeypair: Refreshing state... [id=mykeypair]
aws_ebs_volume.ebs-volume-1: Refreshing state... [id=vol-0fdc78168c5592163]
aws_subnet.main-public-1: Refreshing state... [id=subnet-013c039839eef8aff]
aws_subnet.main-public-2: Refreshing state... [id=subnet-0067eeb8990aae96d]
aws_subnet.main-private-2: Refreshing state... [id=subnet-04ad0baea301b3ee0]
aws_internet_gateway.main-gw: Refreshing state... [id=igw-090adf559d55af909]
aws_subnet.main-private-3: Refreshing state... [id=subnet-0bc85c2b2f2122b4c]
aws_subnet.main-private-1: Refreshing state... [id=subnet-0d7360e29f7102ddd]
aws_subnet.main-public-3: Refreshing state... [id=subnet-0baf1cb15e533e0a1]
aws_security_group.allow-ssh: Refreshing state... [id=sg-06491b80123f6bafc]
aws_instance.example: Refreshing state... [id=i-07ca5baf556623c30]
aws_route_table.main-public: Refreshing state... [id=rtb-05f3ae1c890d571d4]
aws_route_table_association.main-public-3-a: Refreshing state... [id=rtbassoc-0bacbc15d09050ac2]
aws_route_table_association.main-public-1-a: Refreshing state... [id=rtbassoc-077bf7efea7ef0bc4]
aws_route_table_association.main-public-2-a: Refreshing state... [id=rtbassoc-054a1c46c67bbfacd]
aws_volume_attachment.ebs-volume-1-attachment: Refreshing state... [id=vai-4221521734]
        Outputs:
myoutput = "34.203.193.64"


vagrant@ubuntu-bionic:~/4-17-demo-9$ terraform output
myoutput = "34.203.193.64"


vagrant@ubuntu-bionic:~/4-17-demo-9$ terraform taint aws_instance.example
vagrant@ubuntu-bionic:~/4-17-demo-9$ terraform graph
digraph {
	compound = "true"
	newrank = "true"
	subgraph "root" {
		"[root] aws_ebs_volume.ebs-volume-1 (expand)" [label = "aws_ebs_volume.ebs-volume-1", shape = "box"]
		"[root] aws_instance.example (expand)" [label = "aws_instance.example", shape = "box"]
		"[root] aws_internet_gateway.main-gw (expand)" [label = "aws_internet_gateway.main-gw", shape = "box"]
		"[root] aws_key_pair.mykeypair (expand)" [label = "aws_key_pair.mykeypair", shape = "box"]
		"[root] aws_route_table.main-public (expand)" [label = "aws_route_table.main-public", shape = "box"]
		"[root] aws_route_table_association.main-public-1-a (expand)" [label = "aws_route_table_association.main-public-1-a", shape = "box"]
		"[root] aws_route_table_association.main-public-2-a (expand)" [label = "aws_route_table_association.main-public-2-a", shape = "box"]
		"[root] aws_route_table_association.main-public-3-a (expand)" [label = "aws_route_table_association.main-public-3-a", shape = "box"]
		"[root] aws_security_group.allow-ssh (expand)" [label = "aws_security_group.allow-ssh", shape = "box"]
		"[root] aws_subnet.main-private-1 (expand)" [label = "aws_subnet.main-private-1", shape = "box"]
		"[root] aws_subnet.main-private-2 (expand)" [label = "aws_subnet.main-private-2", shape = "box"]
		"[root] aws_subnet.main-private-3 (expand)" [label = "aws_subnet.main-private-3", shape = "box"]
		"[root] aws_subnet.main-public-1 (expand)" [label = "aws_subnet.main-public-1", shape = "box"]
		"[root] aws_subnet.main-public-2 (expand)" [label = "aws_subnet.main-public-2", shape = "box"]
		"[root] aws_subnet.main-public-3 (expand)" [label = "aws_subnet.main-public-3", shape = "box"]
		"[root] aws_volume_attachment.ebs-volume-1-attachment (expand)" [label = "aws_volume_attachment.ebs-volume-1-attachment", shape = "box"]
		"[root] aws_vpc.main (expand)" [label = "aws_vpc.main", shape = "box"]
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"]" [label = "provider[\"registry.terraform.io/hashicorp/aws\"]", shape = "diamond"]
		"[root] var.AMIS" [label = "var.AMIS", shape = "note"]
		"[root] var.AWS_REGION" [label = "var.AWS_REGION", shape = "note"]
		"[root] var.PATH_TO_PRIVATE_KEY" [label = "var.PATH_TO_PRIVATE_KEY", shape = "note"]
		"[root] var.PATH_TO_PUBLIC_KEY" [label = "var.PATH_TO_PUBLIC_KEY", shape = "note"]
		"[root] aws_ebs_volume.ebs-volume-1 (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
		"[root] aws_instance.example (expand)" -> "[root] aws_key_pair.mykeypair (expand)"
		"[root] aws_instance.example (expand)" -> "[root] aws_security_group.allow-ssh (expand)"
		"[root] aws_instance.example (expand)" -> "[root] aws_subnet.main-public-1 (expand)"
		"[root] aws_instance.example (expand)" -> "[root] var.AMIS"
		"[root] aws_internet_gateway.main-gw (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_key_pair.mykeypair (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
		"[root] aws_key_pair.mykeypair (expand)" -> "[root] var.PATH_TO_PUBLIC_KEY"
		"[root] aws_route_table.main-public (expand)" -> "[root] aws_internet_gateway.main-gw (expand)"
		"[root] aws_route_table_association.main-public-1-a (expand)" -> "[root] aws_route_table.main-public (expand)"
		"[root] aws_route_table_association.main-public-1-a (expand)" -> "[root] aws_subnet.main-public-1 (expand)"
		"[root] aws_route_table_association.main-public-2-a (expand)" -> "[root] aws_route_table.main-public (expand)"
		"[root] aws_route_table_association.main-public-2-a (expand)" -> "[root] aws_subnet.main-public-2 (expand)"
		"[root] aws_route_table_association.main-public-3-a (expand)" -> "[root] aws_route_table.main-public (expand)"
		"[root] aws_route_table_association.main-public-3-a (expand)" -> "[root] aws_subnet.main-public-3 (expand)"
		"[root] aws_security_group.allow-ssh (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_subnet.main-private-1 (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_subnet.main-private-2 (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_subnet.main-private-3 (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_subnet.main-public-1 (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_subnet.main-public-2 (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_subnet.main-public-3 (expand)" -> "[root] aws_vpc.main (expand)"
		"[root] aws_volume_attachment.ebs-volume-1-attachment (expand)" -> "[root] aws_ebs_volume.ebs-volume-1 (expand)"
		"[root] aws_volume_attachment.ebs-volume-1-attachment (expand)" -> "[root] aws_instance.example (expand)"
		"[root] aws_vpc.main (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
		"[root] output.myoutput (expand)" -> "[root] aws_instance.example (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_route_table_association.main-public-1-a (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_route_table_association.main-public-2-a (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_route_table_association.main-public-3-a (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_subnet.main-private-1 (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_subnet.main-private-2 (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_subnet.main-private-3 (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_volume_attachment.ebs-volume-1-attachment (expand)"
		"[root] provider[\"registry.terraform.io/hashicorp/aws\"]" -> "[root] var.AWS_REGION"
		"[root] root" -> "[root] output.myoutput (expand)"
		"[root] root" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)"
		"[root] root" -> "[root] var.PATH_TO_PRIVATE_KEY"
	}
}


