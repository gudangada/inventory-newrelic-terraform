variable "workload_config" {
  type = object({
    auto_discover_entities = bool,
    entity_guids           = list(string),
    entity_search_queries  = list(string)
  })
  default = {
    auto_discover_entities = true
    entity_guids           = []
    entity_search_queries  = []
  }
}
