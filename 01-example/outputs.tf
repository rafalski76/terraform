#output "instance_public_ip_address" {
#  value = aws_instance.test.public_ip
#}

output "ip_from_module" {
  value = module.instancja_z_modulu.public_ip_address
}