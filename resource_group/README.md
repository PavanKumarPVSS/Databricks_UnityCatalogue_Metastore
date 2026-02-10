# Resource Group Module

This module creates an Azure Resource Group.

## Features

- Creates a resource group in the specified Azure region
- Supports custom tagging

## Usage

```hcl
module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = "my-resource-group"
  location            = "East US"

  tags = {
    environment = "production"
    managed_by  = "terraform"
    project     = "my-project"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| location | Azure region for the resource group | `string` | n/a | yes |
| tags | Tags to apply to the resource group | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| resource_group_id | ID of the resource group |
| resource_group_name | Name of the resource group |
| resource_group_location | Location of the resource group |
