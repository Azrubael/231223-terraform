terraform {
    backend "s3" {
        bucket = "tf49-remote-demo"
        key = "terraform/demo4"
        region = "us-east-1"
    }
}