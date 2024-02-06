param vnetName string
param location string = resourceGroup().location
param addressSpace string
// Update subnets parameter to include serviceEndpoints for each subnet
param subnets array = []

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-03-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressSpace
      ]
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix
        // Directly use the provided serviceEndpoints for each subnet
        serviceEndpoints: subnet.serviceEndpoints
      }
    }]
  }
}

output vnetId string = virtualNetwork.id
output subnetIds array = [for subnet in subnets: {
  subnetId: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, subnet.name)
}]
