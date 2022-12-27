resource "newrelic_notification_destination" "this" {
  count = local.count

  account_id = local.account_id
  name       = local.notification_name
  type       = "WEBHOOK"

  property {
    key   = "url"
    value = local.webhook_url
  }
}

resource "newrelic_notification_channel" "this" {
  count = local.count

  account_id     = local.account_id
  name           = local.notification_name
  type           = "WEBHOOK"
  destination_id = join("", newrelic_notification_destination.this.*.id)
  product        = "IINT" // (Workflows)

  property {
    key   = "payload"
    label = "Payload Template"
    value = local.webhook_payload
  }
}
