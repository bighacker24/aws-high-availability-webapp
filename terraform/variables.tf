variable "enable_nat" {
  description = "Create a NAT Gateway so the app tier can reach the internet. Bills hourly while it exists."
  type        = bool
  default     = false
}

variable "app_port" {
  description = "Port the app servers listen on behind the load balancer."
  type        = number
  default     = 80
}

variable "db_port" {
  description = "Database port. 5432 = PostgreSQL."
  type        = number
  default     = 5432
}
