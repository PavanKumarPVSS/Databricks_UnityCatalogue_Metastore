# Databricks Workspace Module

This module creates an Azure Databricks Workspace with VNet injection.

## Prerequisites

- **Resource Group**: An existing Azure Resource Group must be created first
- **Virtual Network**: A VNet with public and private subnets must be created before deploying this module
- **Network Security Groups**: NSGs must be associated with the subnets

## Deployment Order

1. Deploy Resource Group
2. Deploy VNet with subnets and NSGs
3. Deploy Databricks Workspace

## Features

- Creates a Databricks workspace
- Supports VNet injection for secure connectivity
- Configurable SKU (Standard, Premium, Trial)
- Public access control
- No public IP option for secure cluster connectivity

## Usage

```hcl
module "databricks_workspace" {
  source = "./modules/databricks"

  workspace_name      = "my-databricks-workspace"
  resource_group_name = "my-resource-group"
  location            = "East US"
  sku                 = "premium"

  public_network_access_enabled         = false
  network_security_group_rules_required = "NoAzureDatabricksRules"
  no_public_ip                          = true

  virtual_network_id                = module.vnet.vnet_id
  public_subnet_name                = "databricks-public"
  private_subnet_name               = "databricks-private"
  public_subnet_nsg_association_id  = module.vnet.public_nsg_id
  private_subnet_nsg_association_id = module.vnet.private_nsg_id

  tags = {
    environment = "production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| workspace_name | Name of the Databricks workspace | `string` | n/a | yes |
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| sku | SKU for Databricks workspace | `string` | n/a | yes |
| public_network_access_enabled | Enable public network access | `bool` | `true` | no |
| no_public_ip | Use Secure Cluster Connectivity | `bool` | `false` | no |
| virtual_network_id | VNet ID for injection | `string` | n/a | yes |
| public_subnet_name | Name of public subnet | `string` | n/a | yes |
| private_subnet_name | Name of private subnet | `string` | n/a | yes |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| workspace_id | ID of the Databricks workspace |
| workspace_url | URL of the Databricks workspace |
| workspace_name | Name of the Databricks workspace |
| managed_resource_group_id | ID of the managed resource group |
