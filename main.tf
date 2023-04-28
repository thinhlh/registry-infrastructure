terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
  # profile = "mck-sandbox"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
}

module "instance_key_pair" {
  source = "github.com/TH-Logistic/key_pair"

  key_pair_name = var.key_pair_name
}

module "vpc" {
  source = "github.com/TH-Logistic/vpc"
}

module "internet_gateway" {
  source = "github.com/TH-Logistic/gateway"

  vpc_id = module.vpc.vpc_id
}

module "instance" {
  source = "github.com/TH-Logistic/ec2"

  key_pair_name       = module.instance_key_pair.key_pair_name
  instance_name       = "th-registry"
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  vpc_id              = module.vpc.vpc_id
  subnet_cidr         = "10.0.70.0/24"
  instance_size       = 40
  instance_ami        = var.instance_ami
}