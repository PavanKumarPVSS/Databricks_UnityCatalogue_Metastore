# ========================================
# General Variables
# ========================================

variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# ========================================
# Resource Group Variables
# ========================================

variable "resource_group_name" {
  description = "Name of the main resource group"
  type        = string
}

# ========================================
# Virtual Network Variables
# ========================================

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
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

# ========================================
# Storage Account Variables
# ========================================

variable "storage_account_name" {
  description = "Name of the storage account (3-24 chars, lowercase letters and numbers only)"
  type        = string
}

variable "storage_account_tier" {
  description = "Storage account tier (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Storage account replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)"
  type        = string
  default     = "LRS"
}

variable "storage_account_kind" {
  description = "Storage account kind (StorageV2, BlobStorage, FileStorage, Storage)"
  type        = string
  default     = "StorageV2"
}

variable "storage_enable_https_traffic_only" {
  description = "Enable HTTPS traffic only"
  type        = bool
  default     = true
}

variable "storage_min_tls_version" {
  description = "Minimum TLS version"
  type        = string
  default     = "TLS1_2"
}

variable "storage_allow_public_access" {
  description = "Allow public access to blobs"
  type        = bool
  default     = false
}

variable "storage_public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = true
}

variable "storage_enable_blob_properties" {
  description = "Enable blob properties configuration"
  type        = bool
  default     = false
}

variable "storage_blob_versioning_enabled" {
  description = "Enable blob versioning"
  type        = bool
  default     = false
}

variable "storage_blob_change_feed_enabled" {
  description = "Enable blob change feed"
  type        = bool
  default     = false
}

variable "storage_blob_last_access_time_enabled" {
  description = "Enable last access time tracking"
  type        = bool
  default     = false
}

variable "storage_blob_delete_retention_days" {
  description = "Number of days to retain deleted blobs (0 to disable)"
  type        = number
  default     = 0
}

variable "storage_container_delete_retention_days" {
  description = "Number of days to retain deleted containers (0 to disable)"
  type        = number
  default     = 0
}

variable "storage_enable_network_rules" {
  description = "Enable network rules"
  type        = bool
  default     = false
}

variable "storage_network_rules_default_action" {
  description = "Default action for network rules (Allow or Deny)"
  type        = string
  default     = "Deny"
}

variable "storage_network_rules_ip_rules" {
  description = "List of IP addresses or CIDR blocks to allow"
  type        = list(string)
  default     = []
}

variable "storage_network_rules_subnet_ids" {
  description = "List of subnet IDs to allow"
  type        = list(string)
  default     = []
}

variable "storage_network_rules_bypass" {
  description = "Services to bypass network rules"
  type        = list(string)
  default     = ["AzureServices"]
}

variable "storage_containers" {
  description = "Map of blob containers to create"
  type = map(object({
    access_type = string
  }))
  default = {}
}

variable "storage_queues" {
  description = "Set of queue names to create"
  type        = set(string)
  default     = []
}

variable "storage_tables" {
  description = "Set of table names to create"
  type        = set(string)
  default     = []
}

variable "storage_file_shares" {
  description = "Map of file shares to create"
  type = map(object({
    quota = number
  }))
  default = {}
}

# ========================================
# Databricks Variables
# ========================================

variable "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
}

variable "databricks_sku" {
  description = "SKU for Databricks workspace (standard, premium, trial)"
  type        = string
  default     = "premium"
}

variable "databricks_public_network_access_enabled" {
  description = "Enable public network access for Databricks"
  type        = bool
  default     = false
}

variable "databricks_nsg_rules_required" {
  description = "Does the data plane require NSG rules"
  type        = string
  default     = "NoAzureDatabricksRules"
}

variable "databricks_no_public_ip" {
  description = "Use private IPs only (Secure Cluster Connectivity)"
  type        = bool
  default     = true
}

# ========================================
# Unity Catalog Variables
# ========================================

variable "unity_catalog_access_connector_name" {
  description = "Name of the Databricks Access Connector for Unity Catalog"
  type        = string
}

variable "unity_catalog_storage_account_name" {
  description = "Name of the storage account for Unity Catalog"
  type        = string
}

variable "unity_catalog_container_name" {
  description = "Name of the storage container for Unity Catalog"
  type        = string
  default     = "unity-catalog"
}
