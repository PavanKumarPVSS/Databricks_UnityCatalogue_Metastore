variable "access_connector_name" {
  description = "Name of the Databricks Access Connector"
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

variable "storage_account_name" {
  description = "Name of the storage account for Unity Catalog"
  type        = string
}

variable "container_name" {
  description = "Name of the storage container for Unity Catalog"
  type        = string
  default     = "unity-catalog"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
