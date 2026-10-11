resource "azurerm_container_registry" "lab" {
  name = "acrcr460${substr(
    replace(data.azurerm_client_config.current.subscription_id, "-", ""),
    0,
    8
  )}"

  resource_group_name = azurerm_resource_group.lab.name
  location            = "canadaeast"
  sku                 = "Basic"
  admin_enabled       = true

  tags = local.common_tags
}

output "acr_name" {
  description = "Nom du registre Azure Container Registry"
  value       = azurerm_container_registry.lab.name
}

output "acr_login_server" {
  description = "Adresse du registre Docker"
  value       = azurerm_container_registry.lab.login_server
}