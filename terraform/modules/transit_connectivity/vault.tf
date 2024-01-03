resource "random_string" "azurerm_key_vault_name" {
  length  = 10
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_key_vault" "this" {
  name                       = coalesce(var.vault_name, "Vault-${random_string.azurerm_key_vault_name.result}")
  location                   = var.resource_group_location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.vault_sku
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Set",
      "Get",
      "List",
      "Delete",
      "Purge",
      "Recover"
    ]
  }
}

resource "random_string" "secret" {
  length  = 24
  lower   = true
  numeric = true
  special = true
  upper   = true
}

resource "azurerm_key_vault_secret" "ipsec" {
  name         = "IPsec-preshared-key"
  value        = coalesce(var.ipsec_preshared_key, random_string.secret.result)
  key_vault_id = azurerm_key_vault.this.id
}
