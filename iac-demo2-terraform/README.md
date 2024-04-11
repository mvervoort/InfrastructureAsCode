# Infrastructure-as-Code - Terraform on Azure - demo

This is an Infrastructure-as-Code demo using Terraform to deploy to Azure cloud.

Terraform will be used to deploy:

- Azure Resource Group
- Azure App Service Plan
- Azure App Service (with random name)

# Prerequisites

- Terraform  
  https://developer.hashicorp.com/terraform/install  

# Getting started

## Using PowerShell Notebook:

Open file [run.dib](run.dib), and hit the run button in the 'terraform init', 'terraform plan' and 'terraform apply' cell.

## Manual:

Open a terminal windows (shell/powershell/console) and execute the following commands:

- Prepare/init:
  - `terraform init`
- Plan (what-if):
  - `terraform plan -var-file "parameters.dev.tfvars" --out=output.tfplan`
- Deploy:
  - `terraform apply output.tfplan`
- Cleanup (delete):
  - `terraform plan -destroy -var-file "parameters.dev.tfvars" --out=destroy.tfplan`
  - `terraform apply destroy.tfplan`
