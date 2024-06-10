param virtualNetworkName string
param location string
param addressPrefix string
param subnetName string
param subnetPrefix string
param nsgId string

resource vnet 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
          networkSecurityGroup: {
            id: nsgId
          }
        }
      }
    ]
  }
}

output vnet object = vnet
