param location string
param appServiceAppName string

@allowed([
  'nonprod'
  'prod'
])

param environmentType string
param prefix string= 'danfsnet'

var appServicePlanName = '${prefix}-plan'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

// pass appServiceAppHostName as output if needed
output appServiceAppHostName string = appServiceApp.properties.defaultHostName


