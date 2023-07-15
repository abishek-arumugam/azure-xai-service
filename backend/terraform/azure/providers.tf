provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_password
  tenant_id       = var.azure_tenant_id
}

provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket         = "bucket-tfstate-test"
    key            = "state-file/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

resource "azurerm_virtual_network" "xai-vn" {
  name                = "xai-vn"
  resource_group_name = "aci-xai-rg"
  location            = "East US"
  address_space       = ["10.0.0.0/16"]
}
