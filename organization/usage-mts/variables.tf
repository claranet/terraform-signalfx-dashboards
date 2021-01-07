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

