# 2023-12-30    19:17
=====================


9. Demo EBS volumes
-------------------

    $ cd 231230-tf-5-aws
    $ vagrant up
    $ vagrant ssh

vagrant@ubuntu-bionic:~$ mkdir 5-9-ebs-demo9
vagrant@ubuntu-bionic:~$ cd 5-9-ebs-demo9
vagrant@ubuntu-bionic:~/5-9-ebs-demo9$ ssh-keygen -N "" -f mykey
...

vagrant@ubuntu-bionic:~/5-9-ebs-demo9$ ls -hltr
total 44K
-rwxrwxr-x 1 vagrant vagrant   46 Dec 23 17:04 versions.tf
-rwxrwxr-x 1 vagrant vagrant  442 Dec 23 17:04 securitygroup.tf
-rwxrwxr-x 1 vagrant vagrant   46 Dec 23 17:04 provider.tf
-rwxrwxr-x 1 vagrant vagrant  112 Dec 23 17:04 key.tf
-rwxrwxr-x 1 vagrant vagrant  309 Dec 29 15:51 vars.tf
-rwxrwxr-x 1 vagrant vagrant 2.6K Dec 29 15:53 vpc.tf
-rwxrwxr-x 1 vagrant vagrant  783 Dec 29 16:25 instance.tf
-rwxrwxr-x 1 vagrant vagrant   66 Dec 29 17:04 output.tf
-rw------- 1 vagrant vagrant 1.7K Dec 30 15:40 mykey
-rw-r--r-- 1 vagrant vagrant  403 Dec 30 15:40 mykey.pub



vagrant@ubuntu-bionic:~/5-9-ebs-demo9$ terraform init
...

vagrant@ubuntu-bionic:~/5-9-ebs-demo9$ terraform plan -out "demo9.az"
...
Plan: 17 to add, 0 to change, 0 to destroy.


vagrant@ubuntu-bionic:~/5-9-ebs-demo9$ terraform apply "demo9.az"
...


    terraform apply "demo9.az"
vagrant@ubuntu-bionic:~/5-9-ebs-demo9$ terraform apply "demo9.az"
aws_ebs_volume.ebs-volume-1: Destroying... [id=vol-0f056cf1c5ec4818e]
aws_ebs_volume.ebs-volume-1: Still destroying... [id=vol-0f056cf1c5ec4818e, 10s elapsed]
aws_ebs_volume.ebs-volume-1: Destruction complete after 11s
aws_ebs_volume.ebs-volume-1: Creating...
aws_ebs_volume.ebs-volume-1: Still creating... [10s elapsed]
aws_ebs_volume.ebs-volume-1: Creation complete after 11s [id=vol-06eac403605247074]
aws_volume_attachment.ebs-volume-1-attachment: Creating...
aws_volume_attachment.ebs-volume-1-attachment: Still creating... [10s elapsed]
aws_volume_attachment.ebs-volume-1-attachment: Still creating... [20s elapsed]
aws_volume_attachment.ebs-volume-1-attachment: Creation complete after 22s [id=vai-2743182081]

Apply complete! Resources: 2 added, 0 changed, 1 destroyed.

Outputs:

myoutput = "54.224.68.216"



vagrant@ubuntu-bionic:~/5-9-ebs-demo9$ terraform show
# aws_ebs_volume.ebs-volume-1:
resource "aws_ebs_volume" "ebs-volume-1" {
    arn                  = "arn:aws:ec2:us-east-1:427443251551:volume/vol-06eac403605247074"
    availability_zone    = "us-east-1a"
    encrypted            = false
    final_snapshot       = false
    id                   = "vol-06eac403605247074"
    iops                 = 100
    multi_attach_enabled = false
    size                 = 10
    tags                 = {
        "Name" = "extra volume data"
    }
    tags_all             = {
        "Name" = "extra volume data"
    }
    throughput           = 0
    type                 = "gp2"
}

# aws_instance.example:
resource "aws_instance" "example" {
    ami                                  = "ami-010b814555e3268fa"
    arn                                  = "arn:aws:ec2:us-east-1:427443251551:instance/i-0a3e962bbea4ec39e"
    associate_public_ip_address          = true
    availability_zone                    = "us-east-1a"
    cpu_core_count                       = 1
    cpu_threads_per_core                 = 1
    disable_api_stop                     = false
    disable_api_termination              = false
    ebs_optimized                        = false
    get_password_data                    = false
    hibernation                          = false
    id                                   = "i-0a3e962bbea4ec39e"
    instance_initiated_shutdown_behavior = "stop"
    instance_state                       = "running"
    instance_type                        = "t2.micro"
    ipv6_address_count                   = 0
    ipv6_addresses                       = []
    key_name                             = "mykeypair"
    monitoring                           = false
    placement_partition_number           = 0
    primary_network_interface_id         = "eni-05864a1854a2ff5a7"
    private_dns                          = "ip-10-0-1-157.ec2.internal"
    private_ip                           = "10.0.1.157"
    public_dns                           = "ec2-54-224-68-216.compute-1.amazonaws.com"
    public_ip                            = "54.224.68.216"
    secondary_private_ips                = []
    security_groups                      = []
    source_dest_check                    = true
    subnet_id                            = "subnet-0ff0f1958a2eb90cf"
    tags                                 = {}
    tags_all                             = {}
    tenancy                              = "default"
    user_data_replace_on_change          = false
    vpc_security_group_ids               = [
        "sg-0e54f1194707a9706",
    ]

...


vagrant@ubuntu-bionic:~/5-9-ebs-demo9$ ssh -i "mykey" ubuntu@54.224.68.216
The authenticity of host '54.224.68.216 (54.224.68.216)' can't be established.
...
 ||IOanyT Innovations Inc.||
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1078-aws x86_64)
...


# Let's check the state of our filesystem, then attach an EBS volume and create a filesystem on it
ubuntu@ip-10-0-1-157:~$ sudo -s
root@ip-10-0-1-157:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            473M     0  473M   0% /dev
tmpfs            98M  792K   97M   1% /run
/dev/xvda1      7.6G  1.9G  5.8G  24% /
tmpfs           488M     0  488M   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           488M     0  488M   0% /sys/fs/cgroup
/dev/loop0       56M   56M     0 100% /snap/core18/2409
/dev/loop1       26M   26M     0 100% /snap/amazon-ssm-agent/5656
/dev/xvda15     105M  4.4M  100M   5% /boot/efi
/dev/loop3       41M   41M     0 100% /snap/snapd/20290
/dev/loop4       56M   56M     0 100% /snap/core18/2812
tmpfs            98M     0   98M   0% /run/user/1000

root@ip-10-0-1-157:~# mkfs.ext4 /dev/xvdh
mke2fs 1.44.1 (24-Mar-2018)
Creating filesystem with 2621440 4k blocks and 655360 inodes
Filesystem UUID: 54c01c4f-593f-489c-99f3-6e1123d40ad8
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632
Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done 


root@ip-10-0-1-157:~# mkdir /data
root@ip-10-0-1-157:~# mount /dev/xvdh /data
root@ip-10-0-1-157:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            473M     0  473M   0% /dev
tmpfs            98M  792K   97M   1% /run
/dev/xvda1      7.6G  1.9G  5.8G  24% /
tmpfs           488M     0  488M   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           488M     0  488M   0% /sys/fs/cgroup
/dev/loop0       56M   56M     0 100% /snap/core18/2409
/dev/loop1       26M   26M     0 100% /snap/amazon-ssm-agent/5656
/dev/xvda15     105M  4.4M  100M   5% /boot/efi
/dev/loop3       41M   41M     0 100% /snap/snapd/20290
/dev/loop4       56M   56M     0 100% /snap/core18/2812
tmpfs            98M     0   98M   0% /run/user/1000
/dev/xvdh       9.8G   37M  9.3G   1% /data


root@ip-10-0-1-157:~# vim /etc/fstab
----------
LABEL=cloudimg-rootfs   /        ext4   defaults,discard        0 1
LABEL=UEFI      /boot/efi       vfat    umask=0077      0 1
/dev/xvdh  /data   ext4   defaults   0 0

root@ip-10-0-1-157:~# exit
ubuntu@ip-10-0-1-157:~$ logout
Connection to 54.224.68.216 closed.


vagrant@ubuntu-bionic:~/5-9-ebs-demo9$ terraform destroy
...
Destroy complete! Resources: 17 destroyed.

