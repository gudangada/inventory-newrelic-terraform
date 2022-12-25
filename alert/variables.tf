variable "newrelic_alert_policy_id" {
  type        = string
  default     = null
  description = "To use existing alert policy. If value isn't specified a new alert policy will be created."
}

variable "incident_preference" {
  type        = string
  default     = "PER_CONDITION"
  description = "The rollup strategy for the policy"

  validation {
    condition     = contains(["PER_POLICY", "PER_CONDITION", "PER_CONDITION_AND_TARGET"], var.incident_preference)
    error_message = "Allowed values: `PER_POLICY`, `PER_CONDITION`, `PER_CONDITION_AND_TARGET`."
  }
}

variable "newrelic_notification_channel_id" {
  type        = string
  description = "New relic notification channel id."
}

variable "config" {
  type = object({
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

  description = <<-EOT
    If you want to override the default config (e.g. nqrl query) you need to fill `custom_config`.
    For example: 
      lb = { 
        enabled = True
        custom_config = templatefile("path/to/config/, {}) 
      }
    You can get the yaml template from github.
  EOT
}
