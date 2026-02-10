# Databricks Deployment with Unity Catalog on Azure

This project deploys a complete Azure Databricks infrastructure with Unity Catalog integration using Terraform and Azure DevOps pipelines.

## Architecture Overview

This deployment creates:
- **Resource Group**: Container for all Azure resources
- **Virtual Network**: VNet-injected Databricks workspace with public and private subnets
- **Storage Account**: General purpose storage for data and logs
- **Databricks Workspace**: Premium SKU workspace with secure cluster connectivity
- **Unity Catalog Infrastructure**: Access Connector and dedicated storage for Unity Catalog metastore
- **Databricks Platform**: Unity Catalog metastore, storage credentials, and external locations

## Prerequisites

- Azure subscription with appropriate permissions
- Azure DevOps project with service connection configured
- Terraform state storage (Resource Group, Storage Account, Container)
- Service principal with:
  - Contributor role on subscription/resource group
  - User Access Administrator role (for IAM assignments)

## Module Structure

```
├── resource_group/       # Creates Azure Resource Group
├── vnet/                 # Creates VNet with subnets and NSGs
├── storage_account/      # Creates storage account with containers
├── databricks/           # Creates Databricks workspace
├── unity_catalog/        # Creates Unity Catalog Azure infrastructure
├── databricks_platform/  # Configures Unity Catalog in Databricks
└── main.tf               # Root module orchestration
```

## Getting Started

### 1. Configure Variables

Edit `terraform.tfvars` with your configuration:

```hcl
location    = "Canada Central"
environment = "prod"

resource_group_name = "rg-databricks-prod"
vnet_name           = "vnet-databricks"
vnet_address_space  = ["10.0.0.0/16"]

# See terraform.tfvars for complete configuration
```

### 2. Configure Azure DevOps Pipeline

The `azure-pipelines.yml` includes three stages:
- **Validate**: Terraform init and validate
- **Plan**: Generate execution plan
- **Apply**: Deploy infrastructure

Required pipeline variable group `TFState` with:
- `TFStateResourceGroup`
- `TFStateStorageAccount`
- `TFStateContainer`
- `TFStatekey`

### 3. Deploy

**Via Azure DevOps Pipeline:**
1. Commit and push changes to DevOps repository
2. Pipeline triggers automatically
3. Review plan in the Plan stage
4. Approve deployment in Apply stage

**Via Local Terraform:**
```bash
terraform init \
  -backend-config="resource_group_name=<rg>" \
  -backend-config="storage_account_name=<sa>" \
  -backend-config="container_name=<container>" \
  -backend-config="key=terraform.tfstate"

terraform plan
terraform apply
```

## Configuration

### Location
All resources deploy to the region specified in `terraform.tfvars` (currently: Canada Central).

### Environment
Set environment name for resource naming: `dev`, `test`, or `prod`.

### Network Configuration
- Public subnet: 10.0.1.0/24
- Private subnet: 10.0.2.0/24
- No public IPs on clusters (Secure Cluster Connectivity enabled)
- Public network access to workspace disabled by default

### Unity Catalog
The deployment creates Unity Catalog infrastructure but requires manual steps to complete setup:
1. Access Databricks workspace as Account Admin
2. Navigate to Account Console > Data > Metastores
3. Verify or complete metastore assignment to workspace

See `unity_catalog/UNITY_CATALOG_SETUP.md` for detailed instructions.

## Modules

| Module | Description |
|--------|-------------|
| [resource_group](resource_group/) | Azure Resource Group |
| [vnet](vnet/) | Virtual Network with subnets and NSGs |
| [storage_account](storage_account/) | Storage account with blob containers |
| [databricks](databricks/) | Databricks workspace with VNet injection |
| [unity_catalog](unity_catalog/) | Unity Catalog Azure resources |
| [databricks_platform](databricks_platform/) | Unity Catalog Databricks configuration |

## Outputs

Key outputs available after deployment:
- `databricks_workspace_url`: Workspace URL for login
- `databricks_workspace_id`: Workspace identifier
- `unity_catalog_metastore_storage_path`: ADLS path for metastore
- `unity_catalog_access_connector_id`: Access Connector resource ID

## Security Features

- VNet-injected Databricks workspace
- No public IPs on clusters
- Private network access (can be enabled via terraform.tfvars)
- HTTPS-only storage accounts
- TLS 1.2 minimum
- Managed identities (no credential storage)
- RBAC role assignments

## Known Issues

1. **Role Assignment Permissions**: Service principal needs User Access Administrator role to create role assignments
2. **Databricks Login**: If public network access is disabled, workspace requires VPN/private endpoint access
3. **Unity Catalog Setup**: Metastore creation requires Databricks Account Admin privileges

## Maintenance

### Update Location
Modify `location` in `terraform.tfvars` and redeploy (will recreate most resources).

### Add Storage Containers
Add to `storage_containers` map in `terraform.tfvars`.

### Modify Network
Update CIDR ranges in `terraform.tfvars` (requires careful planning to avoid disruption).

## Support

For issues or questions:
1. Check module-specific README files
2. Review Azure DevOps pipeline logs
3. Consult Terraform state for resource details

## License

Microsoft Internal Project