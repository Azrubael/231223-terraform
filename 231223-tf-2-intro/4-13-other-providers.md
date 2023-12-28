# 2023-12-28    17:28
=====================


13. Other Providers
-------------------

So we already talked about the AWS provider, Datasources and a Template provider.
Let's make a quick overview of other providers that you can use with terraform.
Terraform is a tool to create and manage *infrastructure resources*.
And terraform has *many providers* to choose from.
AWS proviser is the most popular one, and will be the one of we'll discuss most later.
Potentially any company thet opens up an API can be used as a terraform provider, for example: GCP, Azure, Herokum DigitalOcean etc.
If you have on-premise (local) infrastructure, then you can also use VMware, vCloud, vSphere and OpenStack with Terraform.
It's not only limited to cloud providers:
- Datadog - for monitoring;
- GitHub - for version control;
- Mailgun - for emailing via SMTP;
- DNSSimple / DNSMadeEAsy / UltraDNS - for DNS hosting.
# https://www.terraform.io/docs/providers/index.html

# A DigitalOcean example:
--------------------
variable "do_token" {}

provider "digitalocean" {
    token = "${var.do_token}"
}

resource "digitalocean_droplet" "mydroplet" {
    image = "ubuntu-18-04-x64"
    name = "web-1"
    region = "nyc2"
    size = "1024mb"
}
