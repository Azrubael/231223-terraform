resource "aws_instance" "example" {
  ami = lookup(var.AMIS, var.AWS_REGION, "") # last parameter is the default
  instance_type = "t2.micro"
}

