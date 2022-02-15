terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_security_group" "this" {
  name = var.name
  egress {
    from_port   = 0
    protocol    = "ALL"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    protocol    = "ALL"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = "t2.micro"

  key_name = var.key_pair_name

  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name = var.name
  }
}