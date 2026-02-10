variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "public_subnet_name" {
  description = "Name of the public subnet for Databricks"
  type        = string
  default     = "databricks-public-subnet"
}

variable "private_subnet_name" {
  description = "Name of the private subnet for Databricks"
  type        = string
  default     = "databricks-private-subnet"
}

variable "public_subnet_prefix" {
  description = "Address prefix for public subnet"
  type        = list(string)
}

variable "private_subnet_prefix" {
  description = "Address prefix for private subnet"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
