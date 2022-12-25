output "newrelic_notification_destination_id" {
  value       = module.slack.newrelic_notification_destination_id
  description = "Newrelic notification destination id."
}

output "newrelic_notification_channel_id" {
  value       = module.slack.newrelic_notification_channel_id
  description = "Newrelic notification channel id."
}

output "newrelic_workload_guid" {
  value       = module.workload.newrelic_workload_guid
  description = "The unique entity identifier of the workload in New Relic."
}

output "newrelic_workload_id" {
  value       = module.workload.newrelic_workload_id
  description = "The unique entity identifier of the workload."
}

output "newrelic_workload_permalink" {
  value       = module.workload.newrelic_workload_permalink
  description = "The URL of the workload."
}

output "newrelic_workload_composite_entity_search_query" {
  value       = module.workload.newrelic_workload_composite_entity_search_query
  description = "The composite query used to compose a dynamic workload."
}
