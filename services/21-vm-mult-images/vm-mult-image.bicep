@description('Name of the virtual machine. Ensure the name starts with JHCTX. No more than 15 characters')
param vmName string = 'JHCTX'

@description('Choose the virtual machine size. Default is Standard_D2s_v3.')
@allowed([
  'Standard_D2s_v3'
  'Standard_D2s_v4'
  'Standard_D2s_v5'
  'Standard_D4s_v5'
])
param virtualMachineSize string = 'Standard_D2s_v3'

@description('Choose the shared image.')
@allowed([
  'ITJH_WS2022_2024-04_128GB'
  'Image_Name'
])
param sharedImageShortName string = 'ITJH_WS2022_2024-04_128GB'

// Mapping of short names to full image IDs
var sharedImageIds = {
  'ITJH_WS2022_2024-04_128GB': '/subscriptions/87c4f245-4b87-4887-9b25-6aeaaa0e3e6c/resourceGroups/ITJH-IMAGES-PROD-RG/providers/Microsoft.Compute/galleries/ITJH_Windows_OS_Image_Gallery/images/WS2022_2024-04_128GB'
  Image_Name: '/subscriptions/87c4f245-4b87-4887-9b25-6aeaaa0e3e6c/resourceGroups/Another-RG/providers/Microsoft.Compute/galleries/Another_Gallery/images/Another_Image'
}

var sharedImageId = sharedImageIds[sharedImageShortName]

// Hardcoded networking values
var vnetName = 'AZ-East2-JH-CITRIX-PROD-10.156.80.0-20'
var vnetResourceGroup = 'JH-CITRIX-PROD-RG'
var subnetName = 'AZ-East2-JH-CITRIX-PROD-10.156.81.0-24'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Admin Username for the virtual machine')
param adminUsername string = 'CloudADM'

@description('Admin Password for the virtual machine')
@secure()
param adminPassword string

@description('Additional part of the cmdb_pas tag to be appended after "Cloud-Citrix-"')
param cmdbPasSuffix string ='Cloud-Citrix-'

@description('Tags to be applied to resources')
var tags = {
  Environment: 'Test'
  Project: 'AzFormDeployment'
  Image: sharedImageShortName
  Version: 'Created by 21-vm'
  cmdb_pas: cmdbPasSuffix
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
