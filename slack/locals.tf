locals {
  enabled           = module.this.enabled
  count             = local.enabled ? 1 : 0
  name              = module.this.normalized_name
  account_id        = module.this.account_id
  api_key           = module.this.api_key
  channel_name      = var.slack_webhook.channel_name
  webhook_url       = var.slack_webhook.url
  notified          = var.slack_webhook.notified
  notification_name = "${local.name} - ${local.channel_name}"

  default_webhook_payload = templatefile("${path.module}/webhook-payload.config", { notified = local.notified })
  webhook_payload         = var.slack_webhook.webhook_payload == null ? local.default_webhook_payload : var.slack_webhook.webhook_payload
}
