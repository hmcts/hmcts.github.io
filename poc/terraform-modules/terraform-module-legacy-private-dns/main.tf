variable "zone_name" {
  description = "The private DNS zone name used by existing deployments."
  type        = string
}

output "zone_name" {
  value = var.zone_name
}
