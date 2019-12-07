# Lambda with Terraform

## Introduction

[This guide](https://learn.hashicorp.com/terraform/aws/lambda-api-gateway) was used to build this accelerator.

## Getting Started

Many of the important commands are located in the `Makefile`. That is where you will change a few of the environment variables used to deploy. Make sure the bucket names are changed to something that is available.

To set up your terraform backend, change the `TF_BACKEND_BUCKET_NAME` value to somethng unique, then run 

```sh
make create-tf-backend-remote
```

Then, change the the `terraform` section in the `configuration.tf`. 

```HCL
terraform {
  backend "s3" {
    bucket = "tfbe" // <-- this needs to match your TF_BACKEND_BUCKET_NAME value
    key    = "terraform-lambda-apigw"
    region = "us-west-2" // <-- if you changed your region in the make file, change this to match
  }
}
```

Then you should just need to deploy the lamdba artifact.

```sh
make deploy
```

Then deploy the infrastructure for your lamdba.

```sh
make tf-apply
```