variable "workload_config" {
  type = object({
    auto_discover_entities = optional(bool, true),
    entity_guids           = optional(list(string), []),
    entity_search_queries  = optional(list(string), [])
  })

  default = {
    entity_guids           = []
    entity_search_queries  = []
    auto_discover_entities = true
  }
}

variable "slack_webhook" {
  type = object({
    url             = string
    channel_name    = string
    webhook_payload = optional(string, null)
    notified        = string
  })
  description = "Slack webhook config."
}


variable "alert_config" {
  type = object({
    incident_preference      = optional(string, "PER_POLICY")
    newrelic_alert_policy_id = optional(string, null)
    configs = list(
      object({
        override_config = optional(object({
          lb     = string
          tg     = string
          ecs    = string
          ec2    = string
          rds    = string
          lambda = string
          }), {
          lb     = null
          tg     = null
          ecs    = null
          ec2    = null
          rds    = null
          lambda = null
        })
      })
    )
  })

  default = {
    configs                  = []
    incident_preference      = "PER_POLICY"
    newrelic_alert_policy_id = null
  }
}
