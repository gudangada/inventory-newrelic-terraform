resource "newrelic_alert_policy" "this" {
  count = local.count == 1 && var.newrelic_alert_policy_id == null ? 1 : 0

  name                = local.name
  incident_preference = local.incident_preference
}

resource "newrelic_nrql_alert_condition" "this" {
  for_each = { for config in local.alert_config_list : "${config.group} ${config.name}" => config }

  account_id = local.account_id
  policy_id  = local.newrelic_alert_policy_id
  type       = each.value.type
  name       = each.value.name
  # We are facing an issue when getting {{thresholdDuration}} data from newrelic since it always return 0.
  # For now the we will use static thresholdDuration from critical section.
  description = "${
    "${each.value.description} "}${
    "${local.connector_map[each.value.type]}"}${
    "${each.value.type == "static" ? each.value.unit : ""} "}${
    "${local.occurrences_map[each.value.critical.threshold_occurrences]} "}${
    "${each.value.critical.threshold_duration / 60} "}${
    "minute(s) on '{{targetName}}'"
  }"
  runbook_url                    = each.value.runbook_url
  enabled                        = each.value.enabled
  violation_time_limit_seconds   = each.value.violation_time_limit_seconds
  aggregation_window             = each.value.aggregation_window
  aggregation_method             = each.value.aggregation_method
  aggregation_delay              = each.value.aggregation_delay
  slide_by                       = each.value.slide_by
  fill_value                     = each.value.fill_value
  fill_option                    = each.value.fill_option
  aggregation_timer              = each.value.aggregation_timer
  baseline_direction             = each.value.baseline_direction
  expiration_duration            = each.value.expiration_duration
  open_violation_on_expiration   = each.value.open_violation_on_expiration
  close_violations_on_expiration = each.value.close_violations_on_expiration

  nrql {
    query = each.value.query
  }

  critical {
    operator              = each.value.critical.operator
    threshold             = each.value.critical.threshold
    threshold_duration    = each.value.critical.threshold_duration
    threshold_occurrences = each.value.critical.threshold_occurrences
  }

  dynamic "warning" {
    for_each = each.value.warning == null ? [] : [each.value.warning]

    content {
      operator              = warning.value.operator
      threshold             = warning.value.threshold
      threshold_duration    = warning.value.threshold_duration
      threshold_occurrences = warning.value.threshold_occurrences
    }
  }
}

resource "newrelic_workflow" "this" {
  count                 = local.count
  name                  = "Policy: ${local.newrelic_alert_policy_id} - ${local.service_name}"
  muting_rules_handling = "NOTIFY_ALL_ISSUES"

  issues_filter {
    name = "POLICY_IDS"
    type = "FILTER"

    predicate {
      attribute = "labels.policyIds"
      operator  = "EXACTLY_MATCHES"
      values    = [local.newrelic_alert_policy_id]
    }
  }

  destination {
    channel_id = local.newrelic_notification_channel_id
  }
}
