// create bicep module for storage
param storageAccountName string
// param location string = resourceGroup().location

@description('Location for all resources.')
param location string = resourceGroup().location

param skuName string = 'Standard_LRS' // Default to "Standard_LRS", can be overridden

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true  // set up your modules with presets
  }
}

output storageAccountId string = storageAccount.id
