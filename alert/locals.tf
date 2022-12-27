locals {
  name                = module.this.normalized_name
  service_name        = module.this.normalized_service_name
  service_tags        = module.this.service_tags
  enabled             = module.this.enabled
  api_key             = module.this.api_key
  account_id          = module.this.account_id
  product_domain      = module.this.product_domain
  environment         = module.this.environment
  incident_preference = var.incident_preference
  query_service_tags  = "(${join(",", [for s in local.service_tags : "'${s}'"])})"
  count               = local.enabled ? 1 : 0

  # Slack Notif
  channel_name            = var.slack_webhook.channel_name
  webhook_url             = var.slack_webhook.url
  notified                = var.slack_webhook.notified
  notification_name       = "${local.name} - ${local.channel_name}"
  default_webhook_payload = templatefile("${path.module}/configs/webhook-payload.config", { notified = local.notified })
  webhook_payload         = var.slack_webhook.webhook_payload == null ? local.default_webhook_payload : var.slack_webhook.webhook_payload

  template_file_vars = {
    environment    = local.environment
    product_domain = local.product_domain
    service        = local.query_service_tags
  }

  occurrences_map = {
    all           = "for"
    at_least_once = "at least once in"
  }
  connector_map = {
    static   = "{{operator}} {{threshold}}"
    baseline = "deviated from the baseline"
  }

  alert_config_map = {
    apm    = "${path.module}/configs/apm.yml"
    ecs    = "${path.module}/configs/ecs.yml"
    ec2    = "${path.module}/configs/ec2.yml"
    rds    = "${path.module}/configs/rds.yml"
    lambda = "${path.module}/configs/lambda.yml"
    tg     = "${path.module}/configs/target-group.yml"
    lb     = "${path.module}/configs/load-balancer.yml"
  }

  alert_config_default = {
    for key, value in var.config :
    key => yamldecode(
      templatefile(local.alert_config_map[key], local.template_file_vars)
    )
    if value.enabled
  }

  alert_config_input = {
    for key, value in var.config :
    key => value.custom_config == null ? {} : yamldecode(value.custom_config)
    if value.enabled
  }

  alert_config_final = flatten([
    for name, config in local.alert_config_default : {
      for infra, alerts in config : infra => {
        for k, v in alerts : k =>
        (
          local.alert_config_input[name] == {} ? v :
          local.alert_config_input[name][infra] == {} ? v :
          merge(v, lookup(local.alert_config_input[name][infra], k, {}))
        )
      }
    }
  ])

  globals = yamldecode(templatefile("${path.module}/configs/global.yml", { runbook_url = var.runbook_url }))
  alert_config_list = flatten([
    for group_name, groups in local.alert_config_final : [
      for k, configs in groups : [
        for config in configs :
        merge(merge(local.globals, config), { group = k })
      ]
    ]
  ])
}
