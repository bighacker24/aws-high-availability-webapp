output "alb_dns_name" {
  description = "Public address of the load balancer (null when enable_alb is false)."
  value       = one(aws_lb.app[*].dns_name)
}
