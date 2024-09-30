terraform {
  backend "azurerm" {
    resource_group_name  = "origenAI"
    storage_account_name = "origenai2024"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

variable "subscription_id" {}


provider "azurerm" {
  features {}
  subscription_id = var.subscription_id

}

