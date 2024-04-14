// Input parameters
param environment string
param baseName string = 'iac-demo1-bicep'
param location string = resourceGroup().location
param sku string = 'B1'
param dotnet_version string = '8.0'

// Calculated variables
var kindOfRandom = substring(uniqueString(resourceGroup().id), 0, 4)
var appServicePlanName = '${baseName}-${environment}-plan'
var webAppName = '${baseName}-${environment}-${kindOfRandom}-webapp'

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
    capacity: 1
  }
  kind: 'linux'
}

// Web App
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|${dotnet_version}'
    }
  }
}


output webAppUrl string = appService.properties.defaultHostName
