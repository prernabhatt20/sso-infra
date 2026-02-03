output "ecs_sg_id" {
  description = "Map of Security Group names to IDs"
  value       = { for k, v in aws_security_group.sg : k => v.id }
}
