# 2023-12-30    18:50
=====================


8. EBS Volumes
--------------

The t2.micro EC2 instance with particular AMI automatically adds 8GB of EBS storage (Elastic Block Storage).
Some instance types have *local storage* on the instance itself. This is called ephemeral storge. Ephemeral storage is always lost when the EC2 instance terminates.

The 8GB *root volume* storage that comes with the EC2 instance is also set to be automatically removed when the instance is terminated. You can still instruct AWS not ot do it, but it will be antipattern of a bad practices.

In our next example we'll adding an exra EBS storage volume that can be used for the log files, and any other real data. That data will be persisted until we instruct AWS to remove it.
EBS storage can be added using a terraform resource and then attached to our instance.

# A simple example of adding extra 20GB to 8GB of existing root volume.
    $ vim instance.tf
----------
resource "aws_instance" "example" {
    ...
    # But if you want to increase the storage or type of the root volume, you can use 'root_block_device' within the "aws_instance" resource
    root_block_device {
        volume_size = 16
        volume_type = "gp2"
        delete_on_termination = true  # the default behaviour
    }
    
}

resource "aws_ebs_volume" "ebs-volume-1" {
    availability_zone = "ue-west-1a"
    size = 20
    type = "gp2"  # General Purpose storage (can be standard/io1/st1)
    tags {
        Name = "extra volume data"
    }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
    device_name = "/dev/xvdh"
    volume_id = "${aws_ebs_volume.ebs-volume-1.id}"
    instance_id = "${aws_instance.example.id}"
}


