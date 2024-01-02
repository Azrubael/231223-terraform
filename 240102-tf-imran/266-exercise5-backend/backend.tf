terraform {
  backend "s3" {
    bucket = "tf49-remote-demo"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}
