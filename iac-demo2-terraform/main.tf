# Resource Group
resource "azurerm_resource_group" "this" {
  name     = "iac-demo2-terraform-rg"
  location = "westeurope"
}


# App Service Plan
resource "azurerm_service_plan" "this" {
  name                = "iac-demo2-terraform-plan"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"
  sku_name            = "B1"
}

# Random String
resource "random_string" "this" {
  length  = 4
  special = false
}

# Web App
resource "azurerm_linux_web_app" "webapp" {
  name                = "iac-demo2-terraform-${random_string.this.id}-webapp"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on = false
    application_stack {
      dotnet_version = "8.0"
    }
  }
}
