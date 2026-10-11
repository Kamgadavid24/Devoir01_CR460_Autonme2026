data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "lab" {
  name = "kv-cr460-${substr(
    replace(data.azurerm_client_config.current.subscription_id, "-", ""),
    0,
    8
  )}"

  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  rbac_authorization_enabled = false
  soft_delete_retention_days = 7
  purge_protection_enabled   = true

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = "099aa132-4fd2-49c4-a5c3-4a9f20492721"

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover"
    ]
  }

  tags = {
    projet = "CR460"
    auteur = "David-Kamga"
  }
}

resource "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-admin-password"
  value        = var.vm_admin_password
  key_vault_id = azurerm_key_vault.lab.id
  content_type = "Mot de passe administrateur Windows"
}

output "key_vault_name" {
  description = "Nom du coffre Azure Key Vault"
  value       = azurerm_key_vault.lab.name
}