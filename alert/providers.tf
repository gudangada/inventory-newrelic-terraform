provider "newrelic" {
  account_id = local.account_id
  api_key    = local.api_key
  region     = "US"
}
