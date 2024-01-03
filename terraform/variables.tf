variable "resource_group" {
  type        = map(string)
  description = "Name and location of the resource group."
}

variable "vnet" {
  type = map(object({
    enabled                   = bool
    resource_group_name       = string
    resource_group_location   = string
    address_space             = list(string)
    service_delegation        = string
    service_delegated_actions = list(string)
    subnet_names              = list(string)
    subnet_prefixes           = list(string)
    subnet_service_endpoints  = map(list(string))
  }))
  description = "Networks to deploy."
}

variable "transit_vnet_peering" {
  type        = map(string)
  description = "Peering map {vnet_name:resource_group_name} to the transit virtual network."
}

variable "storage" {
  type = map(object({
    enabled                  = bool
    resource_group_name      = string
    resource_group_location  = string
    account_tier             = string
    account_replication_type = string
  }))
  description = "Storage to deploy."
}

variable "databricks_workspace" {
  type = map(object({
    enabled                     = bool
    resource_group_name         = string
    resource_group_location     = string
    sku                         = string
    public_subnet_name          = string
    private_subnet_name         = string
    storage_account_sku_name    = string
    vnet_name                   = string
    udr_extended_infrastructure = string
    udr_control_plane_nat       = string
    udr_webapp                  = string
  }))
  description = "Databricks workspace to deploy."
}

variable "ipsec_preshared_key" {
  type        = string
  description = "IPsec preshared key."
  sensitive   = true
}
