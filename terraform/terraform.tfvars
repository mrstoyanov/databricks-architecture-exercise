vnet = {
  "databricks_demo" = {
    enabled            = true
    address_space      = ["10.0.0.0/20"]
    service_delegation = "Microsoft.Databricks/workspaces"
    service_delegated_actions = [
      "Microsoft.Network/virtualNetworks/subnets/join/action",
      "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
      "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
    ]
    subnet_names             = ["private", "public"]
    subnet_prefixes          = ["10.0.0.0/24", "10.0.1.0/24"]
    subnet_service_endpoints = { "private" = ["Microsoft.Storage"] }
  },
  "transit" = {
    enabled                   = true
    address_space             = ["10.0.252.0/22"]
    service_delegation        = ""
    service_delegated_actions = []
    subnet_names              = ["GatewaySubnet", "private_endpoint"]
    subnet_prefixes           = ["10.0.252.0/24", "10.0.253.0/24"]
    subnet_service_endpoints  = {}
  }
}

vnet_peering = {
  "transit" = "databricks_demo"
}

storage = {
  "databricks" = {
    enabled                  = true
    account_tier             = "Standard"
    account_replication_type = "LRS"
    enable_private_endpoint  = true
    vnet_name                = "transit"
    subnet_name              = "private_endpoint"
  }
}

databricks_workspace = {
  "demo" = {
    enabled                     = true
    sku                         = "trial"
    public_subnet_name          = "public"
    private_subnet_name         = "private"
    storage_account_sku_name    = "Standard_LRS"
    vnet_name                   = "databricks_demo"
    udr_extended_infrastructure = "20.73.215.48/28"  # West Europe
    udr_control_plane_nat       = "23.100.0.135/32"  # West Europe
    udr_webapp                  = "52.232.19.246/32" # West Europe
  }
}

# (!) The key is part of the code only for the purpose of this exercise.
# Sensitive values should be fetched from an external provider,
# e.g. from a password vault.
ipsec_preshared_key = "q*RSo-x-!c1IJ480_zw5ui2b"
