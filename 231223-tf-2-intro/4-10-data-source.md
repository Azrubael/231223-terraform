# 2023-12-28    13:06
=====================

10. Data Sources
----------------

For certain providers like AWS, terraform provides datasources.
Datsources provide you with dynamic information:
- a lot of data is available by AWS in a structed format using their API;
- terraform also exposes this informationusing data sources.

Examples:
- list of AMIs;
- list of availability Zones.
Another example is the datasourcetat gives you all IP addressesin use by AWS.
This is great if you want to filter traffic based on an AWS region, e.g. allow traffic from mazon instances in Europe.
Filtering traffic in AWS can be done using *security groups*:
- incoming and outgoing traffic can be filtered by protocol, IP range and port;
- similaf to IPtables (linux) of a firewallappliance/.

# Here is an example of a datasource
-----------
data "aws_ip_ranges" "european_ec2" {
    regions = [ "eu-west-1", "eu-central-1" ]
    services = [ "ec2" ]
}

resource "aws_security_group" "from_europe" {
    name = "from_europe"

    ingress {
        from port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = [ "${data.aws_ip_ranges.european_ec2.cidr_blocks}" ]
    }
    tags {
        CreateDate = "${data.aws_ip_ranges.european_ec2.create_date}"
        SyncToken = "${data.aws_ip_ranges.european_ec2.sync_token}"
    }
}
-----------

