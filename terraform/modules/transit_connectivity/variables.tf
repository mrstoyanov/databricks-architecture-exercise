variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "resource_group_location" {
  type        = string
  description = "The region of the resource group."
}

variable "ipsec_preshared_key" {
  type        = string
  description = "IPsec authentication key."
}

variable "enable_private_endpoint" {
  type        = bool
  description = "Whether to enable Private Endpoint on a subnet."
}

variable "private_endpoint_subnet_name" {
  type = string
  description = "The name of the subnet hosting the private endpoint."
}

variable "private_connection_storage_name" {
  type = string
  description = "The name of the storage which the private endpoint should be connected to."
}

variable "vault_name" {
  type = string
  description = "The name of the vault."
  default = ""
}

variable "vault_sku" {
  type = string
  description = "The Name of the SKU used for the vault."
}
