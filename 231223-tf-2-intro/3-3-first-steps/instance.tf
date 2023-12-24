provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_KEY_HERE"
  region     = "us-east-1"
}

resource "aws_instance" "tf-33-example" {
  ami           = "ami-010b814555e3268fa"
  instance_type = "t2.micro"
}

