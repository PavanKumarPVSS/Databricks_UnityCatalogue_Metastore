variable "workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "sku" {
  description = "SKU for Databricks workspace (standard, premium, trial)"
  type        = string
  default     = "premium"
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = false
}

variable "network_security_group_rules_required" {
  description = "Does the data plane require NSG rules"
  type        = string
  default     = "NoAzureDatabricksRules"
}

variable "no_public_ip" {
  description = "Use private IPs only (Secure Cluster Connectivity)"
  type        = bool
  default     = true
}

variable "virtual_network_id" {
  description = "ID of the virtual network"
  type        = string
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
  type        = string
}

variable "private_subnet_name" {
  description = "Name of the private subnet"
  type        = string
}

variable "public_subnet_nsg_association_id" {
  description = "ID of public subnet NSG association"
  type        = string
}

variable "private_subnet_nsg_association_id" {
  description = "ID of private subnet NSG association"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
