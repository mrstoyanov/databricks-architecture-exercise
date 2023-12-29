variable "vnet" {
  type = map(object({
    enabled                   = bool
    address_space             = list(string)
    service_delegation        = string
    service_delegated_actions = list(string)
    subnet_names              = list(string)
    subnet_prefixes           = list(string)
    subnet_service_endpoints  = map(list(string))
  }))
  description = "Networks to deploy."
}

variable "vnet_peering" {
  type        = map(string)
  description = "Virtual network peering map."
}

variable "storage" {
  type = map(object({
    enabled                  = bool
    account_tier             = string
    account_replication_type = string
    enable_private_endpoint  = bool
    vnet_name                = string
    subnet_name              = string
  }))
  description = "Storage to deploy."
}

variable "databricks_workspace" {
  type = map(object({
    enabled                     = bool
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
