# Infrastructure-as-Code

_**Demos/examples on how to implement Infrastructure as Code (IaC)**_

This repo contains some examples (or demos) on how to use IaC
to deploy cloud resources. 

The demo's are targeting are used to deploy:

- Azure Resource Group
- Azure App Service Plan
- Azure App Service (with random name)

All the demo's will show the basic concept of IaC including:

- Idempotent deployments (multiple runs will not create new but update existing resources)
- CI/CD using GitHub actions (TODO)
- DTAP environments (dev, test, acceptance, production)
- Return output parameter (URL of App Service)

## PowerShell Notebook (optional)

Many of the demo's using a PowerShell Notebook for easy demonstration.
See [Build PowerShell notebooks using VScode and Polyglot (seifbassem.com)](https://www.seifbassem.com/blogs/posts/vscode-polyglot-notebooks/)
It's not mandatory to install or use, but for sure can be handy. 
With (PowerShell) Notebooks you can easily select/write/update code and execute it. No need to copy snippets and past them in the terminal.

To install PowerShell Notebooks:

- VS code  
  `winget install -e --id Microsoft.VisualStudioCode --no-upgrade`
- .NET SDK  
  `winget install -e --id Microsoft.DotNet.SDK.7 --no-upgrade`
- PowerShell 7  
  `winget install --id Microsoft.Powershell --source winget`
- PowerShell extention for VS Code  
  `code --install-extension ms-vscode.powershell`
- Polyglot Notebooks for VS Code  
  `code --install-extension ms-dotnettools.dotnet-interactive-vscode`

## Getting Started

- Clone the repo to your local machine
- Browse to the README.md of any of the examples:
  - [iac-demo1-bicep](iac-demo1-bicep/README.md)
  - [iac-demo2-terraform](iac-demo2-terraform/README.md)
  - [iac-demo3-pulumi](iac-demo3-pulumi/README.md)

## TODO

- Add GitHub actions
- Add DTAP