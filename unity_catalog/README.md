# Unity Catalog Module

This module creates Azure resources for Databricks Unity Catalog.

## Prerequisites

- **Resource Group**: An existing Azure Resource Group must be created first
- **Databricks Workspace** (optional): While not technically required, Unity Catalog is typically used with an existing Databricks workspace

## Features

- Creates Databricks Access Connector with managed identity
- Creates dedicated storage account for Unity Catalog metastore
- Creates storage container for Unity Catalog data
- Assigns Storage Blob Data Contributor role to the access connector

## Usage

```hcl
module "unity_catalog" {
  source = "./modules/unity_catalog"

  access_connector_name = "databricks-access-connector"
  resource_group_name   = "my-resource-group"
  location              = "East US"
  storage_account_name  = "unitycatalogstore123"
  container_name        = "unity-catalog"

  tags = {
    environment = "production"
    purpose     = "unity-catalog"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access_connector_name | Name of the Databricks Access Connector | `string` | n/a | yes |
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| storage_account_name | Name of the storage account | `string` | n/a | yes |
| container_name | Name of the storage container | `string` | n/a | yes |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| access_connector_id | ID of the Access Connector |
| storage_account_name | Name of the storage account |
| metastore_storage_path | Storage path for Unity Catalog metastore |
| access_connector_principal_id | Principal ID of the Access Connector |
