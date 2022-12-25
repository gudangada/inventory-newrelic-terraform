variable "slack_webhook" {
  type = object({
    url             = string
    channel_name    = string
    webhook_payload = optional(string, null)
    notified        = string
  })
  description = "Slack webhook config."
}
