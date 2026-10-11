resource "azurerm_network_interface" "windows" {
  name                = "nic-win-cr460"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.serveurs.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = local.common_tags
}

resource "azurerm_windows_virtual_machine" "windows" {
  name                = var.vm_name
  computer_name       = "win-cr460"
  resource_group_name = azurerm_resource_group.lab.name
  location            = var.vm_location
  size                = var.vm_size

  admin_username = "kamga_david"
  admin_password = azurerm_key_vault_secret.vm_password.value

  network_interface_ids = [
    azurerm_network_interface.windows_est.id
  ]

  os_disk {
    name                 = "disk-win-cr460"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-g2"
    version   = "latest"
  }

  tags = local.common_tags
}

output "windows_private_ip" {
  description = "Adresse IP privée de la VM Windows"
  value       = azurerm_network_interface.windows_est.private_ip_address
}