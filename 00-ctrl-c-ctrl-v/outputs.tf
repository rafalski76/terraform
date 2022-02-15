output "test_instance_public_ip" {
  value = aws_instance.test.public_ip
}

output "repository_arn" {
  value       = module.this.enabled ? aws_ecr_repository.name[local.image_names[0]].arn : ""
  description = "ARN of first repository created"
}

output "target_group_arn" {
  description = "ALB Target Group ARN"
  value       = join("", data.aws_lb_target_group.default.*.arn)
}
