resource "azurerm_resource_group" "demo" {
  name     = "demo"
  location = "West Europe"
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
  resource_group_name       = azurerm_resource_group.demo.name
  resource_group_location   = azurerm_resource_group.demo.location
  address_space             = each.value.address_space
  service_delegation        = each.value.service_delegation
  service_delegated_actions = each.value.service_delegated_actions
  subnet_names              = each.value.subnet_names
  subnet_prefixes           = each.value.subnet_prefixes
  subnet_service_endpoints  = each.value.subnet_service_endpoints
}

module "vnet_peering" {
  for_each = var.vnet_peering

  source                  = "./modules/vnet_peering/"
  resource_group_name     = azurerm_resource_group.demo.name
  resource_group_location = azurerm_resource_group.demo.location
  vnet_src_name           = each.key
  vnet_dst_name           = each.value

  depends_on = [
    module.networks
  ]
}

module "transit_connectivity" {
  source                  = "./modules/transit_connectivity/"
  resource_group_name     = azurerm_resource_group.demo.name
  resource_group_location = azurerm_resource_group.demo.location
  vnet_name               = "transit"
  subnet_name             = "GatewaySubnet"
  ipsec_preshared_key     = var.ipsec_preshared_key

  depends_on = [
    module.networks
  ]
}

module "storage" {
  for_each = {
    for storage_name, storage in var.storage : storage_name => storage
    if storage.enabled
  }

  source                           = "./modules/storage"
  resource_group_name              = azurerm_resource_group.demo.name
  resource_group_location          = azurerm_resource_group.demo.location
  storage_account_name             = "${each.key}${random_string.this.result}"
  storage_account_tier             = each.value.account_tier
  storage_account_replication_type = each.value.account_replication_type
  storage_container_name           = each.key
  enable_private_endpoint          = each.value.enable_private_endpoint
  vnet_name                        = each.value.vnet_name
  subnet_name                      = each.value.subnet_name

  depends_on = [
    module.networks
  ]
}

module "databricks" {
  for_each = {
    for workspace_name, workspace in var.databricks_workspace : workspace_name => workspace
    if workspace.enabled
  }

  source                    = "./modules/databricks/"
  resource_group_name       = azurerm_resource_group.demo.name
  resource_group_location   = azurerm_resource_group.demo.location
  databricks_workspace_name = "${each.key}_${random_string.this.result}"
  sku                       = each.value.sku
  vnet_name                 = each.value.vnet_name
  subnet_private_name       = each.value.private_subnet_name
  subnet_public_name        = each.value.public_subnet_name
  storage_account_sku_name  = each.value.storage_account_sku_name

  depends_on = [
    module.networks
  ]
}
