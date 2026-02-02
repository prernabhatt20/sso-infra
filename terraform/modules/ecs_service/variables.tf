variable "service_name" {}
variable "cluster_id" {}
variable "task_definition_arn" {}
variable "container_port" {}

variable "vpc_id" {
  description = "VPC ID for ECS service"
}

variable "subnet_ids" {
  description = "Subnets for ECS service"
  type        = list(string)
}
