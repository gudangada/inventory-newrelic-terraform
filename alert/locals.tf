locals {
  name                             = module.this.normalized_name
  service_name                     = module.this.normalized_service_name
  service_tags                     = module.this.service_tags
  api_key                          = module.this.api_key
  account_id                       = module.this.account_id
  product_domain                   = module.this.product_domain
  environment                      = module.this.environment
  incident_preference              = var.incident_preference
  newrelic_notification_channel_id = var.newrelic_notification_channel_id
  query_service_tags               = "(${join(",", [for s in local.service_tags : "'${s}'"])})"
  newrelic_alert_policy_id         = var.newrelic_alert_policy_id == null ? join("", newrelic_alert_policy.this.*.id) : var.newrelic_alert_policy_id

  template_file_vars = {
    environment    = local.environment
    product_domain = local.product_domain
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
      templatefile(local.alert_config_map[key], merge(local.template_file_vars, { service = local.query_service_tags }))
    )
    if value.enabled
  }
  alert_config_input = {
    for key, value in var.config :
    key => value.custom_config == null ? {} : yamldecode(value.custom_config)
    if value.enabled
  }
  alert_config_final = {
    for key, value in var.config :
    key => merge(
      local.alert_config_default[key],
      local.alert_config_input[key]
    )
    if value.enabled
  }
  alert_config_list = flatten([
    for group_name, groups in local.alert_config_final : [
      for k, configs in groups : [
        for config in configs :
        merge(merge(yamldecode(templatefile("${path.module}/configs/global.yml", {})), config), { group = group_name })
      ]
    ]
  ])
}
