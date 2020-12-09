variable "eventtype" {
  type        = string
  default     = "nagios.state"
  description = "EventFeed to filter on"
}

variable "timerange" {
  type        = string
  default     = "-1d"
  description = "Dashboard default timerange"
}
