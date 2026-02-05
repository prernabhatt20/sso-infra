module "ecr" {
  source            = "./modules/ecr"
#  repository_name   = "my-app"
  repository_name = module.config.configs.ecr.repository_name
}

module "ecs_cluster" {
  source        = "./modules/ecs_cluster"
#  cluster_name  = "my-ecs-cluster"
  cluster_name = "${module.config.configs.app_name}-${module.config.environment}"
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
  source = "./modules/ecs_service"

  org_name            = module.config.configs.org_name
  app_name            = module.config.configs.app_name
  service_name        = module.config.configs.service_name
  env = module.config.environment

  cluster_id = module.ecs_cluster.cluster_id
  task_definition_arn = module.task_definition.task_definition_arn

  subnet_ids          = module.config.configs.network.private_subnets
  security_group_ids = [
  module.sg.ecs_sg_ids["ecs-service"]
]

  desired_count       = module.config.configs.ecs.desired_count
  assign_public_ip    = false

  default_tags = {
    org = module.config.configs.org_name
    app = module.config.configs.app_name
    env = module.config.environment

  }
}

module "sg" {
  source = "./modules/security_group"

  org_name             = module.config.configs.org_name
  app_name             = module.config.configs.app_name
  service_name         = module.config.configs.service_name
  env = module.config.environment
  aws_vpc_id           = module.config.configs.vpc_id
  aws_sg_configuration = module.config.configs.aws_sg_configuration
}

module "config" {
  source      = "./modules/config"
  #environment = "dev"
}
