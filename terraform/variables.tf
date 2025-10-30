variable "resource_group_location" {
  type        = string
  default     = "westus"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  default     = "westusrg"
}

variable "stack_name" {
  type        = string
  default     = "keycloak-podman"
}

variable "vm_admin_user" {
  type        = string
  default     = "adminuser"
}
