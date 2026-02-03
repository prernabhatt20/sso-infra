# ECS Service – Rolling Deployment
resource "aws_ecs_service" "ecs_service" {
  name            = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-ecs-service"
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  # Rolling deployment settings
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  force_new_deployment               = true

  enable_execute_command = var.enable_execute_command

  # Network configuration
  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }

  # Tags
  tags = merge(var.default_tags, {
    Name = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-ecs-service"
  })
}
