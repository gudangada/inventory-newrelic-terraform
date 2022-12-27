module "workload" {
  source = "./workload"

  context                = module.this.context
  enabled                = var.workload_config.enabled
  auto_discover_entities = var.workload_config.auto_discover_entities
  entity_guids           = var.workload_config.entity_guids
  entity_search_queries  = var.workload_config.entity_search_queries
}

module "alert" {
  source = "./alert"

  context = module.this.context
  enabled = var.alert_config.enabled
  config  = var.alert_config.config
}
