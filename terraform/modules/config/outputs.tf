output "configs" {
  description = "Merged configuration from YAML files"
  value       = local.configs
}

output "environment" {
  description = "Resolved environment (workspace or override)"
  value       = local.environment
}

output "default_tags" {
  description = "Default tags generated from config"
  value       = local.default_tags
}
