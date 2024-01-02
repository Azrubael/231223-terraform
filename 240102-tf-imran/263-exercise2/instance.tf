resource "aws_instance" "uh-inst" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = "230724-ec2-t2micro"
  vpc_security_group_ids = ["sg-07c14eb3a2b23ac8d"]
  tags = {
    Name    = "uh-Instance"
    Project = "uh"
  }
}
