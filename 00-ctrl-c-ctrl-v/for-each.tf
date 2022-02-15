resource "aws_instance" "for_each_example" {
  for_each = toset(var.instance_names)

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = each.value
  }
}