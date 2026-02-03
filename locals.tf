locals {
  config = yamldecode(
    file("${path.module}/config_env/dev/config.yaml")
  )
}
