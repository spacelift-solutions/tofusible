terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

variable "aws_private_key_name" {
  type        = string
  description = "The name of the private key in AWS to use for SSH"
}

variable "private_key_path" {
  type        = string
  description = "The path to the private key to use for SSH"
}

variable "subnet_id" {
  type        = string
  description = "The subnet to use for the instances"
}

variable "vpc_security_group_id" {
  type        = string
  description = "The security groups to use for the instances"
}

provider "aws" {}

data "aws_ami" "this" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

###############################
## Create AWS instances
###############################

resource "aws_instance" "tofu_production" {
  ami                    = data.aws_ami.this.id
  key_name               = var.aws_private_key_name
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.vpc_security_group_id]
  tags = {
    Name = "tofu production"
  }
}

resource "aws_instance" "tofu_qa" {
  ami                    = data.aws_ami.this.id
  key_name               = var.aws_private_key_name
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.vpc_security_group_id]
  tags = {
    Name = "tofu qa"
  }
}

resource "aws_instance" "tofu_dev" {
  ami                    = data.aws_ami.this.id
  key_name               = var.aws_private_key_name
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.vpc_security_group_id]
  tags = {
    Name = "tofu dev"
  }
}

##############################################################
## Add Tofu production To The Inventory !IMPORTANT
##############################################################
module "host_tofu_production" {
  source  = "spacelift.io/spacelift-solutions/tofusible-host/spacelift"
  version = "1.0.0"

  host                 = aws_instance.tofu_production.public_ip
  user                 = "ubuntu"
  ssh_private_key_file = var.private_key_path
  groups               = ["tofu", "production", "example.production"]
}

##############################################################
## Add Tofu qa To The Inventory !IMPORTANT
##############################################################
module "host_tofu_qa" {
  source  = "spacelift.io/spacelift-solutions/tofusible-host/spacelift"
  version = "1.0.0"

  host                 = aws_instance.tofu_qa.public_ip
  user                 = "ubuntu"
  ssh_private_key_file = var.private_key_path
  groups               = ["tofu", "qa", "example.qa"]
}

##############################################################
## Add Tofu dev To The Inventory !IMPORTANT
##############################################################
module "host_tofu_dev" {
  source  = "spacelift.io/spacelift-solutions/tofusible-host/spacelift"
  version = "1.0.0"

  host                 = aws_instance.tofu_dev.public_ip
  user                 = "ubuntu"
  ssh_private_key_file = var.private_key_path
  groups               = ["tofu", "dev", "example.dev"]

}

############################################################################################
## Output the full inventory so we can pass it to ansible !IMPORTANT
## Note: we just output the spec in a list, do NOT json encode this. Just raw output
############################################################################################
output "inventory_tofu" {
  value = [
    module.host_tofu_production.spec,
    module.host_tofu_qa.spec,
    module.host_tofu_dev.spec
  ]

  # It does have to be sensitive, as the module could take passwords as an input.
  # If you want to use this on a private worker you *MUST* enable sensitive output uploading.
  # This example utilizes a public worker to create the output
  # and public workers do not require that setting.
  # See more: https://docs.spacelift.io/concepts/stack/stack-dependencies#enabling-sensitive-outputs-for-references
  sensitive = true
}