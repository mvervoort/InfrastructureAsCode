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

## Option 3: GitHub actions

Next to running this demo manual from your local machine, it's also possible to run it from GitHub actions.

1. Login to [GitHub.com](https://github.com)
2. Clone/fork this repo to your own GitHub account
3. Create a Service Principal in Azure using:  
  `az ad sp create-for-rbac --name "{sp-name}" --sdk-auth --role contributor --scopes /subscriptions/{subscription-id}`
4. Create some secrets in GitHub
  1. Navigate to 'Settings' > 'Secrets and variables' > 'Actions'
  2. Create secret `AZURE_CREDENTIALS` containing the JSON output of the `az ad sp create-for-rbac`, which looks like:
     ```json
     {
      "clientId": "<guid>",
      "displayName": "<sp-name>",
      "clientSecret": "<secret>",
      "tenantId": "<guid>",
      "subscriptionId": "<guid>"
     }
     ```
  3. Create secret `AZURE_SUBSCRIPTION` with the subscription ID.
5. Setup an action pipeline for [.github/workflows/iac-demo1-bicep.yml](/.github/workflows/iac-demo1-bicep.yml)
6. Run this pipeline

> Notice the WebApp URL in task 'Show Bicep output'