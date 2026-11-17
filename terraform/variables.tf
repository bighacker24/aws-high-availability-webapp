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

variable "instance_type" {
  description = "EC2 instance type for the app servers."
  type        = string
  default     = "t3.micro"
}

variable "app_desired_capacity" {
  description = "Number of app servers. 0 = off (no compute cost). Use 2 during work sessions."
  type        = number
  default     = 0

  validation {
    condition     = var.app_desired_capacity >= 0 && var.app_desired_capacity <= 4
    error_message = "app_desired_capacity must be between 0 and 4."
  }
}
