# Storage Account Module

This module creates an Azure Storage Account with optional containers, queues, tables, and file shares.

## Prerequisites

- **Resource Group**: An existing Azure Resource Group must be created first
- **Virtual Network** (optional): Required only if using network rules with subnet restrictions

## Features

- Creates storage account with configurable tier and replication
- Security features (HTTPS only, TLS version, public access control)
- Optional blob properties (versioning, change feed, retention)
- Optional network rules for restricted access
- Creates blob containers, queues, tables, and file shares
- Comprehensive validation

## Usage

### Basic Storage Account

```hcl
module "storage_account" {
  source = "./modules/storage_account"

  storage_account_name = "mystorageacct123"
  resource_group_name  = "my-resource-group"
  location             = "East US"
  account_tier         = "Standard"
  replication_type     = "LRS"
  account_kind         = "StorageV2"

  tags = {
    environment = "production"
  }
}
```

### With Containers and Network Rules

```hcl
module "storage_account" {
  source = "./modules/storage_account"

  storage_account_name = "mystorageacct123"
  resource_group_name  = "my-resource-group"
  location             = "East US"
  account_tier         = "Standard"
  replication_type     = "GRS"

  enable_https_traffic_only     = true
  min_tls_version               = "TLS1_2"
  allow_public_access           = false
  public_network_access_enabled = true

  enable_blob_properties        = true
  blob_versioning_enabled       = true
  blob_delete_retention_days    = 7
  container_delete_retention_days = 7

  enable_network_rules           = true
  network_rules_default_action   = "Deny"
  network_rules_ip_rules         = ["203.0.113.0/24"]
  network_rules_bypass           = ["AzureServices"]

  containers = {
    "data" = {
      access_type = "private"
    }
    "backups" = {
      access_type = "private"
    }
  }

  queues = ["processing", "notifications"]

  tables = ["logs", "metrics"]

  file_shares = {
    "documents" = {
      quota = 100
    }
  }

  tags = {
    environment = "production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| storage_account_name | Storage account name (3-24 chars, lowercase, numbers only) | `string` | n/a | yes |
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| account_tier | Storage tier (Standard or Premium) | `string` | `"Standard"` | no |
| replication_type | Replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS) | `string` | `"LRS"` | no |
| account_kind | Storage account kind | `string` | `"StorageV2"` | no |
| enable_https_traffic_only | Enable HTTPS only | `bool` | `true` | no |
| min_tls_version | Minimum TLS version | `string` | `"TLS1_2"` | no |
| allow_public_access | Allow public blob access | `bool` | `false` | no |
| enable_blob_properties | Enable blob properties | `bool` | `false` | no |
| blob_versioning_enabled | Enable blob versioning | `bool` | `false` | no |
| blob_delete_retention_days | Blob delete retention days (0 to disable) | `number` | `0` | no |
| enable_network_rules | Enable network rules | `bool` | `false` | no |
| network_rules_default_action | Default action (Allow or Deny) | `string` | `"Deny"` | no |
| network_rules_ip_rules | Allowed IP addresses/CIDR blocks | `list(string)` | `[]` | no |
| containers | Map of blob containers to create | `map(object)` | `{}` | no |
| queues | Set of queue names | `set(string)` | `[]` | no |
| tables | Set of table names | `set(string)` | `[]` | no |
| file_shares | Map of file shares with quotas | `map(object)` | `{}` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| storage_account_id | ID of the storage account |
| storage_account_name | Name of the storage account |
| primary_blob_endpoint | Primary blob endpoint |
| primary_queue_endpoint | Primary queue endpoint |
| primary_table_endpoint | Primary table endpoint |
| primary_file_endpoint | Primary file endpoint |
| primary_access_key | Primary access key (sensitive) |
| primary_connection_string | Primary connection string (sensitive) |
| container_names | List of created container names |
| queue_names | List of created queue names |
| table_names | List of created table names |
| file_share_names | List of created file share names |
