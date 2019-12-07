provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

terraform {
  backend "s3" {
    bucket = "tfbe"
    key    = "terraform-lambda-apigw"
    region = "us-west-2"
  }
}