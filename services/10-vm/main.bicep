@description('Name of the virtual machine')
param vmName string

@description('The virtual machine size. Enter a Premium capable VM size if DiskType is entered as Premium_LRS')
@allowed([
  'Standard_D2s_v3'
  'Standard_D2s_v4'
  'Standard_D2s_v5'
  'Standard_D4s_v5'
])
param virtualMachineSize string = 'Standard_D2s_v3'

@description('Key Vault name')
param keyVaultName string = 'AzFormDeployKV'

@description('Secret name for the admin password')
param adminPasswordSecretName string = 'adminpassword'

@description('The Windows version for the VM.')
@allowed([
  '2019-Datacenter'
  '2022-Datacenter'
])
param windowsOSVersion string = '2022-Datacenter'

@description('Select an existing Virtual Network')
@allowed([
  'AZ-East-JH-Training-10.150.224.0-20'
  'AZ-East2-JH-TRAINING-10.156.224.0-20'
])
param vnetName string = 'AZ-East2-JH-TRAINING-10.156.224.0-20'

@description('Select an existing Virtual Network resource group')
@allowed([
    'JH-TRAINING-PROD-RG'
    'JH-TRAINING-TEST-RG'
  ])
param vnetResourceGroup string = 'JH-TRAINING-PROD-RG'

@description('Select a subnet name from the selected Virtual Network')
@allowed([
  'AZ-East2-JH-TRAINING-10.156.231.0-20'
  'AZ-East-JH-Training-10.150.224.0-20'
])


param subnetName string

@description('Location for all resources')
param location string = resourceGroup().location

@description('Admin Username for the virtual machine')
param adminUsername string = 'CloudADM'

// Get the existing virtual network
resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: vnetName
  scope: resourceGroup(vnetResourceGroup)
}

// Get the existing subnet
resource subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' existing = {
  name: subnetName
  parent: vnet
}

// Get the Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2021-04-01-preview' existing = {
  name: keyVaultName
}

// Get the admin password from Key Vault
resource adminPasswordSecret 'Microsoft.KeyVault/vaults/secrets@2021-04-01-preview' existing = {
  name: adminPasswordSecretName
  parent: keyVault
}

// Create a network interface without a public IP address
resource nic 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: '${vmName}-nic'
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

// Create a virtual machine
resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: virtualMachineSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: {
        value: adminPasswordSecret.properties.value
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
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}

output vmId string = vm.id
