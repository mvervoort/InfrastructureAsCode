# Infrastructure-as-Code - Pulumi on Azure - demo

This is an Infrastructure-as-Code demo using Pulumi to deploy to Azure cloud.

Terraform will be used to deploy:

- Azure Resource Group
- Azure App Service Plan
- Azure App Service (with random name)

# Prerequisites

- Pulumi installed  
  - https://www.pulumi.com/docs/install/
  - or `choco install pulumi`
- Pulumi account
  - Create a Pulumi account at https://app.pulumi.com/
  - Run `pulumi login`. Hit [Enter] to login using browser.
    
# Getting started

## Using PowerShell Notebook:

Open file [run.dib](run.dib), and hit the run button in the 'pulumi preview' and 'pulumi up' cell.

## Manual:

Open a terminal windows (shell/powershell/console) and execute the following commands:

- Prepare/init:
  - `pulumi stack select dev --create`
- Plan (what-if):
  - `pulumi preview`
- Deploy:
  - `pulumi up`
- Cleanup (delete):
  - `pulumi destroy`

