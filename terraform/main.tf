data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
  }
}

module "ecr" {
  source            = "./modules/ecr"
  repository_name   = "my-app"
}

module "ecs_cluster" {
  source        = "./modules/ecs_cluster"
  cluster_name  = "my-ecs-cluster"
}

module "task_definition" {
  source                = "./modules/task_definition"
  family                = "my-task"
  cpu                   = 256
  memory                = 512
  execution_role_arn  = aws_iam_role.ecs_task_execution_role.arn
  container_name        = "my-container"
  container_port        = 80
  image                 = module.ecr.repository_url
}

module "ecs_service" {
  source                = "./modules/ecs_service"
  service_name          = "my-ecs-service"
  cluster_id            = module.ecs_cluster.cluster_id
  task_definition_arn   = module.task_definition.task_definition_arn
  container_port        = 80
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
}
