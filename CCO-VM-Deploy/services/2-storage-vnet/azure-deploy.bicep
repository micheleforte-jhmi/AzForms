param location string = 'eastus'
param vnetName string = 'myVNet'
param storageAccountName string = 'mystorageaccount' // Ensure globally unique
param addressSpace string = '10.0.0.0/16'
param subnetName string = 'mySubnet'
param subnetPrefix string = '10.0.1.0/24'

var subnets = [
  {
    name: subnetName
    addressPrefix: subnetPrefix
    serviceEndpoints: [
      {
        service: 'Microsoft.Storage'
      }
    ]
  }
]

module vnet '../../modules/vnet.bicep' = {
  name: '${vnetName}Deployment'
  params: {
    vnetName: vnetName
    location: location
    addressSpace: addressSpace
    subnets: subnets
  }
}

module storage '../../modules/storage-vnet.bicep' = {
  name: '${storageAccountName}Deployment'
  params: {
    storageAccountName: storageAccountName
    location: location
    subnetId: vnet.outputs.subnetIds[0].id
  }
}

