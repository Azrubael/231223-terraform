variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "AMIS" {
  type = map(string)
  default = {
    # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
    us-east-1 = "ami-00b8917ae86a424c9"
    # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
    eu-central-1 = "ami-02da8ff11275b7907"
  }
}

variable "USER" {
  default = "ec2-user"
}