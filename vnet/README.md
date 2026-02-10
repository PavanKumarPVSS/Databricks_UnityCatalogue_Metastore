# Virtual Network Module

This module creates an Azure Virtual Network with subnets and network security groups.

## Prerequisites

- **Resource Group**: An existing Azure Resource Group must be created first

## Features

- Creates a VNet with configurable address space
- Creates public and private subnets
- Creates and associates NSGs to subnets
- Supports custom NSG rules

## Usage

```hcl
module "vnet" {
  source = "./modules/vnet"

  vnet_name           = "my-vnet"
  location            = "East US"
  resource_group_name = "my-resource-group"
  address_space       = ["10.0.0.0/16"]

  public_subnet_name    = "public-subnet"
  private_subnet_name   = "private-subnet"
  public_subnet_prefix  = ["10.0.1.0/24"]
  private_subnet_prefix = ["10.0.2.0/24"]

  tags = {
    environment = "production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vnet_name | Name of the virtual network | `string` | n/a | yes |
| resource_group_name | Name of the resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| address_space | Address space for the VNet | `list(string)` | n/a | yes |
| public_subnet_name | Name of the public subnet | `string` | n/a | yes |
| private_subnet_name | Name of the private subnet | `string` | n/a | yes |
| public_subnet_prefix | Address prefix for public subnet | `list(string)` | n/a | yes |
| private_subnet_prefix | Address prefix for private subnet | `list(string)` | n/a | yes |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vnet_id | ID of the virtual network |
| vnet_name | Name of the virtual network |
| public_subnet_id | ID of the public subnet |
| private_subnet_id | ID of the private subnet |
| public_nsg_id | ID of the public NSG |
| private_nsg_id | ID of the private NSG |
