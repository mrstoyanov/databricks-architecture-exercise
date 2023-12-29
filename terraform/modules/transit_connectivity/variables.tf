variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "resource_group_location" {
  type        = string
  description = "The region of the resource group."
}

variable "ipsec_preshared_key" {
  type        = string
  description = "IPsec authentication key."
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network for the Private Endpoint."
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet for the Private Endpoint."
}
