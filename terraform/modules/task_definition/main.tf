resource "aws_ecs_task_definition" "task-definition" {
  family                   = var.family
  network_mode              = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  cpu                       = var.cpu
  memory                    = var.memory
  execution_role_arn        = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name  = var.container_name
      image = var.image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
        }
      ]
    }
  ])
}
