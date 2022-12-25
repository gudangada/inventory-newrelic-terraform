resource "newrelic_workload" "this" {
  count = local.count

  name              = local.normalized_service_name
  account_id        = local.account_id
  scope_account_ids = [local.account_id]

  dynamic "entity_search_query" {
    for_each = local.auto_discover_entities ? [1] : [0]
    content {
      query = local.default_entity_search_query
    }
  }

  dynamic "entity_search_query" {
    for_each = local.entity_search_queries
    content {
      query = entity_search_query.value
    }
  }
}
