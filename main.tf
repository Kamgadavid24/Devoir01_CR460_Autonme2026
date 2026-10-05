terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "lab" {
  name     = "rg-cr460-david"
  location = "canadacentral"

  tags = {
    projet = "CR460"
    auteur = "David-Kamga"
  }
}

resource "azurerm_virtual_network" "lab" {
  name                = "vnet-cr460"
  address_space       = ["10.20.0.0/16"]
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
}

resource "azurerm_subnet" "serveurs" {
  name                 = "subnet-serveurs"
  resource_group_name  = azurerm_resource_group.lab.name
  virtual_network_name = azurerm_virtual_network.lab.name
  address_prefixes     = ["10.20.1.0/24"]
}

output "resource_group_name" {
  value = azurerm_resource_group.lab.name
}

output "subnet_id" {
  value = azurerm_subnet.serveurs.id
}