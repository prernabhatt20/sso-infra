variable "config_path" {
  type    = string
  default = ""
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "default_tags" {
  type    = map(string)
  default = {}
}
