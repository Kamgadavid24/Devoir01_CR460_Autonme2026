variable "resource_group_name" {
  description = "Nom du groupe de ressources Azure"
  type        = string
  default     = "rg-cr460-david"
}

variable "location" {
  description = "Région Azure du groupe de ressources et du réseau principal"
  type        = string
  default     = "canadacentral"
}

variable "virtual_network_name" {
  description = "Nom du réseau virtuel principal"
  type        = string
  default     = "vnet-cr460"
}

variable "subnet_name" {
  description = "Nom du sous-réseau principal"
  type        = string
  default     = "subnet-serveurs"
}

variable "vm_admin_password" {
  description = "Mot de passe administrateur de la VM Windows"
  type        = string
  sensitive   = true
}

variable "vm_location" {
  description = "Région Azure de la VM Windows et de son réseau"
  type        = string
  default     = "canadaeast"
}

variable "vm_name" {
  description = "Nom de la machine virtuelle Windows"
  type        = string
  default     = "vm-win-cr460"
}

variable "vm_size" {
  description = "Taille de la machine virtuelle Windows"
  type        = string
  default     = "Standard_B2s_v2"
}