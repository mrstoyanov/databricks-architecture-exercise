variable "resource_group_name" {
  type        = string
  description = "The name of the resource group for the storage account."
}

variable "resource_group_location" {
  type        = string
  description = "The region of the resource group for the storage account."
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
