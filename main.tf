module "workload" {
  source = "./workload"

  context                = module.this.context
  enabled                = var.workload_config.enabled
  auto_discover_entities = var.workload_config.auto_discover_entities
  entity_guids           = var.workload_config.entity_guids
  entity_search_queries  = var.workload_config.entity_search_queries
}

module "slack" {
  source = "./slack"

  context = module.this.context
  enabled = var.slack_webhook.enabled
  slack_webhook = {
    channel_name    = var.slack_webhook.channel_name
    url             = var.slack_webhook.url
    webhook_payload = var.slack_webhook.webhook_payload
    notified        = var.slack_webhook.notified
  }
}

module "alert" {
  source = "./alert"

  context                          = module.this.context
  enabled                          = var.alert_config.enabled
  config                           = var.alert_config.config
  newrelic_notification_channel_id = var.alert_config.newrelic_notification_channel_id == null ? module.slack.newrelic_notification_channel_id : var.alert_config.newrelic_notification_channel_id
}
