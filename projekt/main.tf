provider "aws" {
	region = "eu-west-3"
}

resource "aws_instance" "test" {
#	ami = "ami-0015a39e4b7c0966f"
	ami = data.aws_ami.ubuntu.id
	instance_type = "t2.micro"
 
 	tags = {
		Name = "RF-vm"
	}
	
	key_name = aws_key_pair.rf_key_pair.key_name
 
	subnet_id = module.vpc.public_subnets[0]
	
	vpc_security_group_ids = [aws_security_group.all_access.id]
}

#variable "key" {
#	type = string
#	default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOpS2EOuMMOoQZsouT7X7BMXNMA2ecD42Y4aRTDc6HeX runner"
#}

locals {
	ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOpS2EOuMMOoQZsouT7X7BMXNMA2ecD42Y4aRTDc6HeX runner"
}

resource "aws_key_pair" "rf_key_pair" {
	public_key = local.ssh_public_key
	key_name = "RF-key"
}

resource "aws_security_group" "all_access" {
	name = "RF-sg"
	vpc_id = module.vpc.vpc_id
	
	ingress {
		from_port = 0
		protocol = "ALL"
		to_port = 0
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port = 0
		protocol = "ALL"
		to_port = 0	
		cidr_blocks = ["0.0.0.0/0"]		
	}
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"
  
  name = "rf-vpc"
  cidr = "10.11.0.0/16"

  azs             = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  private_subnets = ["10.11.1.0/24", "10.11.2.0/24", "10.11.3.0/24"]
  public_subnets  = ["10.11.101.0/24", "10.11.102.0/24", "10.11.103.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
  }
}