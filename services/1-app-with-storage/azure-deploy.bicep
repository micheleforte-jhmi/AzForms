@allowed([
  'nonprod'
  'prod'
])
param environmentType string
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

// removed, now in module 
//var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

param location string = resourceGroup().location
param prefix string= 'danfsnet'
param storageAccountName string

module cdn '../modules/storage.bicep' = {
  name: 'storage'
  params: {
    location: location
    storageAccountName: storageAccountName
    skuName: storageAccountSkuName
  }
}

module appService '../modules/appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    appServiceAppName: '${prefix}-appserviceplan'
    environmentType: environmentType
  }
}
