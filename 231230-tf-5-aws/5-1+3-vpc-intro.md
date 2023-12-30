# 2023-12-29    19:57
=====================

1. Introduction to VPCs
-----------------------

Frirst you need how to create a VPC on AWS using terraform.
VPC isolates instances on a *network* level, it's like your ouw network in the cloud. Before we were using a default VPC and fron now we're going to create the new ones.

Best practices is to always launch your instances in a VPC [on a default VPC or you can create your new VPCs]

There's also EC2-Classic, ehich is basically one big network where all AWS customers cloud launch their instances in. DigitalOcean provider doesn't have VPC so it looks much more like "EC2-Classic", where you have to set and use FIREWALL instead mor complicate and perfect things like ACL (access control lists).
So VPC is much better than FIREWALL rules. VPC completely isolate your infrastructure.

For smaller to medium setups *one VPC* (per region) will be suitable for your needs.

An instance launched in one VPC can never communicate with an instance in an other VPC using their *private IP addresses*. They also *can* communicate by using puplis IPs (but it's not recommended for security reasons).

You could also link two VPCs, what is called *VPC peering*.



# 2023-12-30    11:59
=====================

2. Introduction to VPCs - Part II
---------------------------------

See *231229-TF-5-aws-vpc.png*
The private IPs only can be used privately within a VPC, or in a home network, or in an office network.
When you create a VPC, in the beginning you typically choose your subnet:
So what does this "/16" and "/8" really mean?

Class       Range CIDR            From IP            To IP
A           10.0.0.0/8            10.0.0.0           10.255.255.255
B           172.16.0.0/12         172.16.0.0         172.31.255.255  <- 
C           192.168.0.0/16        192.168.0.0        192.168.255.255 <- you can also use

Class [Range]   Network Mask  Total addr.   Examples    Description
A [10.0.0.0/8]  255.0.0.0     16777214      10.0.0.1    Full 10.x.x.x range
                                         10.100.200.20  AWS by default users
A [10.0.0.0/16] 255.255.0.0   65536         10.0.5.1    What we use for
                                         10.0.100.219   our VPC on AWS
A [10.1.0.0/16] 255.255.0.0   65536         10.1.5.1    We can use for *another*
                                         10.1.100.219   our VPC on AWS
A [10.0.0.0/24] 255.255.255.0   256      from 10.0.0.0  We can use for *subnet*
                                         to 10.0.0.255  (too small for VPC)
A [10.0.1.0/24] 255.255.255.0   256      from 10.0.1.0  We can use for another
                                         to 10.0.1.255  *subnet*
A [10.0.7.5/32] 255.255.255.255   1      10.0.7.5       Only a single host



3. Introduction to terraform - Part III
---------------------------------------

Every availability zone in the VPC has its own public IP and a private subnet, see Take a look at *231229-TF-5-aws-vpc.png* where you can see six private and public subnets:
['10.0.1.0/24', '10.0.2.0/24', '10.0.3.0/24', '10.0.4.0/24', '10.0.5.0/24', '10.0.6.0/24']
with two subnets in each of availability zones:
['eu-west-1a', 'eu-west-1b', 'eu-west-1c']

All the public subnets are connected to an *Internet Gateway*. These instances will also have public IP address, allowing them to be reachable from the internet.
Instances launched in the private subnets din't get a public IP address, so they will not be reachable from the internet.
Instances from the *main-public* can reach instances from *main-private*, because they're all in the same VPC. This of course if you set the firewall to allow traffic from one to another.

Typically you use the public subnets for internet-facing services/applications.
Databases, caching services and backends all go into the private subnets.
If you use a Load Balabcer (LB), you will typically put the LB in the public subnets and the instances serving an application in the private sublets.


