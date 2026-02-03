variable "org_name" {
  type        = string
  description = "Organization name for tagging"
}

variable "app_name" {
  type        = string
  description = "Application name for tagging"
}

variable "service_name" {
  type        = string
  description = "Service name for tagging"
}

variable "env" {
  type        = string
  description = "Environment (dev/prod/etc.)"
}

variable "aws_vpc_id" {
  type        = string
  description = "VPC ID where SGs will be created"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags to apply to all SGs"
  default     = {}
}

variable "aws_sg_configuration" {
  type = list(object({
    name                = string
    aws_sg_ingress_rules = list(object({
      aws_sg_ingress_cidr_ipv4 = list(string)
      aws_reference_sg         = list(string)
      aws_reference_sg_id      = list(string)
      aws_sg_inbound_port      = list(number)
      aws_sg_protocal          = list(string)
      aws_sg_enable_cidr_ipv4  = bool
    }))
    aws_sg_egress_rules = list(object({
      aws_sg_egress_cidr_ipv4 = list(string)
      aws_reference_sg         = list(string)
      aws_reference_sg_id      = list(string)
      aws_sg_inbound_port      = list(number)
      aws_sg_protocal          = list(string)
      aws_sg_enable_cidr_ipv4  = bool
    }))
  }))
  description = "Security Group configuration"
}
