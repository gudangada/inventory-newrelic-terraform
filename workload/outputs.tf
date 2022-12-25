output "newrelic_workload_guid" {
  value       = join("", newrelic_workload.this.*.guid)
  description = "The unique entity identifier of the workload in New Relic."
}

output "newrelic_workload_id" {
  value       = join("", newrelic_workload.this.*.workload_id)
  description = "The unique entity identifier of the workload."
}

output "newrelic_workload_permalink" {
  value       = join("", newrelic_workload.this.*.permalink)
  description = "The URL of the workload."
}

output "newrelic_workload_composite_entity_search_query" {
  value       = join("", newrelic_workload.this.*.composite_entity_search_query)
  description = "The composite query used to compose a dynamic workload."
}
