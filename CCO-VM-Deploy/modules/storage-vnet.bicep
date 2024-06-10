param storageAccountName string
param location string = resourceGroup().location
param skuName string = 'Standard_LRS'
param subnetId string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  properties: {
    networkAcls: {
      bypass: 'None'
      virtualNetworkRules: [
        {
          id: subnetId
          action: 'Allow'
        }
      ]
      ipRules: []
      defaultAction: 'Deny'
    }
  }
}

output storageAccount object = storageAccount
