@description('Name of the virtual machine. Ensure the name starts with JHCTX.')
param vmName string = 'JHCTX'

@description('The virtual machine size. Enter a Premium capable VM size if DiskType is entered as Premium_LRS')
@allowed([
  'Standard_D2s_v3'
  'Standard_D2s_v4'
  'Standard_D2s_v5'
  'Standard_D4s_v5'
])
param virtualMachineSize string = 'Standard_D2s_v3'

@description('The shared image ID for the VM.')
param sharedImageId string = '/subscriptions/87c4f245-4b87-4887-9b25-6aeaaa0e3e6c/resourceGroups/ITJH-IMAGES-PROD-RG/providers/Microsoft.Compute/images/ITJH_WS2022_2024-04_128GB'

@description('Select an existing Virtual Network')
@allowed([
  'AZ-East2-JH-CITRIX-DR-10.154.208.0-20'
])
param vnetName string = 'AZ-East2-JH-CITRIX-DR-10.154.208.0-20'

@description('Select an existing Virtual Network resource group')
@allowed([
    'JH-CITRIX-PROD-RG'
  ])
param vnetResourceGroup string = 'JH-CITRIX-PROD-RG'

@description('Select a subnet name from the selected Virtual Network')
@allowed([
  'AZ-East2-JH-CITRIX-DR-10.154.208.0-24'
])
param subnetName string = 'AZ-East2-JH-CITRIX-DR-10.154.208.0-24'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Admin Username for the virtual machine')
param adminUsername string = 'CloudADM'

@description('Admin Password for the virtual machine')
@secure()
param adminPassword string

@description('Tags to be applied to resources')
param tags object = {
  environment: 'AzFormTest'
  project: 'Created by a 16-vm'
}

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

// Create a network interface without a public IP address
resource nic 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: '${vmName}-nic'
  location: location
  tags: tags
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
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: virtualMachineSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
      imageReference: {
        id: sharedImageId
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
