variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}
