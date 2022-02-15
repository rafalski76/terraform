provider "aws" {
	region = "eu-west-2"
}

resource "aws_instance" "test" {
	ami = "ami-0015a39e4b7c0966f"
	instance_type = "t2.micro"
 
 	tags = {
		Name = "RF-vm"
	}
	
	key_name = aws_key_pair.rf_key_pair.key_name
 
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