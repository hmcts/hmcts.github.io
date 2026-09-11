variable "name" {
  description = "Name of the Application Insights instance."
  type        = string
}

output "name" {
  value = var.name
}
