terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "aws_demo" {
  tags = {
    Name = local.instance_name_by_local_logic
  }
  ami               = "ami-051a31ab2f4d498f5"
  instance_type     = var.instance_type
  key_name          = "sample"
  availability_zone = var.availability_zone
  root_block_device {
    volume_size = var.volume_size
  }
}


