# Input Variables
variable "environment" {
  type    = string
}

variable "baseName" {
  type    = string
  default = "iac-demo2-terraform"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "sku" {
  type    = string
  default = "B1"
}

variable "dotnet_version" {
  type    = string
  default = "8.0"
}

locals {
  resource_group_name = "${var.baseName}-${var.environment}-rg"
}

# Resource Group
resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location
}


# App Service Plan
resource "azurerm_service_plan" "this" {
  name                = "${var.baseName}-${var.environment}-plan"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"
  sku_name            = var.sku
  worker_count        = 1
}

# Random String
resource "random_string" "this" {
  length  = 4
  special = false
}

# Web App
resource "azurerm_linux_web_app" "webapp" {
  name                = "${var.baseName}-${var.environment}-${random_string.this.id}-webapp"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on = false
    application_stack {
      dotnet_version = "8.0"
    }
  }
}
