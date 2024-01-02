variable REGION {
  default = "us-east-1"
}

variable ZONE1 {
  default = "us-east-1a"
}

variable AMIS {
  type = map(string)
  default = {
    us-east-1 = "ami-010b814555e3268fa"
    eu-central-1 = "ami-03cea216f9d507835"
  }
}