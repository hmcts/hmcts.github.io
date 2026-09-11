variable "name" {
  description = "Name of the Redis deployment."
  type        = string
}

output "name" {
  description = "The configured Redis deployment name."
  value       = var.name
}
