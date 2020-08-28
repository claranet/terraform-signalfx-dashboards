variable "multiplier" {
  description = "Multiplier should be 2 for \"enterprise\" or 1 for \"pro\" plan (i.e. 2 = 200 custom metrics and 20 containers per host)."
  type        = number
  default     = 2
}

variable "default_org_name" {
  description = "The default org name to use as filter"
  type        = string
  default     = "MyOrgNameToChange"
}

variable "hosts_limit_detector" {
  description = "Map containing name and id of hosts_limit detector"
  type        = map(string)
  default     = null
}

variable "containers_limit_detector" {
  description = "Map containing name and id of containers_limit detector"
  type        = map(string)
  default     = null
}

variable "custom_metrics_limit_detector" {
  description = "Map containing name and id of custom_metrics_limit detector"
  type        = map(string)
  default     = null
}

variable "containers_ratio_detector" {
  description = "Map containing name and id of containers_ratio detector"
  type        = map(string)
  default     = null
}

variable "custom_metrics_ratio_detector" {
  description = "Map containing name and id of custom_metrics_ratio detector"
  type        = map(string)
  default     = null
}

