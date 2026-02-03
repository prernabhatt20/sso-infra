module "ecr" {
  source            = "./modules/ecr"
#  repository_name   = "my-app"
  repository_name = local.config.ecr.repository_name
}

module "ecs_cluster" {
  source        = "./modules/ecs_cluster"
#  cluster_name  = "my-ecs-cluster"
  cluster_name = "${local.config.app_name}-${local.config.env}"
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
  source = "../../modules/ecs-service"

  org_name            = local.config.org_name
  app_name            = local.config.app_name
  service_name        = local.config.service_name
  env                 = local.env

  cluster_id          = module.ecs_cluster.id
  task_definition_arn = module.ecs_task.task_definition_arn

  subnet_ids          = local.config.network.private_subnets
  security_group_ids = [
    module.sg.ecs_sg_ids["ecs-service"]
  ]

  desired_count       = local.config.ecs.desired_count
  assign_public_ip    = false

  default_tags        = local.default_tags
}

module "sg" {
  source = "./modules/sg"

  org_name             = local.config.org_name
  app_name             = local.config.app_name
  service_name         = local.config.service_name
  env                  = local.config.env
  aws_vpc_id           = local.config.vpc_id
  aws_sg_configuration = local.config.aws_sg_configuration
}

module "config" {
  source      = "./modules/config"
  #environment = "dev"
}
