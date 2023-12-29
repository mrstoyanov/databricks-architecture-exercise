variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "resource_group_location" {
  type        = string
  description = "The region of the resource group."
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account."
}

variable "storage_account_tier" {
  type        = string
  description = "The tier type of the storage account."
}

variable "storage_account_replication_type" {
  type        = string
  description = "The replication type of the storage account."
}

variable "storage_container_name" {
  type        = string
  description = "The name of the storage container."
}

variable "enable_private_endpoint" {
  type        = bool
  description = "Whether to enable Private Endpoint on a subnet."
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network for the Private Endpoint."
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet for the Private Endpoint."
}
