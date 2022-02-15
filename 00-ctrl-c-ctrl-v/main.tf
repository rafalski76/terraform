provider "aws" {
  region = "eu-central-1"
}



resource "aws_instance" "test" {
  ami           = "ami-0d527b8c289b4af7f"
  instance_type = "t2.micro"

  key_name = aws_key_pair.this.key_name

  vpc_security_group_ids = [
    aws_security_group.test.id
  ]

  tags = {
    Name   = "Test"
    Client = "aaa"
  }
}
