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
resource "aws_instance" "ec2_demo_instance" {
  tags = {
    Name        = "Ec2_demo_instance"
    Environment = "Dev"
  }
  ami               = "ami-0317b0f0a0144b137"
  instance_type     = "t3.micro"
  key_name          = "sample"
  availability_zone = "ap-south-1a"
  root_block_device {
    volume_size = 8
  }
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.sg_demo.id]
}

resource "aws_security_group" "sg_demo" {
  name        = "aws_sg_web"
  description = "aws_sg_description  / allow SSh and http"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.vpc_demo.id
}

resource "aws_vpc" "vpc_demo" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_main-demo"
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc_demo.id
  cidr_block        = "10.1.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "public_subnet_demo"

  }
  map_public_ip_on_launch = true
}


resource "aws_internet_gateway" "ig_demo" {
  vpc_id = aws_vpc.vpc_demo.id
  tags = {
    Name = "internet_gateway_1"
  }
}

resource "aws_route_table" "rt_demo" {
  vpc_id = aws_vpc.vpc_demo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_demo.id
  }

  tags = {
    Name = "route_table_1"
  }
}
resource "aws_route_table_association" "rta-demo" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt_demo.id
}


