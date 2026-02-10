# Storage Account
resource "azurerm_storage_account" "storage" {
  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.replication_type
  account_kind                    = var.account_kind
  min_tls_version                 = var.min_tls_version
  allow_nested_items_to_be_public = var.allow_public_access
  public_network_access_enabled   = var.public_network_access_enabled

  dynamic "blob_properties" {
    for_each = var.enable_blob_properties ? [1] : []
    content {
      versioning_enabled       = var.blob_versioning_enabled
      change_feed_enabled      = var.blob_change_feed_enabled
      last_access_time_enabled = var.blob_last_access_time_enabled

      dynamic "delete_retention_policy" {
        for_each = var.blob_delete_retention_days > 0 ? [1] : []
        content {
          days = var.blob_delete_retention_days
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = var.container_delete_retention_days > 0 ? [1] : []
        content {
          days = var.container_delete_retention_days
        }
      }
    }
  }

  dynamic "network_rules" {
    for_each = var.enable_network_rules ? [1] : []
    content {
      default_action             = var.network_rules_default_action
      ip_rules                   = var.network_rules_ip_rules
      virtual_network_subnet_ids = var.network_rules_subnet_ids
      bypass                     = var.network_rules_bypass
    }
  }

  tags = var.tags
}

# Storage Containers
resource "azurerm_storage_container" "containers" {
  for_each = var.containers

  name                  = each.key
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = each.value.access_type
}

# Storage Queues
resource "azurerm_storage_queue" "queues" {
  for_each = toset(var.queues)

  name                 = each.value
  storage_account_name = azurerm_storage_account.storage.name
}

# Storage Tables
resource "azurerm_storage_table" "tables" {
  for_each             = toset(var.tables)
  storage_account_name = azurerm_storage_account.storage.name
  name                 = each.value
}

# Storage Shares (File Shares)
resource "azurerm_storage_share" "shares" {
  for_each = var.file_shares

  name                 = each.key
  storage_account_name = azurerm_storage_account.storage.name
  quota                = each.value.quota
}
