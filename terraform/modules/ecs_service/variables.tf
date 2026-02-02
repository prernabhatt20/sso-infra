variable "service_name" {}
variable "cluster_id" {}
variable "task_definition_arn" {}

variable "vpc_id" {
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for ECS service"
}

variable "container_port" {}
