variable "key_name" {
  type    = string
  default = "infoshare-devops"
}

data "local_file" "ssh_key" {
  filename = "/home/vagrant/.ssh/id_ed25519.pub"
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = data.local_file.ssh_key.content
}
