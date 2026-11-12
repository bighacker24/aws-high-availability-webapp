variable "enable_nat" {
  description = "Create a NAT Gateway so the app tier can reach the internet. Bills hourly while it exists."
  type        = bool
  default     = false
}
