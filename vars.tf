variable "app_version" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "bucket_name" {
  type = string
}


variable "lambda_name" {
  type    = string
  default = "example"
}

variable "stage" {
  type    = string
  default = "test"
}

variable "region" {
  type    = string
  default = "us-west-2"
}


