variable "licence_pool" {
  description = "The number of MTS which represents a licence to calculate the price."
  type        = number
  default     = 84
}

variable "licence_price" {
  description = "The price of one licence unit."
  type        = number
  default     = 5
}

variable "is_parent" {
  description = "Use \"child version\" of org metrics if true. Disable for child org."
  type        = bool
  default     = true
}
