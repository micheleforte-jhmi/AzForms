// create bicep module for storage
param storageAccountName string
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
    supportsHttpsTrafficOnly: true
  }
}

output storageAccountId string = storageAccount.id
