variable "auto_discover_entities" {
  type        = bool
  default     = true
  description = "Whether discover entities by product domain and environment or not."
}

variable "entity_guids" {
  type        = list(string)
  default     = []
  description = "List guids to append to entities"
}

variable "entity_search_queries" {
  type        = list(string)
  default     = []
  description = "List of custom entity search query"
}
