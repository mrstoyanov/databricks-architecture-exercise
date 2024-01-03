resource "azurerm_resource_group" "this" {
  for_each = var.resource_group

  name     = each.key
  location = each.value
}

resource "random_string" "this" {
  length  = 6
  special = false
  upper   = false
}

module "networks" {
  for_each = {
    for vnet_name, vnet in var.vnet : vnet_name => vnet
    if vnet.enabled
  }

  source                    = "./modules/networks/"
  vnet_name                 = each.key
  resource_group_name       = each.value.resource_group_name
  resource_group_location   = each.value.resource_group_location
  address_space             = each.value.address_space
  service_delegation        = each.value.service_delegation
  service_delegated_actions = each.value.service_delegated_actions
  subnet_names              = each.value.subnet_names
  subnet_prefixes           = each.value.subnet_prefixes
  subnet_service_endpoints  = each.value.subnet_service_endpoints

  depends_on = [
    azurerm_resource_group.this
  ]
}

module "storage" {
  for_each = {
    for storage_name, storage in var.storage : storage_name => storage
    if storage.enabled
  }

  source                           = "./modules/storage"
  resource_group_name              = each.value.resource_group_name
  resource_group_location          = each.value.resource_group_location
  storage_account_name             = "${each.key}${random_string.this.result}"
  storage_account_tier             = each.value.account_tier
  storage_account_replication_type = each.value.account_replication_type
  storage_container_name           = each.key

  depends_on = [
    azurerm_resource_group.this
  ]
}

module "transit_connectivity" {
  source                          = "./modules/transit_connectivity/"
  resource_group_name             = azurerm_resource_group.this["transit"].name
  resource_group_location         = azurerm_resource_group.this["transit"].location
  ipsec_preshared_key             = var.ipsec_preshared_key
  enable_private_endpoint         = true
  private_endpoint_subnet_name    = "private_endpoint"
  private_connection_storage_name = "databricks${random_string.this.result}"
  vault_sku                       = "standard"

  depends_on = [
    module.networks,
    module.storage
  ]
}

module "transit_vnet_peering" {
  for_each = var.transit_vnet_peering

  source                  = "./modules/transit_vnet_peering/"
  resource_group_dst_name = each.value
  vnet_dst_name           = each.key

  depends_on = [
    module.networks,
    module.transit_connectivity
  ]
}

module "databricks" {
  for_each = {
    for workspace_name, workspace in var.databricks_workspace : workspace_name => workspace
    if workspace.enabled
  }

  source                      = "./modules/databricks/"
  resource_group_name         = each.value.resource_group_name
  resource_group_location     = each.value.resource_group_location
  databricks_workspace_name   = "${each.key}_${random_string.this.result}"
  sku                         = each.value.sku
  vnet_name                   = each.value.vnet_name
  subnet_private_name         = each.value.private_subnet_name
  subnet_public_name          = each.value.public_subnet_name
  storage_account_sku_name    = each.value.storage_account_sku_name
  udr_extended_infrastructure = each.value.udr_extended_infrastructure
  udr_control_plane_nat       = each.value.udr_control_plane_nat
  udr_webapp                  = each.value.udr_webapp

  depends_on = [
    module.networks
  ]
}
