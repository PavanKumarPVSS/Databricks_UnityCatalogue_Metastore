variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Storage account name must be 3-24 characters, lowercase letters and numbers only."
  }
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the storage account"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier (Standard or Premium)"
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account tier must be Standard or Premium."
  }
}

variable "replication_type" {
  description = "Storage account replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)"
  type        = string
  default     = "LRS"
  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.replication_type)
    error_message = "Invalid replication type."
  }
}

variable "account_kind" {
  description = "Storage account kind (StorageV2, BlobStorage, FileStorage, Storage)"
  type        = string
  default     = "StorageV2"
  validation {
    condition     = contains(["StorageV2", "BlobStorage", "FileStorage", "Storage"], var.account_kind)
    error_message = "Invalid account kind."
  }
}

variable "enable_https_traffic_only" {
  description = "Enable HTTPS traffic only"
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "Minimum TLS version"
  type        = string
  default     = "TLS1_2"
  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], var.min_tls_version)
    error_message = "Invalid TLS version."
  }
}

variable "allow_public_access" {
  description = "Allow public access to blobs"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = true
}

# Blob Properties
variable "enable_blob_properties" {
  description = "Enable blob properties configuration"
  type        = bool
  default     = false
}

variable "blob_versioning_enabled" {
  description = "Enable blob versioning"
  type        = bool
  default     = false
}

variable "blob_change_feed_enabled" {
  description = "Enable blob change feed"
  type        = bool
  default     = false
}

variable "blob_last_access_time_enabled" {
  description = "Enable last access time tracking"
  type        = bool
  default     = false
}

variable "blob_delete_retention_days" {
  description = "Number of days to retain deleted blobs (0 to disable)"
  type        = number
  default     = 0
}

variable "container_delete_retention_days" {
  description = "Number of days to retain deleted containers (0 to disable)"
  type        = number
  default     = 0
}

# Network Rules
variable "enable_network_rules" {
  description = "Enable network rules"
  type        = bool
  default     = false
}

variable "network_rules_default_action" {
  description = "Default action for network rules (Allow or Deny)"
  type        = string
  default     = "Deny"
  validation {
    condition     = contains(["Allow", "Deny"], var.network_rules_default_action)
    error_message = "Default action must be Allow or Deny."
  }
}

variable "network_rules_ip_rules" {
  description = "List of IP addresses or CIDR blocks to allow"
  type        = list(string)
  default     = []
}

variable "network_rules_subnet_ids" {
  description = "List of subnet IDs to allow"
  type        = list(string)
  default     = []
}

variable "network_rules_bypass" {
  description = "Services to bypass network rules"
  type        = list(string)
  default     = ["AzureServices"]
}

# Containers, Queues, Tables, Shares
variable "containers" {
  description = "Map of blob containers to create"
  type = map(object({
    access_type = string
  }))
  default = {}
}

variable "queues" {
  description = "Set of queue names to create"
  type        = set(string)
  default     = []
}

variable "tables" {
  description = "Set of table names to create"
  type        = set(string)
  default     = []
}

variable "file_shares" {
  description = "Map of file shares to create"
  type = map(object({
    quota = number
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
