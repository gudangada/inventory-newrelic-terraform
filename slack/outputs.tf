output "newrelic_notification_destination_id" {
  value       = join("", newrelic_notification_destination.this.*.id)
  description = "Newrelic notification destination id."
}

output "newrelic_notification_channel_id" {
  value       = join("", newrelic_notification_channel.this.*.id)
  description = "Newrelic notification channel id."
}
