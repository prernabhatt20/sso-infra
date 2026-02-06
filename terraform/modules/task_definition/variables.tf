variable "family" {}
variable "cpu" {}
variable "memory" {}
variable "execution_role_arn" {}
variable "container_name" {}
variable "container_port" {}
variable "image" {}
variable "task_role_arn" {
  description = "IAM role used by the running container"
  type        = string
}