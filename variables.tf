/*variable "databricks_resource_id" {
  description = "The Azure resource ID for the databricks workspace deployment."
}*/
data "azurerm_resource_group" "existing_rg" {
  name = "sindhu-wegmans-uc"
  }

data "azurerm_client_config" "current" {
}

data "azurerm_databricks_workspace" "this" {
  name                = "wegmans-workspace"
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  
}
locals {
  subscription_id           = "3f2e4d32-8e8d-46d6-82bc-5bb8d962328b"//regex(local.resource_regex, var.databricks_resource_id)[0]""
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  databricks_workspace_host = data.azurerm_databricks_workspace.this.workspace_url
  databricks_workspace_id   = data.azurerm_databricks_workspace.this.workspace_id
  prefix                    = "wegmansuc"
}

variable "account_id" {
  type = string
  default = "827e3e09-89ba-4dd2-9161-a3301d0f21c0"
}
