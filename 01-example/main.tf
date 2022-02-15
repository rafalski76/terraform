data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "test" {
  count = 3

  #  ami = "ami-0d527b8c289b4af7f" # obraz Ubuntu 20.04
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name = aws_key_pair.this.key_name

  vpc_security_group_ids = [aws_security_group.test.id]

  tags = {
    #    Name = var.instance_name
    Name = "${var.instance_name}-${count.index}"
    #    Name = format("%s-%s", var.instance_name, count.index)
    Client = "ACME S.A."
  }

  lifecycle {
    ignore_changes = [ami]
  }
}

module "instancja_z_modulu" {
  source = "../modules/instance_example"

  ami           = data.aws_ami.ubuntu.id
  key_pair_name = aws_key_pair.this.key_name
  name          = "from-module"
}