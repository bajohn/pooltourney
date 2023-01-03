terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "pooltourney-tf-backend"
    key    = "root"
    region = "us-east-1"
}
}
# TODO create AWS profile
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  profile="tennismatcher"
}

# Create a Dynamo table
# resource "aws_vpc" "example" {
#   cidr_block = "10.0.0.0/16"
# }

resource "aws_dynamodb_table" "profile-table" {
  name           = "pooltourney-user-profile"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "userName"

  attribute {
    name = "userName"
    type = "S"
  }

} 


