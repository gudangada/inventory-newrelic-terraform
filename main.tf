
module "workload" {
  source = "./workload"

  context                = module.this.context
  auto_discover_entities = var.workload_config.auto_discover_entities
  entity_guids           = var.workload_config.entity_guids
  entity_search_queries  = var.workload_config.entity_search_queries
}
