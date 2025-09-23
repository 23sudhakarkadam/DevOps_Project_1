terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.44.0"
    }
    template = {
        source = "hashicorp/template"
        version = "2.2.0" 
    }
    
  }

  backend "azurerm" {
    resource_group_name   = "rg-terraform-backend"     # Resource group of your storage account
    storage_account_name  = "skstrterraformbackend"           # Storage account name (must be globally unique)
    container_name        = "tfstate"                  # Blob container to hold state files
    key                   = "project_1_app.terraform.tfstate"   # Name of the state file
  }
}

provider "azurerm" {
    features {}
}