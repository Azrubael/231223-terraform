terraform {
  backend "s3" {
    bucket = "tf49-remote-demo"
    key    = "terraform/backend_exercise6"
    region = "us-east-1"
  }
}
