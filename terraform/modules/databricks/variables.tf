variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "resource_group_location" {
  type        = string
  description = "The region of the resource group."
}

variable "databricks_workspace_name" {
  type        = string
  description = "The name of the Databricks workspace."
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "subnet_private_name" {
  type        = string
  description = "The name of the private subnet."
}

variable "subnet_public_name" {
  type        = string
  description = "The name of the public subnet."
}

variable "sku" {
  type        = string
  description = "The Databricks workspace tier."
}

variable "storage_account_sku_name" {
  type        = string
  description = "The name of the storage tier."
}

variable "udr_extended_infrastructure" {
  type        = string
  description = "IP addresses for standby Azure Databricks infrastructure."
}

variable "udr_control_plane_nat" {
  type        = string
  description = "IP addresses for the required outbound connections to the Databricks control plane."
}

variable "udr_webapp" {
  type        = string
  description = "IP addresses for the required outbound connections to the Databricks web app."
}
