#output "ecs_sg_id" {
#  description = "Map of Security Group names to IDs"
#  value       = { for k, v in aws_security_group.sg : k => v.id }
#}


output "ecs_sg_ids" {
  description = "Map of ECS security group names to IDs"
  value       = {
    for name, sg in aws_security_group.sg :
    name => sg.id
  }
}
