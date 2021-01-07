variable "multiplier" {
  description = "Multiplier should be 2 for \"enterprise\" or 1 for \"pro\" plan (i.e. 2 = 200 custom metrics and 20 containers per host)."
  type        = number
  default     = 2
}

variable "default_org_name" {
  description = "The default org name to use as filter for child org. Do nothing if is_parent is false."
  type        = string
  default     = "MyFavoriteOrg"
}

variable "is_parent" {
  description = "Use \"child version\" of org metrics if true. Disable for child org."
  type        = bool
  default     = true
}

variable "detectors" {
  description = "Each element represents a detector as a map with its id and name."
  type        = map(any)
  #  type = map(object({
  #      containers_limit_detector = map(string)
  #      containers_ratio_detector = map(string)
  #      custom_metrics_limit_detector = map(string)
  #      custom_metrics_ratio_detector = map(string)
  #      hosts_limit_detector = map(string)
  #    }))
  default = {}
}

