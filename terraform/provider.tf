provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket         = "strapi-terraform-state-jeevan"
    key            = "task-8/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

