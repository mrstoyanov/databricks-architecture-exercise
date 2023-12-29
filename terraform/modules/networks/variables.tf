variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "resource_group_location" {
  type        = string
  description = "The region of the resource group."
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "address_space" {
  type        = list(string)
  description = "The address space for the virtual network."
}

variable "subnet_names" {
  type        = list(string)
  description = "A list of subnets inside the virtual network."
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "The address prefix for the subnet."
}

variable "service_delegation" {
  type        = string
  default     = ""
  description = "Delegate a subnet to a service."
}

variable "service_delegated_actions" {
  type        = list(string)
  default     = []
  description = "Designate delegated service actions to a subnet."
}

variable "subnet_service_endpoints" {
  type        = map(list(string))
  default     = {}
  description = "Service endpoints for the subnet."
}

