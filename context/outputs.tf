output "api_key" {
  value       = local.api_key
  description = "New relic API key."
}

output "account_id" {
  value       = local.account_id
  description = "New relic account ID."
}

output "enabled" {
  value       = local.enabled
  description = "Boolean flag to enable or disable module."
}

output "product_domain" {
  value       = local.product_domain
  description = "ProductDomain on AWS."
}

output "environment" {
  value       = local.environment
  description = "Environment on AWS."
}

output "environment_aliases" {
  value       = local.environment_aliases
  description = "Aliases for enviroment variable."
}

output "service_name" {
  value       = local.service_name
  description = "Name of the service."
}

output "service_tags" {
  value       = local.service_tags
  description = "The service tag in New Relic. Usually marked as `Label.Service`."
}

output "normalized_name" {
  value       = local.name
  description = "Generated name for new relic resource."
}

output "normalized_service_name" {
  value       = local.service_name
  description = "Generated service_name for new relic resource."
}

output "context" {
  value       = local.input
  description = <<-EOT
  Merged but otherwise unmodified input to this module, to be used as context input to other modules.
  Note: this version will have null values as defaults, not the values actually used as defaults.
EOT
}
