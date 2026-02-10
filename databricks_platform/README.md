# Databricks Platform Module

This module configures Unity Catalog within an existing Databricks workspace using the Databricks Terraform provider. It creates the Unity Catalog metastore, storage credentials, and external locations.

## Prerequisites

- **Databricks Workspace**: An existing Databricks workspace must be deployed
- **Unity Catalog Azure Infrastructure**: Access Connector and storage account must exist (created by unity_catalog module)
- **Databricks Provider Authentication**: Requires authentication to Databricks workspace
- **Permissions**: Databricks Account Admin privileges required for metastore operations

## What This Module Does

This module performs Databricks platform-level configuration (not Azure infrastructure):

1. **Configures Databricks Provider**: Connects to workspace using workspace URL
2. **Creates Unity Catalog Metastore**: Defines the metastore with storage root location
3. **Assigns Metastore to Workspace**: Links the metastore to the Databricks workspace
4. **Creates Storage Credential**: Configures managed identity access via Access Connector
5. **Creates External Location**: Sets up Unity Catalog governed storage access

## Architecture

```
┌─────────────────────────────────────────────────┐
│ Azure Infrastructure (unity_catalog module)     │
│  - Access Connector (Managed Identity)         │
│  - Storage Account (ADLS Gen2)                  │
│  - Storage Container                            │
│  - RBAC: Storage Blob Data Contributor          │
└─────────────────────────────────────────────────┘
                      ▼
┌─────────────────────────────────────────────────┐
│ Databricks Platform (this module)              │
│  - Unity Catalog Metastore                      │
│  - Metastore Assignment                         │
│  - Storage Credential                           │
│  - External Location                            │
└─────────────────────────────────────────────────┘
```

## Usage

```hcl
module "databricks_platform" {
  source = "./databricks_platform"

  # From databricks module
  workspace_url = module.databricks.workspace_url
  workspace_id  = module.databricks.workspace_id

  # From unity_catalog module
  access_connector_id  = module.unity_catalog.access_connector_id
  storage_account_name = module.unity_catalog.storage_account_name
  container_name       = module.unity_catalog.container_name

  # Configuration
  location    = "Canada Central"
  environment = "prod"
}
```

## Module Dependencies

This module must be deployed **after**:
1. `resource_group` module
2. `databricks` module (workspace must exist)
3. `unity_catalog` module (Azure resources must exist)

## Databricks Provider Configuration

⚠️ **Important**: This module contains a local provider configuration:

```hcl
provider "databricks" {
  host = var.workspace_url
}
```

This means:
- The module cannot use `count`, `for_each`, or `depends_on`
- Authentication is done via workspace URL (Azure CLI or service principal)
- Requires Databricks Account Admin permissions

### Authentication Methods

The Databricks provider will use Azure authentication:
1. **Azure CLI**: If running locally with `az login`
2. **Service Principal**: If using Azure DevOps service connection via `AzureCLI@2` task
3. **Managed Identity**: If running from Azure VM/service with managed identity

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| workspace_url | Databricks workspace URL | `string` | yes |
| workspace_id | Databricks workspace ID | `string` | yes |
| access_connector_id | Resource ID of Access Connector | `string` | yes |
| storage_account_name | Storage account name for Unity Catalog | `string` | yes |
| container_name | Storage container name | `string` | yes |
| location | Azure region (must match workspace) | `string` | yes |
| environment | Environment name (dev, test, prod) | `string` | yes |

## Outputs

| Name | Description |
|------|-------------|
| metastore_id | Unity Catalog metastore ID |
| metastore_name | Unity Catalog metastore name |
| storage_credential_name | Storage credential name |
| external_location_name | External location name |
| external_location_url | External location URL |

## Resources Created

### databricks_metastore
- **Name**: `uc-metastore-{environment}`
- **Owner**: `account-admins`
- **Storage Root**: ABFSS path to Unity Catalog container

### databricks_metastore_assignment
- Assigns the metastore to the workspace
- Enables Unity Catalog features in workspace

### databricks_storage_credential
- **Name**: `uc-storage-credential-{environment}`
- **Type**: Azure Managed Identity
- **Access Connector**: Links to Azure Access Connector
- **Owner**: `account-admins`

### databricks_external_location
- **Name**: `uc-root-location-{environment}`
- **URL**: ABFSS path to Unity Catalog container
- **Credential**: Uses the storage credential above
- **Owner**: `account-admins`

## Important Notes

### Account Admin Requirement
Creating and assigning Unity Catalog metastores requires **Databricks Account Admin** privileges. Ensure your authentication principal has these permissions.

### One Metastore Per Region
Unity Catalog metastores are regional. You can only have one metastore per region per account.

### Storage Root Immutability
The metastore storage root location cannot be changed after creation. Plan carefully before deployment.

### Workspace Assignment
A workspace can only be assigned to one metastore. Reassigning requires removing the previous assignment first.

## Post-Deployment Steps

After this module deploys successfully:

1. **Verify Metastore**: Log into Databricks workspace and check Unity Catalog is enabled
2. **Create Catalogs**: Create catalogs within the metastore
3. **Create Schemas**: Create schemas within catalogs
4. **Grant Permissions**: Assign appropriate permissions to users/groups
5. **Create Tables**: Start creating Unity Catalog managed tables

## Troubleshooting

### Authentication Errors
```
Error: cannot authenticate Databricks
```
**Solution**: Ensure Azure authentication is configured and account has Databricks admin permissions.

### Metastore Already Exists
```
Error: metastore already exists in this region
```
**Solution**: Use existing metastore or delete the existing one (data will be lost).

### Permission Denied
```
Error: must be account admin
```
**Solution**: Grant Databricks Account Admin role to the service principal or user.

### Storage Credential Issues
```
Error: cannot access storage account
```
**Solution**: Verify Access Connector has Storage Blob Data Contributor role on the storage account.

## Example: Complete Deployment

```hcl
# 1. Create Azure resources
module "unity_catalog" {
  source = "./unity_catalog"
  # ... configuration
}

# 2. Configure Databricks Unity Catalog
module "databricks_platform" {
  source = "./databricks_platform"

  workspace_url        = module.databricks.workspace_url
  workspace_id         = module.databricks.workspace_id
  access_connector_id  = module.unity_catalog.access_connector_id
  storage_account_name = module.unity_catalog.storage_account_name
  container_name       = module.unity_catalog.container_name
  
  location    = "Canada Central"
  environment = "prod"
}
```

## Security Considerations

- Uses Azure managed identities (no credentials stored)
- Storage access controlled via RBAC
- All access governed by Unity Catalog
- Audit logs available in Databricks
- Complies with Azure backbone network security

## References

- [Databricks Unity Catalog Documentation](https://docs.databricks.com/data-governance/unity-catalog/index.html)
- [Databricks Terraform Provider](https://registry.terraform.io/providers/databricks/databricks/latest/docs)
- [Azure Databricks Access Connector](https://learn.microsoft.com/en-us/azure/databricks/data-governance/unity-catalog/azure-managed-identities)
