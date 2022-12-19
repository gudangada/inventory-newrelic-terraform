terraform {
  required_version = ">= 1.3"

  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 2.37.0"
    }
  }
}
