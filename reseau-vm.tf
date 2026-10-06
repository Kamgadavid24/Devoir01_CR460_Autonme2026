resource "azurerm_virtual_network" "windows_est" {
  name                = "vnet-cr460-est"
  location            = "canadaeast"
  resource_group_name = azurerm_resource_group.lab.name
  address_space       = ["10.30.0.0/16"]
}

resource "azurerm_subnet" "windows_est" {
  name                 = "subnet-serveurs-est"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.windows_est.name
  address_prefixes     = ["10.30.1.0/24"]
}

resource "azurerm_network_interface" "windows_est" {
  name                = "nic-win-cr460-est"
  location            = "canadaeast"
  resource_group_name = azurerm_resource_group.lab.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.windows_est.id
    private_ip_address_allocation = "Dynamic"
  }
}