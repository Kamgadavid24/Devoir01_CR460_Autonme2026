resource "azurerm_container_group" "docker" {
  name                = "aci-cr460-david"
  location            = "canadaeast"
  resource_group_name = azurerm_resource_group.lab.name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = "Always"

  image_registry_credential {
    server   = azurerm_container_registry.lab.login_server
    username = azurerm_container_registry.lab.admin_username
    password = azurerm_container_registry.lab.admin_password
  }

  container {
    name   = "nginx-cr460"
    image  = "${azurerm_container_registry.lab.login_server}/cr460-web:${var.container_image_tag}"
    cpu    = 1
    memory = 1.5

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = local.common_tags
}

output "container_public_ip" {
  value = azurerm_container_group.docker.ip_address
}

output "container_url" {
  value = "http://${azurerm_container_group.docker.ip_address}"
}