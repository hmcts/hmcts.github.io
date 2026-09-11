variable "name" {
  description = "Name of the storage account."
  type        = string
}

output "name" {
  value = var.name
}
