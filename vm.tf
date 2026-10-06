resource "azurerm_network_interface" "windows" {
  name                = "nic-win-cr460"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.serveurs.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "windows" {
  name                = "vm-win-cr460"
  computer_name       = "win-cr460"
  resource_group_name = azurerm_resource_group.lab.name
  location            = azurerm_resource_group.lab.location
  size                = "Standard_B2s"

  admin_username = "kamga_david"
  admin_password = var.vm_admin_password

  network_interface_ids = [
    azurerm_network_interface.windows.id
  ]

  os_disk {
    name                 = "disk-win-cr460"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter"
    version   = "latest"
  }

  tags = {
    projet = "CR460"
    auteur = "David-Kamga"
  }
}

output "windows_private_ip" {
  value = azurerm_network_interface.windows.private_ip_address
}