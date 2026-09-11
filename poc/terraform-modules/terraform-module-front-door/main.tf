variable "project" {
  description = "Service name used to name the Front Door profile and endpoint."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "frontends" {
  description = "Custom domains, origins and route configuration for the Front Door endpoint."
  type        = list(any)
  default     = []
}

output "endpoint_name" {
  value = "${var.project}-${var.environment}"
}
