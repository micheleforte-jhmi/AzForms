@description('The name of the VM')
param virtualMachineName string

@description('The name of the Network Security Group')
param networkSecurityGroupName string

@description('The name of the Key Vault')
param keyVaultName string

@description('The name of the secret for the admin username')
param adminUsernameSecretName string = 'CloudADM'

@description('The name of the secret for the admin password')
param adminPasswordSecretName string = 'adminPassword'

@description('The size in GB of the data disks')
param dataDiskSize int = 1024

@description('The number of data disks to create')
param dataDisksCount int = 2

@description('The Storage type of the data Disks')
@allowed([
  'StandardSSD_LRS'
  'Standard_LRS'
  'Premium_LRS'
])
param diskType string = 'StandardSSD_LRS'

@description('The virtual machine size. Enter a Premium capable VM size if DiskType is entered as Premium_LRS')
@allowed([
  'Standard_D2s_v3'
  'Standard_D2s_v4'
  'Standard_D2s_v5'
  'Standard_D4s_v5'
])
param virtualMachineSize string = 'Standard_D2s_v3'

@description('The Windows version for the VM.')
@allowed([
  '2019-Datacenter'
  '2022-Datacenter'
])
param windowsOSVersion string = '2022-Datacenter'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The ID of the existing virtual network')
param virtualNetworkId string

@description('The name of the subnet in the existing virtual network')
param subnetName string

// Get the existing Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2021-04-01-preview' existing = {
  name: keyVaultName
}

// Retrieve the secrets from the Key Vault
var adminUsername = listSecret('https://${keyVaultName}.vault.azure.net/secrets/${adminUsernameSecretName}', '2021-04-01').value
var adminPassword = listSecret('https://${keyVaultName}.vault.azure.net/secrets/${adminPasswordSecretName}', '2021-04-01').value

// Reference the existing subnet within the VNet
resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' existing = {
  name: resourceId('Microsoft.Network/virtualNetworks', virtualNetworkId)
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2020-06-01' existing = {
  parent: vnet
  name: subnetName
}

// Use the retrieved secrets and existing VNet in your resource definitions
resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: virtualMachineName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: virtualMachineSize
    }
    osProfile: {
      computerName: virtualMachineName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        // Other Windows configuration settings
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: windowsOSVersion
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: [for i in range(0, dataDisksCount): {
        lun: i
        createOption: 'Empty'
        diskSizeGB: dataDiskSize
        managedDisk: {
          storageAccountType: diskType
        }
      }]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: resourceId('Microsoft.Network/networkInterfaces', '${virtualMachineName}-nic')
        }
      ]
    }
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: '${virtualMachineName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}
