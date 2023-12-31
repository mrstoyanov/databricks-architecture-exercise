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

variable "private_endpoint_subnet_name" {
  type        = string
  description = "The name of the subnet hosting the private endpoint."
}

variable "private_connection_storage_account_id" {
  type        = list(string)
  description = "The ids of the storage accounts to which the private endpoint should connect to."
}

variable "vault_name" {
  type        = string
  description = "The name of the vault."
  default     = ""
}

variable "vault_sku" {
  type        = string
  description = "The Name of the SKU used for the vault."
}
