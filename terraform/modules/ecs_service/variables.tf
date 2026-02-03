variable "org_name" {
  type = string
}

variable "app_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "env" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "task_definition_arn" {
  type = string
}

variable "desired_count" {
  type    = number
  default = 1
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}

variable "assign_public_ip" {
  type    = bool
  default = false
}

variable "enable_execute_command" {
  type    = bool
  default = true
}

variable "default_tags" {
  type    = map(string)
  default = {}
}
