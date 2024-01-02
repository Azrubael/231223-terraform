provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "intro" {
  ami                    = "ami-010b814555e3268fa"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  key_name               = "230724-ec2-t2micro"
  vpc_security_group_ids = ["sg-07c14eb3a2b23ac8d"]
  tags = {
    Name    = "Intro-Instance"
    Project = "Dove"
  }
}
