resource "azurerm_container_group" "docker" {
  name                = "aci-cr460-david"
  location            = "canadaeast"
  resource_group_name = azurerm_resource_group.lab.name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = "Always"

  container {
    name   = "nginx-cr460"
    image  = "docker.io/library/nginx:stable"
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