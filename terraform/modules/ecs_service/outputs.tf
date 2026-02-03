output "ecs_service_name" {
  value = aws_ecs_service.ecs_service.name
}

output "ecs_service_arn" {
  value = aws_ecs_service.ecs_service.arn
}
