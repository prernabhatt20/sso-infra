data "aws_vpc" "vpc" {
  default = true
}

data "aws_subnets" "subnet" {
  filter {
    name   = var.vpc_id
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "sg" {
  name   = var.service_name
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "ecs-service" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = [aws_security_group.this.id]
    assign_public_ip = true
  }
}
