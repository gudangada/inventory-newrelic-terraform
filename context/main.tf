
locals {
  default = {
    enabled       = true
    name_key_case = "title"
    environment   = "development"
  }

  input = {
    enabled        = var.enabled == null ? var.context.enabled : var.enabled
    api_key        = var.api_key == null ? var.context.api_key : var.api_key
    account_id     = var.account_id == null ? var.context.account_id : var.account_id
    product_domain = var.product_domain == null ? var.context.product_domain : var.product_domain
    environment    = var.environment == null ? var.context.environment : var.environment
    name_key_case  = var.name_key_case == null ? var.context.name_key_case : var.name_key_case
    service_name   = var.service_name == null ? var.context.service_name : var.service_name
    service_tags   = var.service_tags == null ? var.context.service_tags : var.service_tags
  }

  api_key        = local.input.api_key
  account_id     = local.input.account_id
  product_domain = local.input.product_domain
  service_tags   = local.input.service_tags
  enabled        = local.input.enabled == null ? local.default.enabled : local.input.enabled
  environment    = local.input.environment == null ? local.default.environment : local.input.environment
  name_key_case  = local.input.name_key_case == null ? local.default.name_key_case : local.input.name_key_case

  default_environment_alias = {
    "development" = ["development", "dev"]
    "staging"     = ["staging", "stg"]
    "production"  = ["production", "prd", "prod"]
  }
  environment_aliases = local.default_environment_alias[local.environment]

  name_map = {
    "title" = "${title(local.product_domain)} ${title(local.environment)}"
    "lower" = "${lower(local.product_domain)} ${lower(local.environment)}"
    "upper" = "${upper(local.product_domain)} ${upper(local.environment)}"
  }
  name = local.name_map[local.name_key_case]

  service_name_map = {
    "title" = "${title(local.input.service_name)} ${title(local.environment)}"
    "lower" = "${lower(local.input.service_name)} ${lower(local.environment)}"
    "upper" = "${upper(local.input.service_name)} ${upper(local.environment)}"
  }
  service_name = local.service_name_map[local.name_key_case]
}
