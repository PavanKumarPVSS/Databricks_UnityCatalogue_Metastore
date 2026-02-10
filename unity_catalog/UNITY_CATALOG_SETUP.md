# Unity Catalog Setup Instructions

After Terraform deployment completes, follow these steps to complete Unity Catalog configuration:

## 1. Get the Output Values
```bash
terraform output unity_catalog_metastore_storage_path
terraform output unity_catalog_principal_id
```

## 2. Create Unity Catalog Metastore (in Databricks)

You'll need to create the metastore using Databricks CLI or UI:

### Option A: Using Databricks CLI
```bash
# Install Databricks CLI if not already installed
pip install databricks-cli

# Configure authentication
databricks configure --token

# Create metastore
databricks unity-catalog metastores create \
  --name "primary-metastore" \
  --storage-root "<metastore_storage_path_from_output>" \
  --region "eastus"
```

### Option B: Using Databricks UI
1. Log in to your Databricks workspace as an account admin
2. Go to Account Console > Data > Metastores
3. Click "Create Metastore"
4. Enter the metastore name
5. Use the storage path from the Terraform output
6. Select the Access Connector created by Terraform
7. Assign the metastore to your workspace

## 3. Assign Metastore to Workspace

The metastore needs to be assigned to your Databricks workspace. This can be done via:
- Databricks Account Console
- Databricks CLI
- Databricks Terraform provider (optional: can add this to your configuration)

## What Was Created:

✅ **Access Connector** - Managed Identity for Unity Catalog authentication
✅ **Storage Account** - ADLS Gen2 storage with hierarchical namespace enabled
✅ **Storage Container** - Dedicated container for Unity Catalog metadata
✅ **RBAC Assignment** - Storage Blob Data Contributor role for Access Connector

## Network Isolation Features:

- All Unity Catalog traffic stays within Azure backbone
- Storage account can be configured with private endpoints (optional)
- Access Connector uses managed identity (no keys/secrets)
- Compatible with your VNet-injected Databricks workspace
