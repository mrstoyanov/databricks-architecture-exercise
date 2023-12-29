variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "resource_group_location" {
  type        = string
  description = "The region of the resource group."
}

variable "vnet_src_name" {
  type        = string
  description = "The name of the source virtual network."
}

variable "vnet_dst_name" {
  type        = string
  description = "The name of the destination virtual network."
}
