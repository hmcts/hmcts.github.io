variable "application" {
  type = string
}

variable "environment" {
  type = string
}

output "tags" {
  value = {
    application = var.application
    environment = var.environment
    managed-by  = "terraform"
  }
}
