variable "workload_config" {
  type = object({
    enabled                = optional(bool, false)
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
    enabled         = optional(bool, false)
    url             = string
    channel_name    = string
    webhook_payload = optional(string, null)
    notified        = string
  })
  description = "Slack webhook config."
}


variable "alert_config" {
  type = object({
    enabled                          = optional(bool, false)
    incident_preference              = optional(string, "PER_POLICY")
    newrelic_alert_policy_id         = optional(string, null)
    newrelic_notification_channel_id = string
    config = object({
      lb = optional(
        object({
          enabled       = bool
          custom_config = optional(string, null)
        }),
        {
          enabled       = false,
          custom_config = null
        }
      )
      tg = optional(
        object({
          enabled       = bool
          custom_config = optional(string, null)
        }),
        {
          enabled       = false,
          custom_config = null
        }
      )
      ecs = optional(
        object({
          enabled       = bool
          custom_config = optional(string, null)
        }),
        {
          enabled       = false,
          custom_config = null
        }
      )
      ec2 = optional(
        object({
          enabled       = bool
          custom_config = optional(string, null)
        }),
        {
          enabled       = false,
          custom_config = null
        }
      )
      rds = optional(
        object({
          enabled       = bool
          custom_config = optional(string, null)
        }),
        {
          enabled       = false,
          custom_config = null
        }
      )
      lambda = optional(
        object({
          enabled       = bool
          custom_config = optional(string, null)
        }),
        {
          enabled       = false,
          custom_config = null
        }
      )
    })
  })

  default = {
    config                           = {}
    incident_preference              = "PER_POLICY"
    newrelic_alert_policy_id         = null
    newrelic_notification_channel_id = null
  }

  description = <<-EOT
    If you want to override the default config (e.g. nqrl query) you need to fill `config`.
    For example: 
      lb = { 
        enabled = True
        custom_config = templatefile("path/to/config/, {}) 
      }
    You can get the yaml template from github.
  EOT
}
