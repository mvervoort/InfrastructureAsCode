// Input parameters
param location string = resourceGroup().location
param appServicePlanName string = 'iac-demo1-bicep-plan'
param webAppName string = 'iac-demo1-bicep-<kindOfRandom>-webapp'
param sku string = 'B1'
param linuxFxVersion string = 'DOTNETCORE|8.0'

// Calculated variables
var kindOfRandom = substring(uniqueString(resourceGroup().id), 0, 4)
var webAppNameCalculated = replace(webAppName, '<kindOfRandom>', kindOfRandom)

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
}

// Web App
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webAppNameCalculated
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
}


output webAppUrl string = appService.properties.defaultHostName
