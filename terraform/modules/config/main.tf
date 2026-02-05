# Config module (no SOPS, single YAML)
locals {
  # Path to config folder
#  config_path = var.config_path != "" ? var.config_path : "${path.root}/config_env"
  config_path = var.config_path != "" ? var.config_path : "${path.root}/../config_env"
  environment = var.environment != "" ? var.environment : terraform.workspace

  # Load all YAML files (skip .enc.yaml)
  files_env = toset([
    for f in fileset("${local.config_path}/${local.environment}", "*.yaml") :
    f if substr(f, -9, -1) != ".enc.yaml"
  ])

  # Decode YAML files
 # configs_env = toset([
 #   for f in local.files_env :
 #   try(yamldecode(file("${local.config_path}/${local.environment}/${f}")))
 # ])

  # Merge all configs into one map
 # configs = merge(local.configs_env...)


#Decode YAML files
  configs_env = [
    for f in local.files_env :
    yamldecode(file("${local.config_path}/${local.environment}/${f}"))
  ]

  configs = merge(local.configs_env...)
  
  # Default tags (ACS-style)
  default_tags = merge(var.default_tags, {
    environment      = local.environment
    org              = lookup(local.configs, "org_name", "")
    application      = lookup(local.configs, "app_name", "")
    division         = lookup(local.configs, "division", "")
    technicalContact = lookup(local.configs, "technicalContact", "")
    tier             = local.environment
    department       = lookup(local.configs, "department", "")
  })
}
