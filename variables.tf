variable "resource_group_name" {
  description = "Nom du groupe de ressources Azure"
  type        = string
  default     = "rg-cr460-david"
}

variable "location" {
  description = "Région Azure"
  type        = string
  default     = "canadacentral"
}

variable "virtual_network_name" {
  description = "Nom du réseau virtuel"
  type        = string
  default     = "vnet-cr460"
}

variable "subnet_name" {
  description = "Nom du sous-réseau"
  type        = string
  default     = "subnet-serveurs"
}

variable "vm_admin_password" {
  description = "Davidkamga@cr460"
  type        = string
  sensitive   = true
}