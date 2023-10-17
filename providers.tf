terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    databricks = {
      source = "databricks/databricks"
    }
  }
}

provider "azurerm" {
  subscription_id = local.subscription_id
  features {}
}

provider "databricks" {
  alias = "accounts"
  host  = "https://accounts.azuredatabricks.net"
  account_id = var.account_id
}


