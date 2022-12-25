locals {
  enabled                 = module.this.enabled
  api_key                 = module.this.api_key
  account_id              = module.this.account_id
  product_domain          = module.this.product_domain
  environment             = module.this.environment
  environment_aliases     = module.this.environment_aliases
  name                    = module.this.normalized_name
  normalized_service_name = module.this.normalized_service_name
  service_tags            = module.this.service_tags
  service_name            = module.this.service_name
  auto_discover_entities  = var.auto_discover_entities
  local                   = var.entity_guids
  entity_search_queries   = var.entity_search_queries
  count                   = local.enabled ? 1 : 0

  concatenated_env_aliases    = [for s in local.environment_aliases : "'${s}'"]
  concatenated_service_tags   = [for s in local.service_tags : "'${s}'"]
  default_entity_search_query = <<-EOT
    tags.label.ProductDomain = '${local.product_domain}' 
    AND tags.label.Environment IN (${join(",", local.concatenated_env_aliases)})
    AND tags.label.Service IN (${join(",", local.concatenated_service_tags)})
  EOT
}
