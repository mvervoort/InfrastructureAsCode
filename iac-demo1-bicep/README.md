# Infrastructure-as-Code - Bicep on Azure - demo

This is an Infrastructure-as-Code demo using Bicep to deploy to on Azure cloud.

Terraform will be used to deploy:

- Azure Resource Group
- Azure App Service Plan
- Azure App Service (with pseude-random name)

# Prerequisites

- Azure CLI  
  https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli

# Getting started

## Option 1: Using PowerShell Notebook

Open file [run.dib](run.dib), and hit the run button in the 'terraform init', 'terraform plan' and 'terraform apply' cell.

## Option 2: Manual

Open a terminal windows (shell/powershell/console) and execute the following commands:

- Prepare/init:
  - `az account set --subscription "Visual Studio Premium met MSDN"`
  - `az group create --name "iac-demo1-bicep-dev-rg" --location westeurope`
- Plan (what-if):
  - `az deployment group what-if --resource-group "iac-demo1-bicep-dev-rg" --template-file "main.bicep" --parameters "parameters.$Environment.bicepparam"`
- Deploy:
  - `az deployment group create --resource-group "iac-demo1-bicep-dev-rg" --template-file "main.bicep"  --parameters "parameters.$Environment.bicepparam" --query properties.outputs`
- Cleanup (delete):
  - `az group delete --name "iac-demo1-bicep-dev-rg" --yes`
