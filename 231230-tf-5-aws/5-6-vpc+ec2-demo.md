# 2023-12-30    17:30
=====================


6. Demo Launching instances in a VPC
------------------------------------

    $ vagrant up
    $ vagrant ssh

vagrant@ubuntu-bionic:~$ mkdir 5-6-vpc-demo8
vagrant@ubuntu-bionic:~$ cd 5-6-vpc-demo8
vagrant@ubuntu-bionic:~/5-6-vpc$ ssh-keygen -N "" -f mykeypair
Generating public/private rsa key pair.
Your identification has been saved in mykeypair.
Your public key has been saved in mykeypair.pub.
The key fingerprint is:
SHA256:yxph1qHJmDakxH69ze7WAp7awCsDmjFfeeUBbbdPJ1w vagrant@ubuntu-bionic
The key's randomart image is:
+---[RSA 2048]----+
|       .         |
| .    . o .   E  |
|  o .  o.. o .   |
| o o = +o.. + .  |
|  o *.OoS. o o   |
|+  +o+o*..  .    |
|.* .oooo=.       |
|o +  +o+o .      |
|   oo.ooo.       |
+----[SHA256]-----+

vagrant@ubuntu-bionic:~/5-6-vpc$ ls -ghltr
total 64K
-rw-rw-r-- 1 vagrant  123 Dec 30 15:32 provider.tf
-rw-rw-r-- 1 vagrant  332 Dec 30 15:32 instance.tf
-rw-rw-r-- 1 vagrant  265 Dec 30 15:32 vars.tf
-rw-rw-r-- 1 vagrant  495 Dec 30 15:33 securitygroup.tf
-rw-rw-r-- 1 vagrant  105 Dec 30 15:36 keypairs.tf
-rw------- 1 vagrant 1.7K Dec 30 15:40 mykeypair
-rw-r--r-- 1 vagrant  403 Dec 30 15:40 mykeypair.pub
-rw-rw-r-- 1 vagrant  25K Dec 30 15:43 terraform.tfstate
-rw-rw-r-- 1 vagrant 2.6K Dec 30 15:48 vpc.tf
-rw-rw-r-- 1 vagrant  163 Dec 30 15:56 terraform.tfvars


vagrant@ubuntu-bionic:~/5-6-vpc$ terraform plan -out demo8.az
...
Plan: 21 to add, 0 to change, 0 to destroy.


vagrant@ubuntu-bionic:~/5-6-vpc$ ls -ghltr
total 52K
-rwxr-xr-x 1 vagrant   46 Dec 30 11:29 versions.tf
-rwxr-xr-x 1 vagrant  972 Dec 30 11:29 nat.tf
-rwsrwsr-x 1 vagrant  123 Dec 30 15:32 provider.tf
-rwxrwxr-x 1 vagrant  332 Dec 30 15:32 instance.tf
-rwxrwxr-x 1 vagrant  265 Dec 30 15:32 vars.tf
-rwxrwxr-x 1 vagrant  495 Dec 30 15:33 securitygroup.tf
-rwxrwxr-x 1 vagrant  105 Dec 30 15:36 keypairs.tf
-rw------- 1 vagrant 1.7K Dec 30 15:40 mykeypair
-rw-r--r-- 1 vagrant  403 Dec 30 15:40 mykeypair.pub
-rwxrwxr-x 1 vagrant 2.6K Dec 30 15:48 vpc.tf
-rwxrwxr-x 1 vagrant   96 Dec 30 16:10 terraform.tfvars
-rw-rw-r-- 1 vagrant 7.5K Dec 30 16:10 demo8.az


vagrant@ubuntu-bionic:~/5-6-vpc$ terraform apply "demo8.az"
...
Apply complete!


vagrant@ubuntu-bionic:~/5-6-vpc$ cat terraform.tfstate | grep public_
            "public_dns": "ec2-18-214-101-252.compute-1.amazonaws.com",
            "public_ip": "18.214.101.252",
            "public_ipv4_pool": "amazon",
            "associate_public_ip_address": true,
            "public_dns": "ec2-54-83-158-238.compute-1.amazonaws.com",
            "public_ip": "54.83.158.238",
            "public_key": "... vagrant@ubuntu-bionic",
            "public_ip": "18.214.101.252",
            "map_public_ip_on_launch": false,
            "map_public_ip_on_launch": false,
            "map_public_ip_on_launch": false,
            "map_public_ip_on_launch": true,
            "map_public_ip_on_launch": true,
            "map_public_ip_on_launch": true,




# let's try to login on our EC2 instance with Ubuntu 18.04 IOanyT
instance.tf  mykeypair.pub  securitygroup.tf   terraform.tfvars          vpc.tf
keypairs.tf  nat.tf         terraform.tfstate  vars.tf
vagrant@ubuntu-bionic:~/5-6-vpc$ ssh -i mykeypair ubuntu@54.83.158.238
...
 ||IOanyT Innovations Inc.||
Welcome to Ubuntu 18.04.6 LTS (GNU/Linux 5.4.0-1078-aws x86_64)
...
Last login: Fri Jul  1 06:58:30 2022 from 180.151.238.62


ubuntu@ip-10-0-1-174:~$ sudo -s
root@ip-10-0-1-174:~# ifconfig
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 9001
        inet 10.0.1.174  netmask 255.255.255.0  broadcast 10.0.1.255    <<<< IP
        inet6 fe80::cf0:73ff:fe87:7bf5  prefixlen 64  scopeid 0x20<link>
        ether 0e:f0:73:87:7b:f5  txqueuelen 1000  (Ethernet)
        RX packets 146476  bytes 214578945 (214.5 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 10074  bytes 766092 (766.0 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 144  bytes 15148 (15.1 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 144  bytes 15148 (15.1 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0


# to see that everything with the VPC has a separate line, and will be contacting directly without going through gateway

root@ip-10-0-1-174:~# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         10.0.1.1        0.0.0.0         UG    100    0        0 eth0
10.0.1.0        0.0.0.0         255.255.255.0   U     0      0        0 eth0
10.0.1.1        0.0.0.0         255.255.255.255 UH    100    0        0 eth0

root@ip-10-0-1-174:~# ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=58 time=1.53 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=58 time=1.61 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=58 time=1.61 ms


root@ip-10-0-1-174:~# exit
exit
ubuntu@ip-10-0-1-174:~$ exit
logout
Connection to 54.83.158.238 closed.


vagrant@ubuntu-bionic:~/5-6-vpc$ terraform destroy
...
  Enter a value: yes
...
Destroy complete! Resources: 21 destroyed.
